# Windows server 2016

## Accounts
* CHECK local accounts and groups (lusrmgr.msc / net user)
* CHECK that only "real admins" have user group Administrators
    | UNLESS that breaks some apps
    | <ALT> Create new admin accounts, disable old ones
* CHECK built-in Admin/Guest DISABLED
* CHECK that users have passwords
    | PowerShell
        Get-CimInstance -Class Win32_Useraccount -Filter "PasswordRequired=False" (alternatively add "and LocalAccount=True")
    | EXCEPT disabled users

## Anti-malware
* CHECK Windows Defender and firewall ON (cpanel -> sec -> wdf)

## Security policies (secpol.msc)
* Accounts
    | Guest account status -> DISABLED
    | Network access: let everyone apply to anonymous -> DISABLED

## File shares
    | CHECK all shares
        | mmc snap-in: Computer Management -> Local
            | System tools -> shared folder -> shares
            | VERIFY no weird things, CHECK permissions

## Task scheduler
    | CHECK no weird tasks

## Startup folders
    | LAUNCH `msconfig`, check STARTUP tab
    | C:/ProgramData/Microsoft/Windows/Start Menu/Programs/Startup
        | CHECK no weird things
    | C:/Users/<username>/AppData/Roaming/Microsoft/Windows/Start Menu / Programs/Startup
        | CHECK no weird things

## Services (services.msc)
    |

## Roles
    | PowerShell Get-WindowsFeature | Where "Installed"
        | Get-WindowsFeature | findstr <something>
            | DISABLE fax server (if not required)
            | CHECK FTP is not installed (unless required)
            | CHECK Simple-TCPIP is not installed
            | CHECK PowerShell 2.0 not installed
    | Check primary server roles in server manager

## GPEDIT
    | Computer Configuration
        | Windows Settings
            | Security Settings
                | Account Policies
                    | Password Policy
                        | Minimum length: >=14
                        | Complexity enforcement: enabled
                        | Store passwords using reversible: disabled
                    | Account Lockout Policy
                        | Account lockout threshold: 5
                        | Account lockout duration: 60 mins
                        | Reset account lockdown counter: 60 mins
                | Local Policies
                    | Audit policy
                        | <EVERYTHING> Enabled (Success, Failure)
                    | User Rights Assignment
                        | Debug programs: Administrators
                    | Security Options
                        | Accounts: Block Microsoft accounts: User can't add or log on with Microsoft accounts
                        | Accounts: Guest account status: Disabled
                        | Accounts: limit local account use of blank passwords to console logon only: Enabled
                        | ENABLED
                        | Devices: Prevent users from installing printer drivers: Enabled
                        | Devices: Restrict CD-ROM / floppy to locally logged-on users only: Enabled
        | Administrative Templates
            | Network
                | Lanman Workstation
                    | Enable insecure guest logons: DISABLED
                | Network Provider
                    | Hardened UNC paths: ENABLED
                        | `\\*\SYSVOL RequireMutualAuthentication=1, RequireIntegrity = 1`
                        | `\\*\NETLOGON RequireMutualAuthentication=1, RequireIntegrity = 1`
            | System
                | Audit Process Creation
                    | Include command line: Enabled
                | Group Policy
                    | Configure registry policy processing: ENABLED
                        | Process even if the objects have not changed
                | Internet communication management
                    | Internet communication settings
                        | Turn off downloading print drivers over HTTP : ENABLED
                        | Turn off printing over HTTP: ENABLED
                | Logon
                    | Do not display the network selection ui: ENABLED
                    | Block user from showing account details on sign-in: Enabled
                | Power management
                    | Sleep settings
                        | Require a password when a computer wakes <both>: ENABLED

## Log security
    | C:/Windows/System32/winevt
        | LOGS folder
            | Only EventLog / SYSTEM / Administrators may have control
## Misc
    | DISABLE IPv6 if not required
    | NetBIOS DoS prevention
        | HKLM/System/CurrentControlSet/Services/Netbt/Parameters
            | NoNameReleaseOnDemand DWORD 0x1
