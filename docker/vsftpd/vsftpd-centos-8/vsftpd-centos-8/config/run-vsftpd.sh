#!/bin/bash

echo $'\n*** CONFIG ENVIRONMENT VARIABLES ***'


# If the variable FTP_USER does not exist
if [ -z "$FTP_USER" ]; then
	# Define default 'admin' user
    export FTP_USER='admin'
	echo "Define user by default"
elif [ "$FTP_USER" = "*Admin*" ]; then
	# Define default 'admin' user
    export FTP_USER='admin'
	echo "Define user by default -> *Admin*"
elif [ "$FTP_USER" = "*Random*" ]; then
	# Generate a random user name for FTP_USER
    export FTP_USER=`cat /dev/urandom | tr -dc A-Z-a-z-0-9 | head -c${1:-16}`
	echo "Define user random -> *Random*"
fi

echo "[EVN] FTP_USER=${FTP_USER}"


# If the variable FTP_PASS does not exist
if [ -z "$FTP_PASS" ]; then
	echo "$FTP_PASS no exist"
	exit
elif [ "$FTP_PASS" = "*Random*" ]; then
	# Generate a random password for FTP_PASS
    export FTP_PASS=`cat /dev/urandom | tr -dc A-Z-a-z-0-9 | head -c${1:-16}`
	echo "Define password random -> *Random*"
fi

echo "[EVN] FTP_PASS=${FTP_PASS}"


# If the variable ANONYMOUS_ACCESS does not exist
if [ -z "$ANONYMOUS_ACCESS" ]; then
	# Define default 'false' value
    export ANONYMOUS_ACCESS='false'
	echo "Define anonymous access with false by default"
elif [ "$ANONYMOUS_ACCESS" = "*Boolean*" ]; then
	# Define default 'false' value
    export ANONYMOUS_ACCESS='false'
	echo "Define anonymous access with false by default -> *Boolean*"
fi

echo "[EVN] ANONYMOUS_ACCESS=${ANONYMOUS_ACCESS}"

if [ "${ANONYMOUS_ACCESS}" = "true" ]; then
	sed -i "s|anonymous_enable=NO|anonymous_enable=YES|g" /etc/vsftpd/vsftpd.conf
	echo $'\t * Change property anonymous_enable=YES -> /etc/vsftpd/vsftpd.conf'
else
	sed -i "s|anonymous_enable=YES|anonymous_enable=NO|g" /etc/vsftpd/vsftpd.conf
	echo $'\t * Change property anonymous_enable=NO -> /etc/vsftpd/vsftpd.conf'
fi



# If the variable LOG_STDOUT does not exist
if [ -z "$LOG_STDOUT" ]; then
	export LOG_STDOUT='false'
	echo "Define log stdout with false by default"
elif [ "$LOG_STDOUT" = "**Boolean**" ]; then
    export LOG_STDOUT='false'
	echo "Define log stdout with false by default"
fi

echo "[EVN] LOG_STDOUT=${LOG_STDOUT}"


# Set passive mode parameters
if [ -z "$PASV_ADDRESS" ]; then
	echo "Use passive mode by default"
	export PASV_ADDRESS=''
elif [ "$PASV_ADDRESS" = "**IPv4**" ]; then
    export PASV_ADDRESS=$(/sbin/ip route|awk '/default/ { print $3 }')
fi

# Custom passive address settings
if [ "${CUSTOM_PASSIVE_ADDRESS}" != "false" ]; then
	sed -i "s|pasv_address=|pasv_address=${CUSTOM_PASSIVE_ADDRESS}|g" /etc/vsftpd/vsftpd.conf
	export PASV_ADDRESS=${CUSTOM_PASSIVE_ADDRESS}
	echo " * Change property pasv_address=${CUSTOM_PASSIVE_ADDRESS} -> /etc/vsftpd/vsftpd.conf"
fi

echo "[EVN] PASV_ADDRESS=${PASV_ADDRESS}"


echo $'\n*** CONFIG VSFTPD ***'


# Create home dir and update vsftpd user db
mkdir -p "/home/vsftpd/${FTP_USER}"
echo "[CONF] Created home directory for user ${FTP_USER} -> /home/vsftpd/${FTP_USER}"


# Add new user
echo -e "${FTP_USER}\n${FTP_PASS}" > /etc/vsftpd/virtual_users.txt
echo "[CONF] Updated /etc/vsftpd/virtual_users.txt with user ${FTP_USER}"


# Update vsftpd database with the new user
/usr/bin/db_load -T -t hash -f /etc/vsftpd/virtual_users.txt /etc/vsftpd/virtual_users.db
echo "[CONF] Updated vsftpd database -> load with /etc/vsftpd/virtual_users.txt"


echo $'\n*** CONFIG vsftpd.conf ***'
# Add new properties with command echo + >>


#echo "pasv_enable=${PASV_ENABLE}" >> /etc/vsftpd/vsftpd.conf
#echo "pasv_address=${PASV_ADDRESS}" >> /etc/vsftpd/vsftpd.conf
#echo "pasv_addr_resolve=${PASV_ADDR_RESOLVE}" >> /etc/vsftpd/vsftpd.conf
#echo "pasv_min_port=${PASV_MIN_PORT}" >> /etc/vsftpd/vsftpd.conf
#echo "pasv_max_port=${PASV_MAX_PORT}" >> /etc/vsftpd/vsftpd.conf

echo "file_open_mode=${FILE_OPEN_MODE}" >> /etc/vsftpd/vsftpd.conf
echo "xferlog_std_format=${XFERLOG_STD_FORMAT}" >> /etc/vsftpd/vsftpd.conf
echo "reverse_lookup_enable=${REVERSE_LOOKUP_ENABLE}" >> /etc/vsftpd/vsftpd.conf
echo "pasv_promiscuous=${PASV_PROMISCUOUS}" >> /etc/vsftpd/vsftpd.conf 
echo "port_promiscuous=${PORT_PROMISCUOUS}" >> /etc/vsftpd/vsftpd.conf

echo "local_umask=${LOCAL_UMASK}" >> /etc/vsftpd/vsftpd.conf


# Local Umask
echo "[EVN] LOCAL_UMASK=${LOCAL_UMASK}"


echo $'\n*** CONFIG PASSIVE MODE ***'

echo "[EVN] PASV_ENABLE=${PASV_ENABLE}"

if [ -z "$PASV_ENABLE" ]; then
	echo "Use passive mode by default"
	export PASV_ADDRESS=''
elif [ "$PASV_ADDRESS" = "YES" ]; then
    echo "[EVN] PASV_ADDRESS=${PASV_ADDRESS}"
	echo "[EVN] PASV_MIN_PORT=${PASV_MIN_PORT}"
	echo "[EVN] PASV_MAX_PORT=${PASV_MAX_PORT}"
	echo "[EVN] PASV_ADDR_RESOLVE=${PASV_ADDR_RESOLVE}"
fi


echo $'\n*** CONFIG LOGGING ***'

# Get log file path
export LOG_FILE=`grep xferlog_file /etc/vsftpd/vsftpd.conf|cut -d= -f2`
echo "[CONF] Get log file path"
echo "[EVN] LOG_FILE=${LOG_FILE}"
echo "[EVN] LOG_STDOUT=${LOG_STDOUT}"


if [ "$LOG_STDOUT" == "false" ]; then
	echo "Logging to STDOUT Disabled"
else
    # /usr/bin/ln -sf /dev/stdout $LOG_FILE
	mkdir -p /var/log/vsftpd
	touch ${LOG_FILE}
	tail -f ${LOG_FILE} | tee /dev/fd/1 &
	echo "Logging to STDOUT Enabled"
fi


# Set permissions for FTP user
chown -R ftp:ftp /home/vsftpd/
echo "[CONF] Set fixed permissions for user : ${FTP_USER}"


echo $'\n*** START VSFTPD ***'

# Run vsftpd
echo "[START] VSFTPD daemon starting"
&>/dev/null /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
