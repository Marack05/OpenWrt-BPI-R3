openssl genrsa -des3 -out rackley.app.key 4096
openssl req -new -x509 -days 365 -key rackley.app.key -out rackley.app.crt
