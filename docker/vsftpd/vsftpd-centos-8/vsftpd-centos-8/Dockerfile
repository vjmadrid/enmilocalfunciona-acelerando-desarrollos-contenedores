FROM centos:8

ARG USER_ID=14
ARG GROUP_ID=50

RUN yum -y update \ 
	&& yum clean all \
	&& yum install -y vsftpd iproute \
	&& yum clean all

RUN usermod -u ${USER_ID} ftp
RUN groupmod -g ${GROUP_ID} ftp

COPY ./config/vsftpd.conf /etc/vsftpd/
COPY ./config/vsftpd_virtual /etc/pam.d/
COPY ./config/run-vsftpd.sh /usr/sbin/

RUN chmod +x /usr/sbin/run-vsftpd.sh
RUN mkdir -p /home/vsftpd/
RUN chown -R ftp:ftp /home/vsftpd/

ENV ANONYMOUS_ACCESS=false \
	PASV_ENABLE=YES \
	PASV_ADDRESS=**IPv4** \
	PASV_ADDR_RESOLVE=NO \
	PASV_MIN_PORT=21100 \
	PASV_MAX_PORT=21110 \
	XFERLOG_STD_FORMAT=NO \
	FILE_OPEN_MODE=0666 \
	LOCAL_UMASK=022 \
	REVERSE_LOOKUP_ENABLE=YES \
	PASV_PROMISCUOUS=NO \
	PORT_PROMISCUOUS=NO

CMD ["/usr/sbin/run-vsftpd.sh"]
