Ubuntu 16.05 Desktop Lockdown Script
====================================

```bash

#Critical stigs for Ubuntu 16.05 for CCDC Competition. Petr Esakov

#Check for security updates V-75391
/usr/lib/update-notifier/apt-check --human-readable

#Limit number of concurrent connections V-75443
echo "* hard maxlogins 10" >> /etc/security/limit.conf

#Lock root account V-75445
passwd -l root

#Password complexity  V-75449
grep -i "ucredit" /etc/security/pwquality.conf
echo "ucredit=-1" >> /etc/security/pwquality.conf

grep -i "lcredit" /etc/security/pwquality.conf
echo "lcredit=-1" >> /etc/security/pwquality.conf

grep -i "dcredit" /etc/security/pwquality.conf
echo "dcredit=-1" >> /etc/security/pwquality.conf

grep -i "ocredit" /etc/security/pwquality.conf
echo "ocredit=-1" /etc/security/pwquality.conf

grep -i "difok" /etc/security/pwquality.conf
echo "difok=8" /etc/security/pwquality.conf

#Checks password hashing method--  Has to be SHA512 V-75459
cat /etc/login.defs | grep -i crypt

#Checks all current password encryption methods.-- "!" or "*" indicate inactive. **Active accts must begin with $6** V-75461
sudo cut -d: -f2 /etc/shadow
#Lock accts with unsecure encryption methods


```