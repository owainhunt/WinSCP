# WinSCP PowerShell Module Wrapper

This module can be installed from the [PowerShellGet Gallery](https://www.powershellgallery.com/packages/WinSCP/),  You need [WMF 5](https://www.microsoft.com/en-us/download/details.aspx?id=44987) to use this feature.
```PowerShell
# To install WinSCP, run the following command in the PowerShell prompt in Administrator mode:
Install-Module -Name WinSCP
```

This module can be installed with [chocolatey](https://chocolatey.org/packages/winscp.powershell):
```
choco install winscp.powershell -version 5.7.3.2
```

This module can be installed with [PsGet](http://psget.net/):
```PowerShell
# Install WinSCP module with PsGet
Install-Module -ModuleUrl "https://github.com/dotps1/WinSCP/raw/master/WinSCP.zip" -ModuleName WinSCP -Type ZIP
```

## WinSCP Cmdlets

* [Add-WinSCPSessionOptionsRawSettings](https://github.com/dotps1/WinSCP/wiki/Add-WinSCPSessionOptionsRawSettings)
* [Close-WinSCPSession](https://github.com/dotps1/WinSCP/wiki/Close-WinSCPSession)
* [ConvertTo-WinSCPEscapedString](https://github.com/dotps1/WinSCP/wiki/ConvertTo-WinSCPEscapedString)
* [Get-WinSCPDirectoryContents](https://github.com/dotps1/WinSCP/wiki/Get-WinSCPDirectoryContents)
* [Get-WinSCPFileChecksum](https://github.com/dotps1/WinSCP/wiki/Get-WinSCPFileChecksum)
* [Get-WinSCPItemInformation](https://github.com/dotps1/WinSCP/wiki/Get-WinSCPItemInformation)
* [Invoke-WinSCPCommand](https://github.com/dotps1/WinSCP/wiki/Invoke-WinSCPCommand)
* [Move-WinSCPItem](https://github.com/dotps1/WinSCP/wiki/Move-WinSCPItem)
* [New-WinSCPDirectory](https://github.com/dotps1/WinSCP/wiki/New-WinSCPDirectory)
* [New-WinSCPFilePermissions](https://github.com/dotps1/WinSCP/wiki/New-WinSCPFilePermissions)
* [New-WinSCPSessionOptions](https://github.com/dotps1/WinSCP/wiki/New-WinSCPSessionOptions)
* [New-WinSCPTransferOptions](https://github.com/dotps1/WinSCP/wiki/New-WinSCPTransferOptions)
* [Open-WinSCPSession](https://github.com/dotps1/WinSCP/wiki/Open-WinSCPSession)
* [Receive-WinSCPItem](https://github.com/dotps1/WinSCP/wiki/Receive-WinSCPItem)
* [Remove-WinSCPItem](https://github.com/dotps1/WinSCP/wiki/Remove-WinSCPItem)
* [Send-WinSCPItem](https://github.com/dotps1/WinSCP/wiki/Send-WinSCPItem)
* [Start-WinSCPConsole](https://github.com/dotps1/WinSCP/wiki/Start-WinSCPConsole)
* [Sync-WinSCPDirectory](https://github.com/dotps1/WinSCP/wiki/Sync-WinSCPDirectory)
* [Test-WinSCPItemExists](https://github.com/dotps1/WinSCP/wiki/Test-WinSCPItemExists)


## Examples

Example 1:

```PowerShell
# Splat New-WinSCPSessionOptions.
$sessionOptions = @{
	HostName = "myftphost.org"
	UserName = "ftpuser"
	Password = "FtpUserPword"
	SshHostKeyFingerprint = "ssh-rsa 1024 xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
}

# Open a new WinSCPSession using the splatted parameters.
$session = Open-WinSCPSession -SessionOptions (New-WinSCPSessionOptions @sessionOptions)

# Use that session to create a new Directory and then upload a file to it.
New-WinSCPDirectory -WinSCPSession $session -Path "./remoteDirectory"
Send-WinSCPItem -WinSCPSession $session -LocalPath "C:\localDirectory\localFile.txt" -RemotePath "./remoteDirectory/"

# Close the session.
Close-WinSCPSession -WinSCPSession $session
```

Example 2:
```PowerShell
# Create session, download a file, and close the session in one line.
# If the WinSCP.Session Object is passed through the pipeline it will be auto-closed upon the completion of that command.
# To avoid this behaviour, set the WinSCP.Session object value to variable to be reused.
Open-WinSCPSession -SessionOptions (New-WinSCPSessionOptions -HostName "myftphost.org" -UserName "ftpUser" -Password "MyPassword" -Protocol Ftp) | Receive-WinSCPItem -RemotePath "./file.txt" -LocalPath "C:\folder\"
```

This is still a very beta version, with most of the functionality available with WinSCP, I intend on developing this extensively.  
I have included the WinSCPnet.dll in the _NeededAssemblies_ folder.

Check back regularly for updates.


this project is licensed with GNU GENERAL PUBLIC LICENSE.