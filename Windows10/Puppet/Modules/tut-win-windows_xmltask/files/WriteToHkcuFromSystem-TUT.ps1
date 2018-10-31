# The script simply reads the .reg file, and the replaces the registry hive and/or path as needed, 
# saves the new file temporarily and imports it with the /s switch in regedit.exe
# If it needs to write to the default profile's HKCU, it first loads the ntuser.dat file as a hive, import
# https://gallery.technet.microsoft.com/scriptcenter/Write-to-HKCU-from-the-3eac1692#content
#
# The script simply reads the .reg file, and the replaces the registry hive and/or path as needed, saves the new file temporarily and imports it with the /s switch in regedit.exe
# If it needs to write to the default profile's HKCU, it first loads the ntuser.dat file as a hive, imports the reg file, and unloads the hive. 
# To write to the currently logged on user's HKCU hive, use the CurrentUser switch. 
# If you needs to write to the default profile (for every user that will ever logon to the machine), use the DefaultProfile switch, for all the users that already have a profile on the machine, use the AllUsers switch. 
# The modes can be combined to cover all the options:
#
# Usage: PowerShell.exe -File C:\scripts\WriteToHkcuFromSystem.ps1 -RegFile C:\Temp\myApp.reg –CurrentUser –AllUsers –DefaultProfile

PARAM(

    [Parameter(Mandatory=$true)]
    [ValidatePattern('\.reg$')]
    [string]$RegFile,

    [switch]$CurrentUser,
    [switch]$AllUsers,
    [switch]$DefaultProfile
)


function Write-Registry {
    PARAM($RegFileContents)
    $tempFile = '{0}{1:yyyyMMddHHmmssff}.reg' -f [IO.Path]::GetTempPath(), (Get-Date)
    $RegFileContents | Out-File -FilePath $tempFile
    Write-Host ('Writing registry from file {0}' -f $tempFile)
    try { $p = Start-Process -FilePath C:\Windows\regedit.exe -ArgumentList "/s $tempFile" -PassThru -Wait } catch { }
    if($p -ne $null) { $exitCode = $p.ExitCode } else { $exitCode = 0 }
    if($exitCode -ne 0) {
        Write-Warning 'There was an error merging the reg file'
    } else {
        Remove-Item -Path $tempFile -Force -ErrorAction SilentlyContinue
    }
}

if(-not (Test-Path -Path $RegFile)) {
    Write-Warning "RegFile $RegFile doesn't exist. Operation aborted"
} else {

    if($CurrentUser -or $AllUsers -or $DefaultProfile) {

        Write-Host ('Reading the registry file {0}' -f $RegFile)
        $registryData = Get-Content -Path $RegFile -ReadCount 0

        if($CurrentUser) {
            Write-Host "Writing to the currenlty loggoed on user's registry"
            $explorers = Get-WmiObject -Namespace root\cimv2 -Class Win32_Process -Filter "Name='explorer.exe'"
            $explorers | ForEach-Object {
                $owner = $_.GetOwner()
                if($owner.ReturnValue -eq 0) {
                    $user = '{0}\{1}' -f $owner.Domain, $owner.User
                    $ntAccount = New-Object -TypeName System.Security.Principal.NTAccount($user)
                    $sid = $ntAccount.Translate([System.Security.Principal.SecurityIdentifier]).Value
                    $RegFileContents = $registryData -replace 'HKEY_CURRENT_USER', "HKEY_USERS\$sid"
                    Write-Registry -RegFileContents $RegFileContents
                }
            }
        }

        if($AllUsers) {
            Write-Host "Writing to every user's registry"
            $res = C:\Windows\system32\reg.exe query HKEY_USERS
            $res -notmatch 'S-1-5-18|S-1-5-19|S-1-5-20|DEFAULT|Classes' | ForEach-Object {
                if($_ -ne '') {
                    $sid = $_ -replace 'HKEY_USERS\\'
                    $RegFileContents = $registryData -replace 'HKEY_CURRENT_USER', "HKEY_USERS\$sid"
                    Write-Registry -RegFileContents $RegFileContents

                }
            }
        }

        if($DefaultProfile) {
            Write-Host "Writing to the default profile's registry (for future users)"
            C:\Windows\System32\reg.exe load 'HKU\DefaultUser' C:\Users\Default\NTUSER.DAT | Out-Null
            $RegFileContents = $registryData -replace 'HKEY_CURRENT_USER', 'HKEY_USERS\DefaultUser'
            Write-Registry -RegFileContents $RegFileContents
            C:\Windows\System32\reg.exe unload 'HKU\DefaultUser' | Out-Null
        }

    } else {
        Write-Warning 'No mode was selected. Operation aborted'
    }
}