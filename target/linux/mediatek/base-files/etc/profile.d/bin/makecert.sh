openssl req -new -key rackley.app.key -out rackley.app.csr
openssl x509 -req -days 365 -in rackley.app.csr -CA rackley.app.crt -CAkey rackley.app.key -set_serial 1 -out rackley.app.crt -setalias "Self Signed SMIME" -addtrust emailProtection -addreject clientAuth -addreject serverAuth -trustout
openssl pkcs12 -export -in rackley.app.crt -inkey rackley.app.key -out rackley.app.p12
cat rackley.app.crt rackley.app.crt >> rackley.app.pem
