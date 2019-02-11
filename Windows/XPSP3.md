# * INTERNAL SCREAMING *

![XP Meme](https://i.kinja-img.com/gawker-media/image/upload/s--r8junALo--/c_scale,fl_progressive,q_80,w_800/yoaizzfvc1ul539bjwts.jpg)

## Firewall
`wscui.cpl`

&nbsp;

Inbound Ports:
```text
# Explicitly Given
445/tcp  # SMB
3306/tcp # MySQL
```

&nbsp;

## Users
`lusrmgr.msc`

👀 look here for anything odd 👀

## Patching, Downloads, & AV
Download https://download.microsoft.com/download/D/B/4/DB4B0C90-0A7D-46C9-8988-8A5BE95B44A6/WindowsXP-KB4012598-x86-Custom-ENU.exe

```text
Algorithm       Hash
---------       ----
SHA256          3530B7890C22096693FD473D8C6455B9992AC4AA400E1B8CE14D0049234C489D
MD5             3AD11C9883051E5A5EEC5A000DC4C37C
```

Download https://www.clamav.net/downloads/production/ClamAV-0.101.1.exe

```text
Algorithm       Hash
---------       ----
SHA256          4ADCB9AAA43D529D1E37AF57B291A5A7CEB5FEE0516D9469ECBA3661F577D273
MD5             092C7131898ED8A30B25B9B52C695386
```

and Definitions for Clam

```text
http://database.clamav.net/main.cvd
Algorithm       Hash
---------       ----
MD5             A22E1B59C5E8B8EFF166271B08B4AD72
SHA256          081884225087021E718599E8458FF6C9EE3CDEBED8775DD8E445FC7B589D88A6
*Hashes may vary depending on when downloaded for staging server

http://database.clamav.net/daily.cvd
Algorithm       Hash
---------       ----
MD5             6FC20F69CD062AC6DF20F5020860FE71
SHA256          1B163F89E2A6CF47AB91646B7E33B4AB04742D0EF67D04A30434D5E1119F9ABB
*Hashes may vary depending on when downloaded for staging server
```

Download https://download.sysinternals.com/files/SysinternalsSuite.zip

```text
Algorithm       Hash
---------       ----
SHA256          B14466C6BF3BE216EA71610A3F455030E791CD5AD1B42A283886194205D176B0
MD5             C8E2413DB5306C64309456C368848962
```

Download https://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community-6.2.5-win32.msi

```text
Algorithm       Hash
---------       ----
SHA256          1AFFABF39F2057B768DC1A0C932D1E76F6A80DEA489F0617E3E2C4765EF4AAF4
MD5             A631FCB1DC8257ECCA271A0841019C22
```