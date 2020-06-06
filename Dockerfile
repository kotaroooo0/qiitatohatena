FROM golang:alpine as builder

RUN apk --no-cache add git && \
    go get github.com/tenntenn/qiitaexporter github.com/x-motemen/blogsync

FROM alpine

COPY --from=builder /go/bin/qiitaexporter /bin/qiitaexporter
COPY --from=builder /go/bin/blogsync /bin/blogsync

RUN apk --no-cache add libintl && \
    apk --no-cache add --virtual .gettext gettext && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del .gettext

WORKDIR /Documents
COPY blogsync.template /Documents
COPY setup.sh /Documents

RUN mkdir -p ~/.config/blogsync
COPY config.yaml.tmp /root/.config/blogsync

RUN chmod +x setup.sh
ENTRYPOINT ./setup.sh
