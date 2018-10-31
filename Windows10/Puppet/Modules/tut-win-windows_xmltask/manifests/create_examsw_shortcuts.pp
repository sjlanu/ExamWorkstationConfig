class windows_xmltask::create_examsw_shortcuts {
  file { 'c:/apps/admintools/examscripts/copy-create-examsw_shortcuts_locally.ps1':
  ensure => 'present',
  source => 'puppet:///modules/windows_xmltask/copy-create-examsw_shortcuts_locally.ps1',
}
  windows_xmltask { 'createExamSwShortcuts':
  ensure  => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/createExamSwShortcuts.xml',
  }
}
