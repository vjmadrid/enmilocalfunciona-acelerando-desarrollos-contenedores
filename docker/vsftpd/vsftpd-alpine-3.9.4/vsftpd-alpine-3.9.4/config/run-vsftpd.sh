#!/bin/bash


echo
echo "*** CONFIG FTP MODE ***"

# Define ftp configuration (Default : ftp)
FTP_MODE=${FTP_MODE:-ftp}

if [[ "$FTP_MODE" =~ ^(ftp|ftps|ftps_implicit|ftps_tls)$ ]]; then
    echo "* Valid FTP_MODE -> $FTP_MODE"
else
    echo "ERROR : $FTP_MODE is not a supported FTP mode (ftp, ftps, ftps_implicit or ftps_tls)"
    exit 1
fi

if [[ "$FTP_MODE" == "ftp" ]] && [ ! -e /etc/vsftpd/private/vsftpd.pem ] 
then
    echo "* Generating self-signed certificate"
    mkdir -p /etc/vsftpd/private

    openssl req -x509 -nodes -days 7300 \
        -newkey rsa:2048 -keyout /etc/vsftpd/private/vsftpd.pem -out /etc/vsftpd/private/vsftpd.pem \
        -subj "/C=FR/O=ACME company/CN=acme.org"

    openssl pkcs12 -export -out /etc/vsftpd/private/vsftpd.pkcs12 -in /etc/vsftpd/private/vsftpd.pem -passout pass:

    chmod 755 /etc/vsftpd/private/vsftpd.pem
    chmod 755 /etc/vsftpd/private/vsftpd.pkcs12

    echo "* Self-signed certificate generated -> /etc/vsftpd/private/vsftpd.pem"
fi

echo "[EVN] FTP_MODE=${FTP_MODE}"



echo
echo "*** CONFIG USER / PASSWORD ***"

# Username for the default FTP account (Default : admin)
FTP_USER=${FTP_USER:-admin}

if [ "$FTP_USER" = "*Random*" ]; then
	# Generate a random user name for FTP_USER
    FTP_USER=`cat /dev/urandom | tr -dc A-Z-a-z-0-9 | head -c${1:-16}`
	echo "* Define user random -> *Random*"
fi

echo "[EVN] FTP_USER=${FTP_USER}"


# Password for the default user (Default : admin)
FTP_PASS=${FTP_PASS:-admin}

if [ "$FTP_PASS" = "*Random*" ]; then
	# Generate a random password for FTP_PASS
    FTP_PASS=`cat /dev/urandom | tr -dc A-Z-a-z-0-9 | head -c${1:-16}`
	echo "* Define password random -> *Random*"
fi

echo "[EVN] FTP_PASS=${FTP_PASS}"



echo
echo "*** CONFIG USER MODE ***"

# Define user configuration (Default : basic)
USER_MODE=${USER_MODE:-basic}

if [[ "$USER_MODE" =~ ^(basic|virtual)$ ]]; then
    echo "* Valid USER_MODE -> $USER_MODE"
else
    echo "ERROR : $USER_MODE is not a supported mode (basic or virtual)"
    exit 1
fi

echo "[EVN] USER_MODE=${USER_MODE}"



echo
echo "*** CONFIG PASSIVE MODE ***"

# Enable/disable the passive mode  (Default : YES)
PASV_ENABLE=${PASV_ENABLE:-YES}
# Address used during passive mode (Default : "")
PASV_ADDRESS=${PASV_ADDRESS:-}
# Extract the IP address of a network interface to set the PASV_ADDRESS dynamically (Default : eth0)-> Host machine or from another container
PASV_ADDRESS_INTERFACE=${PASV_ADDRESS_INTERFACE:-eth0}
# Active if use a hostname (as opposed to IP address) in the PASV_ADDRESS (Default : NO)
PASV_ADDR_RESOLVE=${PASV_ADDR_RESOLVE:-NO}
# Lower bound of the passive mode port range (Default : 21100)
PASV_MIN_PORT=${PASV_MIN_PORT:-21100}
# Upper bound of the passive mode port range (Default : 21110)
PASV_MAX_PORT=${PASV_MAX_PORT:-21110}

echo "[EVN] PASV_ENABLE=${PASV_ENABLE}"
echo "[EVN] PASV_ADDRESS=${PASV_ADDRESS}"
echo "[EVN] PASV_ADDRESS_INTERFACE=${PASV_ADDRESS_INTERFACE}"
echo "[EVN] PASV_ADDR_RESOLVE=${PASV_ADDR_RESOLVE}"
echo "[EVN] PASV_MIN_PORT=${PASV_MIN_PORT}"
echo "[EVN] PASV_MAX_PORT=${PASV_MAX_PORT}"


echo
echo "*** CONFIG LOG STDOUT ***"

# Enable/disable the log stdout  (Default : false)
LOG_STDOUT=${LOG_STDOUT:-false}

if [ "$LOG_STDOUT" == "false" ]; then
	echo "* Logging to STDOUT Disabled"
else
	echo "* Logging to STDOUT Enabled"
fi

echo "[EVN] LOG_STDOUT=${LOG_STDOUT}"



echo
echo "*** CONFIG VSFTPD ***"

echo "[CONF] Configure PASV_ADDRESS"

if [ -z "$PASV_ADDRESS" ]; then
    echo " * PASV_ADDRESS env variable is not set"

    if [ -n "$PASV_ADDRESS_INTERFACE" ]; then
        echo " * Attempt to guess the PASV_ADDRESS from PASV_ADDRESS_INTERFACE"
        PASV_ADDRESS=$(ip -o -4 addr list $PASV_ADDRESS_INTERFACE | head -n1 | awk '{print $4}' | cut -d/ -f1)
        
        if [ -z "$PASV_ADDRESS" ]; then
            echo " * Could not find IP for interface '$PASV_ADDRESS_INTERFACE', exiting"
            exit 1
        fi
        
        echo " * Found address '$PASV_ADDRESS' for interface '$PASV_ADDRESS_INTERFACE'"
    fi
else
    echo "PASV_ADDRESS is set so we use it directly"
fi



echo
echo "*** CONFIG VSFTPD ***"

echo "[CONF] Configure USER_MODE"

if [ "$USER_MODE" = "basic" ]; then
    
	# Add the FTP_USER, change his password and declare him as the owner of his home folder and all subfolders
    addgroup -g 433 -S $FTP_USER
    adduser -u 431 -D -G $FTP_USER -h /home/vsftpd/$FTP_USER -s /bin/false  $FTP_USER

    echo "$FTP_USER:$FTP_PASS" | /usr/sbin/chpasswd

    chown -R $FTP_USER:$FTP_USER /home/vsftpd/$FTP_USER
else
    # Create home dir and update vsftpd user db
    mkdir -p "/home/vsftpd/${FTP_USER}"
    echo "[CONF] Created home directory for user ${FTP_USER} -> /home/vsftpd/${FTP_USER}"

    # Add new user
    echo -e "${FTP_USER}\n${FTP_PASS}" > /etc/vsftpd/virtual_users.txt
    echo "[CONF] Updated /etc/vsftpd/virtual_users.txt with user ${FTP_USER}"

    # Update vsftpd database with the new user
    /usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db
    echo "[CONF] Updated vsftpd database -> load with /etc/vsftpd/virtual_users.txt"
fi




echo
echo "*** BUILD vsftpd.conf ***"

CONF_FILE_VSFTPD=/etc/vsftpd/vsftpd.conf
echo "[CONF] Configure CONF_FILE_VSFTPD local var -> ${CONF_FILE_VSFTPD}" 

echo "# *** Conf BASE ***" >> $CONF_FILE_VSFTPD
more /etc/vsftpd/vsftpd-base.conf >> $CONF_FILE_VSFTPD
echo "[CONF] Add /etc/vsftpd/vsftpd-base.conf >> ${CONF_FILE_VSFTPD}" 

echo "# *** Conf FTP mode -> ${FTP_MODE}  ***" >> $CONF_FILE_VSFTPD
more /etc/vsftpd/vsftpd-${FTP_MODE}.conf >> $CONF_FILE_VSFTPD
echo "[CONF] Append /etc/vsftpd/vsftpd-${FTP_MODE}.conf >> ${CONF_FILE_VSFTPD}" 




echo
echo "*** UPDATE vsftpd.conf ***"
echo "[CONF] Update CONF_FILE_VSFTPD with new properties according to env variables and/or static values -> ${CONF_FILE_VSFTPD}" 

echo "" >> $CONF_FILE_VSFTPD
echo "# *** Conf run-vsftpd.sh script ***" >> $CONF_FILE_VSFTPD

# Log Stdout
#if [ "$LOG_STDOUT" == "true" ]; then
#	echo "# Log Stdout" >> $CONF_FILE_VSFTPD
#fi

# Anonymous mode
echo " * Add Anonymous Mode"

echo "# Anonymous Mode" >> $CONF_FILE_VSFTPD
echo "anonymous_enable=NO" >> $CONF_FILE_VSFTPD

# Passive mode
if [ "$PASV_ENABLE" == "YES" ]; then
    echo " * Add Passive Mode"

    echo "# Passive Mode" >> $CONF_FILE_VSFTPD
    echo "pasv_enable=$PASV_ENABLE" >> $CONF_FILE_VSFTPD # Set to NO if you want to disallow the PASV method of obtaining a data connection
    echo "pasv_address=$PASV_ADDRESS" >> $CONF_FILE_VSFTPD # Passive Address that gets advertised by vsftpd when responding to PASV command
    echo "pasv_addr_resolve=$PASV_ADDR_RESOLVE" >> $CONF_FILE_VSFTPD
    echo "pasv_max_port=$PASV_MAX_PORT" >> $CONF_FILE_VSFTPD
    echo "pasv_min_port=$PASV_MIN_PORT" >> $CONF_FILE_VSFTPD
fi

# Show CONF_FILE_VSFTPD result
# cat $CONF_FILE_VSFTPD

# Run the vsftpd server
echo
echo "*** START VSFTPD ***"
echo "[START] VSFTPD daemon starting"
/usr/sbin/vsftpd $CONF_FILE_VSFTPD