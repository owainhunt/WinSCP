Param ($server,$username,$password)

Describe 'Get-WinSCPItemInformation' {
    It 'WinSCP Module should be loaded.' {
        Get-Module -Name WinSCP | Should Be $true
        (Get-Module -Name WinSCP).Path | Should Be "$($env:USERPROFILE)\Documents\GitHub\WinSCP\WinSCP.psm1"
    }
    
    $params = @{
        HostName = $server
        UserName = $username
        Password = $password
        Protocol = 'Ftp'
    }

    Context 'Get-WinSCPItemInformation -WinSCPSession $session -Path "./Folder"' {
        $ftp = New-Item -Path "$(Get-Location)\Ftp" -ItemType Directory
        $folder = New-Item -Path "$ftp\Folder" -ItemType Directory

        It "$($ftp.FullName) and $($folder.FullName) should exist." {
            Test-Path -Path $ftp | Should Be $true
            Test-Path -Path $folder | Should Be $true
        }

        $session = Open-WinSCPSession -SessionOptions (New-WinSCPSessionOptions @params)

        It 'Session should be open.' {
            $session.Opened | Should Be $true
        }
        
        $result = Get-WinSCPItemInformation -WinSCPSession $session -Path './Folder'

        It 'Result should be of type WinSCP.RemoteFileInfo.' {
            $result.GetType() | Should Be WinSCP.RemoteFileInfo
        }

        It 'Should be Directory.' {
            $result.IsDirectory | Should Not Be $false
            $result.FileType | Should Be D
        }

        It 'Session should be closed.' {
            Close-WinSCPSession -WinSCPSession $session
            $session.Opened | Should Be $null
        }

        Remove-Item -Path $ftp -Confirm:$false -Force -Recurse
    }

    Context 'Get-WinSCPItemInformation -WinSCPSession $session -Path "./Folder/File.txt"' {
        $ftp = New-Item -Path "$(Get-Location)\Ftp" -ItemType Directory
        $folder = New-Item -Path "$ftp\Folder" -ItemType Directory
        $file = New-Item -Path "$folder\File.txt" -ItemType File -Value 'Test text.'

        It "$($ftp.FullName), $($folder.FullName), and $($file.FullName) should exist." {
            Test-Path -Path $ftp | Should Be $true
            Test-Path -Path $folder | Should Be $true
            Test-Path -Path $file | Should Be $true
        }

        $session = Open-WinSCPSession -SessionOptions (New-WinSCPSessionOptions @params)

        It 'Session should be open.' {
            $session.Opened | Should Be $true
        }
        
        $result = Get-WinSCPItemInformation -WinSCPSession $session -Path './Folder/File.txt'

        It 'Result should be of type WinSCP.RemoteFileInfo.' {
            $result.GetType() | Should Be WinSCP.RemoteFileInfo
        }

        It 'Should not be Directory.' {
            $result.FileType | Should be -
            $result.IsDirectory | Should Not Be $true
        }

        It 'Session should be closed.' {
            Close-WinSCPSession -WinSCPSession $session
            $session.Opened | Should Be $null
        }

        Remove-Item -Path $ftp -Confirm:$false -Force -Recurse
    }
}