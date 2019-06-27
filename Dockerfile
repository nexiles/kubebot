FROM golang:1.12.5

RUN wget http://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl -O /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

CMD ["app"]
