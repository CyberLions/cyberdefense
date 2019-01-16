# Windows 8.1

## Group Policy

### Computer Configuration -> (Policies) -> Windows Settings -> Security Settings -> Local Policies

#### Security Options

* **Network Access**: Do not allow storing of passwords and credentials for network auth. -> **enabled**
* **Network access**: Restrict anonymous access to Named Pipes and Shares -> **enabled**
* **Network Access**: Do not allow anonymous enumeration of SAM accounts and shares -> **enabled**
* **Network Access**: Do not allow anonymous enumeration of SAM accounts -> **enabled**
* **Network access**: Allow anonymous SID/Name translation -> **Disabled**
* **Network access**: Shares that can be accessed anonymously to be defined but containing no entries **(blank)**
* **Network access**: Named pipes that can be accessed anonymously -> be defined but containing no entries **(blank)**
* **Network access**: Remotely accessible registry paths -> add these entries
```
System\CurrentControlSet\Control\ProductOptions
System\CurrentControlSet\Control\Server Applications
Software\Microsoft\Windows NT\CurrentVersion
```
* **Network security**: LAN Manager authentication level -> **Send NTLMv2 response only. Refuse LM & NTLM**
* **Network security**: Do not store LAN Manager hash value on next password change -> **Enabled**
* **Accounts**: Limit local account use of blank passwords to console logon only -> **enabled**
* **Interactive logon**: # number of previous logons -> **1**

#### User Rights Assignments

* Act as part of the operating system to be defined but containing no entries **(blank)**
* Debug Programs to only include the following accounts or groups: **Administrators**

---

### Computer Configuration -> Administrative Templates

* **System** -> Remote Assistance -> Configure Solicited Remote Assistance -> **Disabled**

---

### Computer Configuration -> Administrative Templates -> Windows Components
* **Windows Remote Management (WinRM)** -> WinRM Client -> Allow Basic authentication -> **Disabled**
* **Policies** -> Turn off AutoPlay -> **Enabled: All Drives**
* **AutoPlay Policies** -> Disallow Autoplay for non-volume devices -> **Enabled**
* **AutoPlay Policies** -> Set the default behavior for AutoRun -> **Enabled:Do not execute any autorun commands**
* **Windows Installer** -> Always install with elevated privileges -> **Disabled**

---

### Password Policy
<u>**Ensure all user accounts have passwords**</u>
#### Computer Configuration -> Windows Settings -> Security Settings -> Account Policies -> Password Policy
* **Minimum Password Length** -> **14**
* **Store password using reversible encryption** -> **Disabled**

---

## Registry

##### HKEY\_LOCAL\_MACHINE
```
Path: System -> CurrentControlSet -> Control -> Session Manager -> kernel
Value Name: **DisableExceptionChainValidation** -> **0**
```

---

## Misc
* Format all local partitions/drives to use NTFS
* Configure DEP to opt out
```
BCDEDIT /set {current} nx OptOut
```
* Delete calculator app if not needed
* Check to ensure Windows Firewall is enabled  
`Control Panel -> System Security -> Firewall -> Turn Windows Firewall On or Off`
* Remove IIS from the system if installed  
`Features -> Turn Windows Features On or Off`
* Remove any standard user accounts
* [Download](https://www.avast.com/windows-8.1-antivirus) antivirus
* [Download](https://www.microsoft.com/en-us/download/details.aspx?id=50766) Enhanced Mitigation Experience v5.5 or greater
