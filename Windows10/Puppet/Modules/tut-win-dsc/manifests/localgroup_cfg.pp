# EXAM configuration
class dsc::localgroup_cfg {

# Local "Administrators" group members
 dsc_group {'Administrators':
	dsc_ensure		        => 'present',
	dsc_memberstoinclude	=> ['Administrator','YOURDOMAIN\Workstation Admins'],
	dsc_groupname		      => 'Administrators',
	dsc_credential		    => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
	}

# Local "Distributed COM Users" group members
dsc_group {'Distributed COM Users':
  dsc_ensure            => 'present',
  dsc_memberstoinclude  => ['YOURDOMAIN\your_nagios_user'],
  dsc_groupname         => 'Distributed COM Users',
  dsc_credential        => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
  }

# Local "Performance Monitor Users" group members
dsc_group {'Performance Monitor Users':
  dsc_ensure            => 'present',
  dsc_memberstoinclude  => ['YOURDOMAIN\your_nagios_user'],
  dsc_groupname         => 'Performance Monitor Users',
  dsc_credential        => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
  }

# Local "Event Log Readers" group members
dsc_group {'Event Log Readers':
  dsc_ensure            => 'present',
  dsc_memberstoinclude  => ['YOURDOMAIN\EVENTLOGSRV$'],
  dsc_groupname         => 'Event Log Readers',
  dsc_credential        => {'user' => 'YOURDOMAIN\PuppetADQuery', 'password' => '(YourTopSecretPassword'},
  }

# Disable "Guest" account
 dsc_user {'Guest':
  dsc_username  => 'Guest',
  dsc_disabled  => 'True',
  }
}
