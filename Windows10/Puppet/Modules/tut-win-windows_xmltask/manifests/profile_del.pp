class windows_xmltask::profile_del {
  file { 'c:/apps/admintools/examscripts':
  ensure => 'directory',
  }
  file { 'c:/apps/admintools/examscripts/DelProf2.exe':
  ensure => 'present',
  source => 'puppet:///modules/windows_xmltask/DelProf2.exe'
  }
  file { 'c:/apps/admintools/examscripts/Del-exam_prof-c_temp.ps1':
  ensure => 'present',
  source => 'puppet:///modules/windows_xmltask/Del-exam_prof-c_temp.ps1',
}
  windows_xmltask { 'DelProfLogoff_event7002':
  ensure => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/DelProfLogoff_event7002.xml',
  }
}
