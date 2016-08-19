# Authors
# -------
#
# Sami Lanu <sami.lanu@tut.fi>
#
# Copyright
# ---------
#
# Copyright 2016 Tampere University of Technology
#
# Remove files older than xx days
$limit = (Get-Date).AddDays(30)
$path = "\\path\to\networkfolder\"

# Delete files older than the $limit.
Get-ChildItem -Path $path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $limit } | Remove-Item -Force