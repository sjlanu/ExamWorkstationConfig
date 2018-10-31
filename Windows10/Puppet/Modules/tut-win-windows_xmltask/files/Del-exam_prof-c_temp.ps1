# Remove c:\users\your-exam-user and c:\temp at logoff
# set logpath
$logpath = '\\your.server\log\Exam\your-exam-user-cleanup-log'
# Set delprof2 path
$localscriptfolder = 'c:\apps\admintools\examscripts'
# set touch function
function touch {set-content -Path ($args[0]) -Value ($null)}
# set file to be touched
$touchfile = 'c:\exam-delprof.touchfile'
touch $touchfile
# set scriptpath to currentdir
# $scriptpath = Split-Path -Parent $MyInvocation.MyCommand.Definition
# Run delprof2
Start-Sleep -s 15
Start-Process -Filepath $localscriptfolder\delprof2.exe -ArgumentList ('/q','/u') -NoNewWindow -Wait
# remove c:\temp
remove-item -recurse -force c:\temp
# create c:\temp
new-item c:\temp -type directory -force
# set permissions to c:\temp
# Authenticated users 'write' to c-temp 'This folder, sublfolders and files', non-inherited
cmd /c icacls.exe "c:\temp" /grant "*S-1-5-11:(OI)(CI)(W)" /inheritance:r
# Authenticated users 'read-execute', 'This folder, subfolders and files', non-inherited
cmd /c icacls.exe "c:\temp" /grant "*S-1-5-11:(OI)(CI)(RX)" /inheritance:r
# Authenticated users 'Modify' to 'Subfolders and files only', non-inherited
cmd /c icacls.exe "c:\temp" /grant "*S-1-5-11:(OI)(CI)(IO)(M)" /inheritance:r
# Administrators 'Full' 'This folder, sublfolder and files', non-inherited
cmd /c icacls.exe "c:\temp" /grant "Administrators:(OI)(CI)(F)" /inheritance:r
# SYSTEMN 'Full', 'This folder, sublfolders and files', non-inherited
cmd /c icacls.exe "c:\temp" /grant "SYSTEM:(OI)(CI)(F)" /inheritance:r

# check that c:\users\your-exam-user not exist
Start-Sleep -s 2
$date = Get-Date -format M-d-yyyy-hh-mm
if (Test-Path $logpath) {
	if (test-path 'c:\users\your-exam-user') {
	touch $logpath\your-exam-user-user-exists-$env:computername-$date.txt
	}
	# check that c:\temp is empty
	$dircontents = get-childitem c:\temp | measure-object
	if ($dircontents.count -ne 0) {
	touch $logpath\c-temp-not-empty-$env:computername-$date.txt
	}
} else {
}
# remove $touchfile
Start-Sleep -s 2
remove-item -force $touchfile
