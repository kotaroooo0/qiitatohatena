FROM golang:1.14-alpine

RUN RUN apk --no-cache add libintl && \
    apk --no-cache add --virtual .gettext gettext && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del .gettext && \
    go get github.com/tenntenn/qiitaexporter \
    github.com/x-motemen/blogsync

WORKDIR /Documents
COPY blogsync.template /Documents
COPY setup.sh /Documents

RUN mkdir -p ~/.config/blogsync
COPY config.yaml.tmp /root/.config/blogsync

RUN chmod +x setup.sh
ENTRYPOINT ./setup.sh
