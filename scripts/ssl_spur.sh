# create
  sudo openssl req -newkey rsa:2048 -nodes -keyout domain.key -out domain.csr
  # or
  sudo openssl req -key domain.key -new -out domain.csr

# crt sum
  sudo openssl x509 -noout -modulus -in domain.crt | openssl md5

# key sum
  sudo openssl rsa -noout -modulus -in domain.key | openssl md5

# generate crt from key & csr
  sudo openssl x509 -signkey domain.key -in domain.csr -req -days 365 -out domain.crt
