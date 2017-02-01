# TUT Exam workstation configurations

#### Table of Contents

1. [Description](#description)
1. [Scripts - Scripts to maintain Exam workstation configuration] (#scripts)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing](#development)

## Description

Windows workstation configurations for Exam including Group Policy settings and scripts

More about Exam https://confluence.csc.fi/display/EXAM/EXAM

Main features are:

- Exam users log on to workstations with common AD user account, allowed to logon only to specified Exam workstations
- Restrictions to workstations are set mainly with GPO.
- User profile is created fresh for every log on, user data is deleted at logoff.
- User data is backupped at logoff.

## Scripts

- Computer Startup script "**CreateTUT_WSAdminEventChannel.cmd**" that creates new eventchannel (if not exist) for triggering scheduled tasks to run at logoff with different privileges than current user
- Logon to workstation with common account
- Logon script runs:
  - "**PinProgram.bat**" that pins configured programs to Start Menu
     - Calls "**PinItem.vbs**"
  - "**UnPinTaskBarItem.cmd**" that removes default TaskBar items "*iexplore.exe*","*wmplayer.exe*","*explorer.exe*" from TaskBar
     - Calls "**UnPinTaskbar_2.vbs**"
- When finished exam, user logoff will trigger:
  - Logoff script "**EXIT_EXAM.cmd**" that creates event 124, triggers Scheduled Task "**ProfileAndTempDeleteLogoff**" that runs:
	- "**ProfileDelete.cmd**" calls powershell script to
   - Remove all inactive profiles with Delprof2.exe
   - Remove/create c:\temp and set permissions
   - test that Examuser profile does not exist
   - test that c:\temp is empty
    - If not, write logfile

Backup Exam users session:
- "**schtask_backup_exam.cmd**" -> creates scheduled task "*schtask_backup_exam*" that runs  when "*examuser*" logs off (Custom EventID 124 is triggered by "**EXIT_EXAM.cmd**")
 - Scheduled Task action is "**backup_exam_files.cmd**"
 - "*schtask_backup_exam.xml*" -> Content of task
- "**backup_exam_files.ps1**" -> backup script
- "**remove_files_older_than.ps1", script for rotating backupped files, runs as Scheduled Task on server.**


## Limitations

Tested only with Windows7 64-bit

## Development

Contributions and pull requests are welcome.

Copyright 2016 Tampere University of Technology

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
