# Fedora Server 29

WIP, also several items pulled from static.open-scap.org

## Observations
Installing the Fedora 29 Server image in VMware, I noticed that there's a web interface open by default on port 9090 (https, self/not signed) with an auth portal.  We will likely want to restrict what addresses, if any, can access this.  Terminal can be accessed via this portal.  

## QUICK TIPS
### Package Manager Tips
yum or dnf (next gen replacement for yum)

<details><summary>man yum</summary>
<p>

```bash
yum [options] [command] [package ...]

* install package1 [package2] [...]
* update [package1] [package2] [...]
* update-to [package1] [package2] [...]
* update-minimal [package1] [package2] [...]
* check-update
* upgrade [package1] [package2] [...]
* upgrade-to [package1] [package2] [...]
* distribution-synchronization [package1] [package2] [...]
* remove | erase package1 [package2] [...]
* autoremove [package1] [...]
* list [...]
* info [...]
* provides | whatprovides feature1 [feature2] [...]
* clean [ packages | metadata | expire-cache | rpmdb | plugins | all
]
* makecache [fast]
* groups [...]
* search string1 [string2] [...]
* shell [filename]
* resolvedep dep1 [dep2] [...]
    (maintained for legacy reasons only - use repoquery or yum
provides)
* localinstall rpmfile1 [rpmfile2] [...]
    (maintained for legacy reasons only - use install)
* localupdate rpmfile1 [rpmfile2] [...]
    (maintained for legacy reasons only - use update)
* reinstall package1 [package2] [...]
* downgrade package1 [package2] [...]
* deplist package1 [package2] [...]
* repolist [all|enabled|disabled]
* repoinfo [all|enabled|disabled]
* repository-packages <enabled-repoid> <install|remove|remove-or-
reinstall|remove-or-distribution-synchronization> [package2] [...]
* version [ all | installed | available | group-* | nogroups* |
grouplist | groupinfo ]
* history [info|list|packages-list|packages-info|summary|addon-
info|redo|undo|rollback|new|sync|stats]
* load-transaction [txfile]
* updateinfo [summary | list | info | remove-pkgs-ts | exclude-
updates | exclude-all | check-running-kernel]
* fssnapshot [summary | list | have-space | create | delete]
* fs [filters | refilter | refilter-cleanup | du]
* check
* help [command]

Unless the --help or -h option is given, one of the above commands
must be present.
```

</p>
</details>

<details><summary>man dnf</summary>
<p>

```bash
dnf [options] <command> [<args>...]   

    autoremove 
    check-update 
    clean 
    distro-sync 
    downgrade 
    group 
    help 
    history 
    info 
    install 
    list 
    makecache 
    provides 
    reinstall 
    remove 
    repolist 
    repository-packages 
    search 
    updateinfo 
    upgrade 
    upgrade-to

```

</p>
</details>


## Software & Configs

### Replace sendmail with postfix
`$ sudo dnf erase sendmail`

`$ sudo dnf install postfix`

[The sendmail software was not developed with security in mind and its design prevents it from being effectively contained by SELinux. Postfix should be used instead.](https://static.open-scap.org/ssg-guides/ssg-fedora-guide-ospp.html#xccdf_org.ssgproject.content_rule_package_sendmail_removed)

### Remove Automatic Bug Reporting Tool (abrt) 
`$ sudo dnf erase abrt`

### SSH Config Stuffs
edit `/etc/ssh/sshd_config`

`IgnoreUserKnownHosts yes` - provides additional assurance that remove login via SSH will require a password, even in the event of misconfiguration elsewhere.

`PermitEmptyPasswords no` - provides additional assurance that remote login via SSH will require a password, even in the event of misconfiguration elsewhere.

`Banner /etc/issue` - The warning message reinforces policy awareness during the logon process and facilitates possible legal action against attackers. Alternatively, systems whose ownership should not be obvious should ensure usage of a banner that does not provide easy attribution.

`KerberosAuthentication no` - Unless needed, SSH should not permit extraneous or unnecessary authentication mechanisms like Kerberos. 

`IgnoreRhosts yes` - SSH trust relationships mean a compromise on one host can allow an attacker to move trivially to other hosts.

If openssh-server version < 7.4, `RhostsRSAAuthentication no` - Configuring this setting for the SSH daemon provides additional assurance that remove login via SSH will require a password, even in the event of misconfiguration elsewhere.

`HostbasedAuthentication no` - SSH trust relationships mean a compromise on one host can allow an attacker to move trivially to other hosts.

`GSSAPIAuthentication no` - GSSAPI authentication is used to provide additional authentication mechanisms to applications. Allowing GSSAPI authentication through SSH exposes the system's GSSAPI to remote hosts, increasing the attack surface of the system.

`PermitRootLogin no` - self explanatory

### Federal Information Processing Standard (FIPS)
Enable FIPS Mode in GRUB2   [[ref]](https://static.open-scap.org/ssg-guides/ssg-fedora-guide-ospp.html#xccdf_org.ssgproject.content_rule_grub2_enable_fips_mode)

To ensure FIPS mode is enabled, install package dracut-fips, and rebuild initramfs by running the following commands:

```bash
$ sudo dnf install dracut-fips
dracut -f
```

After the `dracut` command has been run, add the argument `fips=1` to the default GRUB 2 command line for the Linux operating system in `/etc/default/grub`, in the manner below:

```bash
GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=VolGroup/LogVol06 rd.lvm.lv=VolGroup/lv_swap rhgb quiet rd.shell=0 fips=1"
```

Finally, rebuild the `grub.cfg` file by using the

```bash
grub2-mkconfig -o
```

command as follows:

* On BIOS-based machines, issue the following command as `root`:

`~]# grub2-mkconfig -o /boot/grub2/grub.cfg`

* On UEFI-based machines, issue the following command as `root`:

    `~]# grub2-mkconfig -o /boot/efi/EFI/redhat/grub.cfg`

**Warning**:  Running `dracut -f` will overwrite the existing initramfs file.

**Warning**:  The system needs to be rebooted for these changes to take effect.


### Updating Software

edit `/etc/yum.repos.d`, remove any lines that have `gpgcheck=0` to ensure signature checking is not disabled for any repos

* Ensure gpgcheck Enabled for Local Packages

in `/etc/dnf/dnf.conf`, set `localpkg_gpgcheck` to 1

* Ensure gpgcheck Enabled In Main dnf Configuration
The gpgcheck option controls whether RPM packages' signatures are always checked prior to installation. To configure dnf to check package signatures before installing them, ensure the following line appears in /etc/dnf/dnf.conf in the [main] section: 

```bash
gpgcheck=1
```

* Ensure Fedora GPG Key Installed
```bash
$ sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-29-primary
```


### Lock out baddies

Get fail2ban working with FirewallD

```bash
sudo dnf install fail2ban
sudo systemctl enable postfix
sudo systemctl start postfix

# in /etc/fail2ban/jail.conf

[DEFAULT]
bantime = 3600
sender = fail2ban@example.com
destemail = root
action = %(action_mwl)s

[sshd]
enabled = true
```

#### bantime

Default time in seconds to ban the possible intruder. Common values are 3600 (1 hour) or 86400 (1 day).

#### sender

Default "sender" email address when sending mail notifications of Fail2ban actions.

#### destemail

Destination email address for mail notifications.

#### action

Action to take when a possible intruder is detected. Default is %(action_)s which will only ban the IP. With %(action_mwl)s it will ban the IP and send a mail notification including whois data and log entries. See comments in /etc/fail2ban/jail.conf for more information.

#### Jails

By enabling the sshd jail, fail2ban will monitor ssh connection attempts for IPs to ban. There are many other jails you can enable as well, such as apache-auth to monitor the HTTPD error log for authentication failures, and jails for authentication to various FTP, IMAP, SMTP and database servers. See /etc/fail2ban/jail.conf for a full list of defined jails, or define your own.

#### fail2ban-firewalld

This installs /etc/fail2ban/jail.d/00-firewalld.conf containing:

```bash
[DEFAULT]
banaction = firewallcmd-ipset
```

Which configures fail2ban to block hosts via firewalld.

#### fail2ban-systemd

When trying to start fail2ban with systemd'd journald as the primary logging you may see this error

```bash
ERROR  No file(s) found for glob /var/log/secure
ERROR  Failed during configuration: Have not found any log file for sshd jail
```

To resolve this package installs /etc/fail2ban/jail.d/00-systemd.conf containing:

```bash
[DEFAULT]
backend=systemd
```

Which configures fail2ban to log via systemd's journald.

#### Running the service

Once configured, start the service:

`sudo systemctl start fail2ban`

And enable it to run on system startup:

`sudo systemctl enable fail2ban`

Check the status:

`systemctl status fail2ban`

Check the log file:

`sudo tail /var/log/fail2ban.log`


### syslog
`/etc/rsyslog.conf`

To use UDP for log message delivery:

`*.* @loghost.example.com`


To use TCP for log message delivery:

`*.* @@loghost.example.com`


To use RELP for log message delivery:

`*.* :omrelp:loghost.example.com`

DEFAULTS:
```bash
*.info;mail.none;authpriv.none;cron.none                /var/log/messages
authpriv.*                                              /var/log/secure
mail.*                                                  -/var/log/maillog
cron.*                                                  /var/log/cron
*.emerg                                                 *
uucp,news.crit                                          /var/log/spooler
local7.*                                                /var/log/boot.log
```

ensure cron is logging to rsyslog
```bash
cron.*                                                  /var/log/cron
```


---

## FirewallD

`/etc/firewalld/firewalld.conf`

`DefaultZone=drop`

verify firewalld enabled: `$ sudo systemctl enable firewalld.service`