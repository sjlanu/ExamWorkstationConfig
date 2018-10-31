class files::wmiperm_for_nagiosro {
	file { 'c:/apps/admintools/examscripts/SetACL-32bit.exe':
	ensure	=> present,
	source	=> 'puppet:///modules/files/SetACL-32bit.exe',
	}
	# to test nagios_ro account precense in root/cimv2 security settings
  file { 'c:/apps/admintools/examscripts/test-wmiperm.cmd':
	ensure	=> present,
	source	=> 'puppet:///modules/files/test-wmiperm.cmd',
	}
	# Enables nagios_ro account in root/cimv2 security and set remote_access allowed
  exec { 'WMI_nagios_ro_remote':
  cwd => 'c:/apps/admintools/examscripts',
  command => 'c:/apps/admintools/examscripts/SetACL-32bit.exe -on root\cimv2 -ot wmi -actn ace -ace "n:YOURDOMAIN\your_nagios_user;p:remote_access"',
  unless => 'c:/apps/admintools/examscripts/test-wmiperm.cmd',
  }
}
