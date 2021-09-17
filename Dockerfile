ARG GO_VERSION=1.17

FROM golang:${GO_VERSION}-alpine AS builder


# bzr is not supported anymore https://pkgs.alpinelinux.org/package/v3.10/community/x86_64/bzr
RUN apk add --update --no-cache bash make curl git mercurial breezy

ENV GOFLAGS="-mod=readonly"

RUN mkdir -p /build
WORKDIR /build

COPY go.* /build/
RUN go mod download

COPY . /build
RUN make build.linux

FROM alpine:3.14

COPY --from=builder /build/build/linux/kube-metrics-adapter /

ENTRYPOINT ["/kube-metrics-adapter"]
