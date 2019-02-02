# Linux Security Checklist

## Remote and Local Administration

* [ ] Open terminal -> `service sshd stop`
* [ ] Change root password -> `passwd`
* [ ] Add a non-root user -> `useradd -m -s /bin/bash <name>` -> `passwd <name>`
```
Debian/Ubuntu
usermod -aG sudo <name>
CentOS/RHEL
usermod -aG wheel <name>
```
* [ ] Disable root login in sshd.conf -> `/etc/ssh/sshd_config`
```
PermitRootLogin no
```
* [ ] Remove any keys that exist in .ssh
* [ ] Create new keys -> `ssh-keygen -t rsa` -> `ssh-copy-id ~/.ssh/<id> user@<ip-address>` -> set strong password
* [ ] Disable password login and use keys in sshd.conf
```
ChallengeResponseAuthentication no
PasswordAuthentication no
UsePAM no
```
* [ ] Setup firewall with iptables or PaloAlto
* [ ] Install BFD if possible
```
wget http://www.rfxnetworks.com/downloads/bfd-current.tar.gz
tar -xzvf bfd-current.tar.gz 
cd bfd-1.5/
./install.sh
```
* [ ] Start sshd back up
* [ ] Verify keys work
* [ ] Change keys often
* [ ] Look for hidden directories

## Database Security

* [ ] Change or add a password for mysql or postgres

## Web Security

* [ ] Lock down access to phpmyadmin
```bash
cd /etc/phpmyadmin/apache.conf
Alias /<something_else> /usr/share/phpmyadmin
```
* [ ] `tail -f /var/log/http/access.log`
* [ ] Install ModSecurity
```
#Ubuntu/Debian
sudo apt-get install libapache-mod-security
#CentOS
yum install mod_security
```

## Misc

* Listing running processes
```
ps ax
ps aux <username>
```
* Listing listening ports
```
# netstat
netstat -ano
# lsof
lsof -nPi
```
* Check authorized ssh users and make sure they are blank or contain known entries
```
~/.ssh/authorized_keys
/root/.ssh/authorized_keys
```
* Stop/start/restart a service
```
service <servicename> start/stop/restart
```
* Check for accounts that have no passwords
```
awk -F: '($2 == "") {print}' /etc/shadow
```
* Linux kernel hardening
```
Edit /etc/sysctl.conf
# Turn on execshield
kernel.exec-shield=1
kernel.randomize_va_space=1
# Enable IP spoofing protection
net.ipv4.conf.all.rp_filter=1
# Disable IP source routing
net.ipv4.conf.all.accept_source_route=0
# Ignoring broadcasts request
net.ipv4.icmp_echo_ignore_broadcasts=1
net.ipv4.icmp_ignore_bogus_error_messages=1
# Make sure spoofed packets get logged
net.ipv4.conf.all.log_martians = 1
```
