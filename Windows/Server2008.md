# Windows Server 2008

![Meme](https://www.networksunlimited.com/wp-content/uploads/2019/01/windows-server-2008.jpg)

## Firewall


&nbsp;

Inbound Ports:
```text
# Explicitly Given
445/tcp  # SMB
1433/tcp # MSSQL
3389/tcp # RDP
```

&nbsp;

## Users

👀 look here for anything odd 👀

## Patching, Downloads, & AV
Download http://download.windowsupdate.com/c/msdownload/update/software/secu/2017/05/windows8-rt-kb4012598-x86_a0f1c953a24dd042acc540c59b339f55fb18f594.msu

```text
Algorithm       Hash
---------       ----
SHA256          6589008F680328707AAAE689A396EE0FBCD180F797228E36CB7019E65EE735CA
MD5             AE3865F6D94F6A88C8CCF9D19B135820
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
