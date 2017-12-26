FROM alpine:3.5
LABEL maintainer "Sanket Sudake <sanket@infracloud.io>"

ADD dist/kube-checker-api-amd64 /usr/bin/kube-checker-api
ENTRYPOINT ["/usr/bin/kube-checker-api"]
