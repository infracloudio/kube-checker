FROM alpine:3.5
LABEL maintainer "Sanket Sudake <sanket@infracloud.io>"

ADD dist/kube-checker-job-amd64 /usr/bin/kube-checker-job
ENTRYPOINT ["/usr/bin/kube-checker-job"]
