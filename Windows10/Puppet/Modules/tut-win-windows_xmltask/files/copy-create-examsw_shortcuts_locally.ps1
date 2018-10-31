# Copy create-examsw_shortcuts.ps1 locally and run locally if file has changed
$localscriptfolder = "C:\apps\admintools\examscripts"
$remotescriptfolder = "\\your.server\Exam\scripts\ExamComputers\Win10"
$scriptfile = "create-examsw_shortcuts.ps1"
$PublicDesktop = "$env:Public\Desktop"
#$PublicDesktop = "C:\Users\Default\Desktop"
$testpath = Test-Path $remotescriptfolder

# Compare file hashes, copy from source only if different ($compresult=True)
if ($testpath -eq $true) {
$remotef = (Get-FileHash $remotescriptfolder\$scriptfile).hash
$localf = (Get-FileHash $localscriptfolder\$scriptfile).hash
[bool]$compresult = $remotef.CompareTo($localf)
}
  if ($compresult) {
  # file has changed, purge all shortcuts from $PublicDesktop (except EXAM.lnk) and copy new version from $remotescriptfolder
  Write-Host "Not same, copy file from source"
  remove-item -Recurse -Path $PublicDesktop\* -Include *.lnk -Exclude EXAM.lnk -Force
  copy-item "$remotescriptfolder\$scriptfile" $localscriptfolder -Force | powershell.exe -executionpolicy bypass -file $localscriptfolder\$scriptfile
  } else {
# run local copy from $localscriptfolder
#powershell.exe -executionpolicy bypass -file $localscriptfolder\$scriptfile
invoke-expression $localscriptfolder\$scriptfile
}

<# Copy scriptfile locally and run, if testpath false run local copy of $scriptfile
if ($testpath -eq $true) {
copy-item "$remotescriptfolder\$scriptfile" $localscriptfolder -Force | powershell.exe -executionpolicy bypass -file $localscriptfolder/$scriptfile
} else {
powershell.exe -executionpolicy bypass -file $localscriptfolder/$scriptfile
}
#>
