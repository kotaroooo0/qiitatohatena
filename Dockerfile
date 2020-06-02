FROM golang:latest

RUN go get -u github.com/tenntenn/qiitaexporter
RUN go get -u github.com/x-motemen/blogsync

WORKDIR /Documents
ADD blogsync.template /Documents
ADD setup.sh /Documents

RUN mkdir -p ~/.config/blogsync
ADD config.yaml /root/.config/blogsync

RUN chmod +x setup.sh
CMD ./setup.sh
