swagger generate server -f design/spec/swagger.yaml -t ./pkg/
mv pkg/cmd/kubechecker-server/main.go .
rm -r pkg/cmd
