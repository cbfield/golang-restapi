FROM golang:1.12 AS build
RUN mkdir /usr/src/app
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN go get -d
RUN go build -o /usr/src/app/main

FROM alpine:latest AS runtime
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/main .
CMD ["/usr/src/app/main"]
