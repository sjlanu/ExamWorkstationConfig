# EXAM configuration
class dsc::localgroup_cfg {
# Local group memberships
  #dsc_group {'Users':
 	#dsc_ensure		        => 'Present',
  # S-1-5-11='NT AUTHORITY\Authenticated Users', S-1-5-4='NT AUTHORITY\INTERACTIVE'
 	#dsc_memberstoinclude	=> ['YOURDOMAIN\your-exam-user','YOURDOMAIN\Domain Users','NT AUTHORITY\Authenticated Users','NT AUTHORITY\INTERACTIVE'],
 	#dsc_groupname		      => 'Users',
 	#dsc_credential		    => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
 	#}
 dsc_group {'Administrators':
	dsc_ensure		        => 'present',
	dsc_memberstoinclude	=> ['Administrator','YOURDOMAIN\Workstation Admins'],
	dsc_groupname		      => 'Administrators',
	dsc_credential		    => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
	}
dsc_group {'Distributed COM Users':
  dsc_ensure            => 'present',
  dsc_memberstoinclude  => ['YOURDOMAIN\your_nagios_user'],
  dsc_groupname         => 'Distributed COM Users',
  dsc_credential        => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
  }
dsc_group {'Performance Monitor Users':
  dsc_ensure            => 'present',
  dsc_memberstoinclude  => ['YOURDOMAIN\your_nagios_user'],
  dsc_groupname         => 'Performance Monitor Users',
  dsc_credential        => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
  }
dsc_group {'Event Log Readers':
  dsc_ensure            => 'present',
  dsc_memberstoinclude  => ['YOURDOMAIN\EVENTLOGSRV$'],
  dsc_groupname         => 'Event Log Readers',
  dsc_credential        => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
  }
 dsc_user {'Guest':
  dsc_username  => 'Guest',
  dsc_disabled  => 'True',
  }
}
