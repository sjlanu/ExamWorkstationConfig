# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2017 Tampere University of Technology
# Remove Exam user profile and c:\temp at logoff
# set logpath
# set profile
$profile = 'c:\users\examuser'
$logpath = '\\path\to\log'
# Set delprof2 path
$scriptpath = '\\path\to\scripts'
# set touch function
function touch {set-content -Path ($args[0]) -Value ($null)}
# set file to be touched
$touchfile = 'c:\exam-delprof.touchfile'
touch $touchfile
# set scriptpath to currentdir
# $scriptpath = Split-Path -Parent $MyInvocation.MyCommand.Definition
# Run delprof2
Start-Sleep -s 10
Start-Process -Filepath $scriptpath\delprof2.exe -ArgumentList ('/q','/u') -NoNewWindow -Wait
# remove c:\temp
remove-item -recurse -force c:\temp
# create c:\temp
new-item c:\temp -type directory -force
# set permissions to c:\temp
cmd /c icacls.exe "c:\temp" /grant "*S-1-5-11:(OI)(CI)(M)"
# check that c:\users\tut-exam not exist
$date = Get-Date -format M-d-yyyy-hh-mm
if ((test-path $profile)) {
touch $logpath\examuser-exists-$env:computername-$date.txt
}
# check that c:\temp is empty
$dircontents = get-childitem c:\temp | measure-object
if ($dircontents.count -ne 0) {
touch $logpath\c-temp-not-empty-$env:computername-$date.txt
}
# remove $touchfile
Start-Sleep -s 5
remove-item -force $touchfile