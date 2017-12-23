go build
CERT_DIR=/tmp/kube-checker
mkdir -p $CERT_DIR
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout $CERT_DIR/dev.key -out $CERT_DIR/dev.crt \
    -subj "/C=IN/ST=MH/L=Pune/CN=kubechecker.com/emailAddress=sanket@infracloud.com"

./kube-checker --tls-certificate $CERT_DIR/dev.crt --tls-key $CERT_DIR/dev.key

