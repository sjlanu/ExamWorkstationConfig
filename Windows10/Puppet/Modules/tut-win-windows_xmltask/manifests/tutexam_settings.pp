class windows_xmltask::tutexam_settings {
  file { 'c:/apps/admintools/examscripts/WriteToHkcuFromSystem-TUT.ps1':
  ensure => 'present',
  source => 'puppet:///modules/windows_xmltask/WriteToHkcuFromSystem-TUT.ps1'
  }
  file { 'c:/apps/admintools/examscripts/tutexam_hkcu.reg':
  ensure => 'present',
  source => 'puppet:///modules/windows_xmltask/tutexam_hkcu.reg',
}
  windows_xmltask { 'tutexam_settings':
  ensure => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/tutexam_settings.xml',
  }
}
