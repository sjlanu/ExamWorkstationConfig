# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2016 Tampere University of Technology
$targetdir = "local-backup-folder"
$backupfolder1 = "c:\temp"
$backupfolder2 = "c:\users\examuser\desktop"
$backupfolder3 = "c:\users\examuser\documents"

if (!(Test-Path '$targetdir' -PathType Container)) {New-Item -Force -ItemType directory -Path $targetdir}
Copy-Item $backupfolder1 $targetdir\temp -recurse
Copy-Item $backupfolder2 $targetdir\desktop -recurse
Copy-Item $backupfolder3 $targetdir\documents -recurse

$date = Get-date -format M-d-yyyy-hh-mm

if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
set-alias sz "$env:ProgramFiles\7-Zip\7z.exe"  

$Source = $targetdir
$Target = "\\path\to\networkfolder\backup-$env:computername-$date.zip"

sz a -y $Target $Source

Remove-Item $targetdir -Recurse -Force -Confirm:$false