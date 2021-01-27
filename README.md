# PowerShell Protect

<img src="https://github.com/ironmansoftware/powershell-protect/raw/master/icon.png" width="200" height="200" />

Configurable [anti-malware scan interface](https://docs.microsoft.com/en-us/windows/win32/amsi/antimalware-scan-interface-portal) provider.

PowerShell Protect can be used to block and audit scripts within PowerShell. You can use the configurable system to determine what to do when a script is executed by any PowerShell host.

## Features

- Configurable blocking policies
- Configurable auditing policies
  - Audit to a file
  - Audit to HTTP
  - Audit to UDP\TCP
- Built in blocking policies
- Windows PowerShell and PowerShell 7 support

## Get Started 

```powershell
Install-Module PowerShellProtect
Install-PowerShellProtect
```

## Resources

- [Documentation](https://docs.powershellprotect.com)
- [License](./LICENSE)
- [Download](https://www.powershellgallery.com/packages/PowerShellProtect)
