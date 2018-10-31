# AYOHRLING-LOCAL_SECURITY_POLICY moduulin sopivaa
#
# Class: local_security_policy
#
# This module manages local_security_policy
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#
class local_security_policy::exam_secpol {
#Name to SID mapping in same order as in 'policy_value':
#YOURDOMAIN\DenyGroup1 = *S-1-5-21-0000000000-111111111-222222222-3333
#YOURDOMAIN\DenyGroup2 = *S-1-5-21-0000000000-111111111-222222222-33333
#YOURDOMAIN\DenyGroup3 = *S-1-5-21-0000000000-111111111-222222222-33333
local_security_policy { 'Deny log on locally':
  ensure         => 'present',
  policy_setting => 'SeDenyInteractiveLogonRight',
  policy_type    => 'Privilege Rights',
  policy_value  => '*S-1-5-21-0000000000-111111111-222222222-3333,*S-1-5-21-0000000000-111111111-222222222-33333,*S-1-5-21-0000000000-111111111-222222222-33333',
}
#Name to SID mapping in same order as in 'policy_value':
#Administrators = *S-1-5-32-544
#YOURDOMAIN\Admin1 = *S-1-5-21-0000000000-111111111-222222222-33333
#YOURDOMAIN\Admin2 = *S-1-5-21-0000000000-111111111-222222222-33333
#YOURDOMAIN\admin3 = *S-1-5-21-0000000000-111111111-222222222-33333
#YOURDOMAIN\exam_user = *S-1-5-21-0000000000-111111111-222222222-33333
#YOURDOMAIN\exam_user_test = *S-1-5-21-0000000000-111111111-222222222-33333
#YOURDOMAIN\your_nagios_user = *S-1-5-21-0000000000-111111111-222222222-33333
local_security_policy { 'Allow log on locally':
  ensure         => 'present',
  policy_setting => 'SeInteractiveLogonRight',
  policy_type    => 'Privilege Rights',
  policy_value   => '*S-1-5-32-544,*S-1-5-21-0000000000-111111111-222222222-33333,*S-1-5-21-0000000000-111111111-222222222-33333,*S-1-5-21-0000000000-111111111-222222222-33333,*S-1-5-21-0000000000-111111111-222222222-33333,*S-1-5-21-0000000000-111111111-222222222-33333',
}
#local_security_policy { 'EnableGuestAccount':
#  ensure         => 'present',
#  policy_setting => 'EnableGuestAccount',
#  policy_type    => 'System Access',
#  policy_value   => '0',
#	}
local_security_policy { 'Network access: Do not allow anonymous enumeration of SAM accounts':
  ensure         => 'present',
  policy_setting => 'MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymousSAM',
  policy_type    => 'Registry Values',
  policy_value   => '4,1',
	}
local_security_policy { 'Network access: Do not allow anonymous enumeration of SAM accounts and shares':
  ensure         => 'present',
  policy_setting => 'MACHINE\System\CurrentControlSet\Control\Lsa\RestrictAnonymous',
  policy_type    => 'Registry Values',
  policy_value   => '4,2',
	}
local_security_policy { 'Maximum password age':
  ensure         => 'present',
  policy_setting => 'MaximumPasswordAge',
  policy_type    => 'System Access',
  policy_value   => '-1',
	}
local_security_policy { 'Minimum password age':
  ensure         => 'present',
  policy_setting => 'MinimumPasswordAge',
  policy_type    => 'System Access',
  policy_value   => '0',
	}
local_security_policy { 'Minimum password length':
  ensure         => 'present',
  policy_setting => 'MinimumPasswordLength',
  policy_type    => 'System Access',
  policy_value   => '0',
	}
local_security_policy { 'Password must meet complexity requirements':
  ensure => 'present',
  policy_setting => 'PasswordComplexity',
  policy_type => 'System Access',
  policy_value => '0',
  }
}
