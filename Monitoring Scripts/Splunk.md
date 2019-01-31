Splunk Light Quick Install Guide
===============================

*Splunk Light on Linux using the RPM package, the DEB package, or the .tgz file.*

Borrows a lot from https://docs.splunk.com/Documentation/SplunkLight/7.2.3/Installation/InstallonLinux.

-------------------------------

When you run the installation as `root` and use the RPM package or the DEB package, Splunk Light creates the `splunk` user. Otherwide, make the `splunk` user.

After you create the Splunk user, make sure that it has permissions to read and execute the installer file.

The RPM and DEB packages install Splunk Light into `/opt/splunk` by default. You can specify another directory for the RPM install.

The .tgz file installs into the current working directory. If you want to install it into another directory, move the file there before you install.

-------------------------------

Downloads
---------

### Splunk Light
https://www.splunk.com/en_us/download/splunk-light.html#tabs/linux

RPM: `wget -O splunklight-7.2.3-06d57c595b80-linux-2.6-x86_64.rpm 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.2.3&product=splunk_light&filename=splunklight-7.2.3-06d57c595b80-linux-2.6-x86_64.rpm&wget=true'` | MD5 (splunklight-7.2.3-06d57c595b80-linux-2.6-x86_64.rpm) = e2b8b29ad86e7280098a87b3f73cf437

DEB: `wget -O splunklight-7.2.3-06d57c595b80-linux-2.6-amd64.deb 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.2.3&product=splunk_light&filename=splunklight-7.2.3-06d57c595b80-linux-2.6-amd64.deb&wget=true'` | MD5 (splunklight-7.2.3-06d57c595b80-linux-2.6-amd64.deb) = 729a370652f929cadded134eddfe1bea

.tgz: `wget -O splunklight-7.2.3-06d57c595b80-Linux-x86_64.tgz 'https://www.splunk.com/bin/splunk/DownloadActivityServlet?architecture=x86_64&platform=linux&version=7.2.3&product=splunk_light&filename=splunklight-7.2.3-06d57c595b80-Linux-x86_64.tgz&wget=true'` | MD5 (splunklight-7.2.3-06d57c595b80-Linux-x86_64.tgz) = 9d6cf6f183ec0b7854645255d56c28f5

### Splunk Universal Forwarder
https://www.splunk.com/en_us/download/universal-forwarder.html

-------------------------------

RPM
---

```bash
rpm -i splunk_package_name.rpm
splunk start --accept-license
./splunk enable boot-start # start on boot
```

DEB
---

```bash
dpkg -i splunk_package_name.deb
splunk start --accept-license
```

.tgz
----

```bash
# mkdir /opt/splunk # if needed
mv splunk_package_name.tgz /opt/splunk
tar xvzf splunk_package_name.tgz
splunk/bin/splunk start --accept-license
```

-------------------------------

Reverse Proxy
-------------

```bash
sudo apt install nginx
cd /etc/nginx/sites-enabled
sudo rm default
sudo nano default

...
server {
    listen 443 ssl;
    ssl_certificate /opt/splunk/ssl/cert.pem;
    ssl_certificate_key /opt/splunk/ssl/key.pem;
    location / {
        proxy_pass http://127.0.0.1:8000;
    }
}

server {
    listen 80;
    server_name <ip or hostname>;
    return 301 https://$host$request_uri;
}

... [ CTRL + X, Y, <Enter> ]

cd /opt/splunk
sudo mkdir ssl
cd ssl
sudo openssl req -newkey rsa:2048 -nodes -keyout key.pem -x509 -days 365 -out cert.pem # set common name to server ip/hostname

nginx -t # to make sure config is good

nginx -s reload

```

-------------------------------

Splunk Enterprise with Docker
=============================

```bash
docker pull splunk/splunk:latest
docker run -d -p 8000:8000 -e 'SPLUNK_START_ARGS=--accept-license' -e 'SPLUNK_PASSWORD=<good 8 char+ password>' splunk/splunk:latest
```