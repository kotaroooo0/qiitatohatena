FROM golang:latest

RUN go get -u github.com/tenntenn/qiitaexporter
RUN go get -u github.com/x-motemen/blogsync

RUN apt-get update
RUN apt-get install gettext-base -y

WORKDIR /Documents
COPY blogsync.template /Documents
COPY setup.sh /Documents

RUN mkdir -p ~/.config/blogsync
COPY config.yaml.tmp /root/.config/blogsync

RUN chmod +x setup.sh
ENTRYPOINT ./setup.sh
