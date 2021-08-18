FROM alpine:3.14.1

# This hack is widely applied to avoid python printing issues in docker containers.
# See: https://github.com/Docker-Hub-frolvlad/docker-alpine-python3/pull/13
ENV PYTHONUNBUFFERED=1

RUN apk update \
	&& apk upgrade \
    && echo "*** Install Python ***" \
	&& apk --update --no-cache add bash \
	&& rm -rf /tmp/* /var/cache/apk/*

COPY ./config/run-pypi.sh /usr/sbin/
RUN chmod +x /usr/sbin/run-pypi.sh

CMD ["/usr/sbin/run-pypi.sh"]
