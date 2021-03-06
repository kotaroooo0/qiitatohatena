FROM golang:1.14-alpine as builder
RUN apk --no-cache add git=2.26.2-r0 && \
    go get github.com/tenntenn/qiitaexporter github.com/x-motemen/blogsync

FROM alpine:3.12

WORKDIR /Documents
COPY setup.sh blogsync.template /Documents/
RUN chmod +x setup.sh

RUN mkdir -p ~/.config/blogsync
COPY config.yaml.tmp /root/.config/blogsync

RUN apk --no-cache add libintl=0.20.2-r0 && \
    apk --no-cache add --virtual .gettext gettext=0.20.2-r0 && \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del .gettext

COPY --from=builder /go/bin/qiitaexporter /bin/qiitaexporter
COPY --from=builder /go/bin/blogsync /bin/blogsync

ENTRYPOINT ["./setup.sh"]
