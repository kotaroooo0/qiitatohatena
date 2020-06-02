FROM golang:latest

RUN go get -u github.com/tenntenn/qiitaexporter
RUN go get -u github.com/x-motemen/blogsync

WORKDIR /go/src/app

ADD blogsync.template /go/src/app
ADD config.yaml ~/.config/blogsync
ADD setup.sh /go/src/app

CMD sh setup.sh
