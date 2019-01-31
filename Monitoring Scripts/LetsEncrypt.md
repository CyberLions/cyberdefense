# Let's Encrypt Certificate Process

## Nginx on Ubuntu 18.04 LTS (bionic)

```bash
sudo apt-get update
sudo apt-get install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install certbot python-certbot-nginx

sudo certbot --nginx # automated
sudo certbot --nginx certonly # generate certs, but you add these to config manually
```