﻿System Hardening Guide
======================
Windows 10
----------
*Consolidated from STIGViewer*


Group Policy
* Computer Configuration
   * Windows Settings
      * Security Settings
         * Local Policies
            * User Rights Assignment
               * Only include admins in “Debug programs”
               * “Act as part of the operating system” needs to be defined but have no entries
               * “Create a token object” needs to be defined but have no entries
            * Security Options
               * Enable “Network Security: Do not store LAN Manager hash value on next password change”
               * Enable “Network Access: Restrict anonymous access to Named Pipes and Shares”
               * Enable “Network Access: Do not allow anonymous enumeration of SAM accounts and shares”
               * Enable “Network Access: Do not allow anonymous enumeration of SAM accounts”
               * Disable “Network Access: Allow anonymous SID/Name translation”
               * Change “Network security: LAN Manager authentication level” to “Send NTLMv2 response only. Refuse LM & NTLM”
         * Account Policies
            * Password Policy
               * Disable “Store passwords using reversible encryption”
   * Administrative Templates
      * Windows Components
         * Windows Installer
            * Disable “Always Install with elevated privileges”
         * AutoPlay Policies
            * Enable “Disallow Autoplay for non-volume devices”
            * Change “Turn off Autoplay” to “Enabled: All Drives”
            * Change “Set the default behavior for AutoRun” to “Enabled: Do not execute any autorun commands”
         * Windows Remote Management (WinRM)
            * WinRM Service
               * Disable “Allow Basic authentication”
      * System
         * Remote Assistance
            * Disable “Configure Solicited Remote Assistance”
      * MS Security Guide
         * Enable “Enable structured exception handling overwrite protection (SEHOP)”


Computer Management
* Check local users and groups
* Check to make sure NTFS is in use


Misc.
* Uninstall Internet Information Services or Internet Information Services Hostable Web Core from hosts
* Enforce policies that restrict admins from accessing web browsers/email/etc.
* A/V installed and up to date
* Enable disk encryption like BitLocker
* Windows Updates
* Disable Remote Assistance/RDP if able


Data Execution Prevention Check
* Check first
   * Verify the DEP configuration.
   * Open a command prompt (cmd.exe) or PowerShell with elevated privileges (Run as administrator).
   * Enter "BCDEdit /enum {current}". (If using PowerShell "{current}" must be enclosed in quotes.)
   * If the value for "nx" is not "OptOut", this is a finding.
* Fix if needed
   * Suspend BitLocker if needed
   * Open a command prompt (cmd.exe) or PowerShell with elevated privileges (Run as administrator).
   * Enter "BCDEDIT /set {current} nx OptOut". (If using PowerShell "{current}" must be enclosed in quotes.)
   * "AlwaysOn", a more restrictive selection, is also valid but does not allow applications that do not function properly to be opted out of DEP.
   * Control Panel > System > Advanced System Settings > Settings (under performance) > Data Execution Prevention > “Turn on DEP for all programs and services except those I select:”