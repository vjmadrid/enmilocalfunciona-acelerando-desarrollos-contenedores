FROM alpine:3.14.1

ARG USER_ID=14
ARG GROUP_ID=50

RUN apk update \
	&& apk upgrade \
	&& apk --update --no-cache add bash openssl vsftpd db-utils linux-pam-dev \
	&& rm -rf /tmp/* /var/cache/apk/*

#RUN openssl req -x509 -nodes -days 7300 \
#            -newkey rsa:2048 -keyout /etc/vsftpd/vsftpd.pem -out /etc/vsftpd/vsftpd.pem \
#            -subj "/C=FR/O=ACME company/CN=acme.org"

RUN mkdir -p /home/vsftpd/
RUN chown -R ftp:ftp /home/vsftpd/

COPY ./config/vsftpd-base.conf /etc/vsftpd/vsftpd-base.conf
COPY ./config/vsftpd-ftp.conf /etc/vsftpd/vsftpd-ftp.conf
COPY ./config/vsftpd-ftps.conf /etc/vsftpd/vsftpd-ftps.conf
COPY ./config/vsftpd-ftps_implicit.conf /etc/vsftpd/vsftpd-ftps_implicit.conf
COPY ./config/vsftpd-ftps_tls.conf /etc/vsftpd/vsftpd-ftps_tls.conf

COPY ./config/virtual/vsftpd_virtual_file /etc/pam.d/vsftpd_virtual

COPY ./config/run-vsftpd.sh /usr/sbin/
RUN chmod +x /usr/sbin/run-vsftpd.sh

CMD ["/usr/sbin/run-vsftpd.sh"]
