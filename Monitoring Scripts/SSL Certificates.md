# Making SSL Certs

```bash
openssl req -x509 -out localhost.crt -keyout localhost.key \
  -newkey rsa:2048 -nodes -sha256 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth")
```

## Sample NGINX config

move certs to `/usr/local/nginx/conf/` as this is the directory in the config below

```text
server {

    listen 443 default_server;
    server_name www.example.com;

    # ssl on; # deprecated
    ssl_certificate /usr/local/nginx/conf/localhost.pem;
    ssl_certificate_key /usr/local/nginx/conf/localhost.key;
    ssl_session_cache shared:SSL:10m;

    location / {

        proxy_pass http://localhost:8000; # or whatever port you are proxying
        proxy_set_header Host $host;

        # re-write redirects to http as to https, example: /home
        proxy_redirect http:// https://;
    }
}


```