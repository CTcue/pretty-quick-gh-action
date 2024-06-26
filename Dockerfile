FROM node:18.18.2-bookworm
RUN apk update && apk upgrade && apk add --no-cache bash git openssh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
