FROM golang:latest

RUN apt-get update && apt-get install -y \
    gettext-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && go get github.com/tenntenn/qiitaexporter \
    github.com/x-motemen/blogsync

WORKDIR /Documents
COPY blogsync.template /Documents
COPY setup.sh /Documents

RUN mkdir -p ~/.config/blogsync
COPY config.yaml.tmp /root/.config/blogsync

RUN chmod +x setup.sh
ENTRYPOINT ./setup.sh
