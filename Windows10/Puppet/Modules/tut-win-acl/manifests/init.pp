# EXAM configuration
class acl {

# Set ACL for "c:\programdata"
  acl { 'c:/programdata':
  purge   => true,
        noop => false,
  permissions => [
  { identity  => 'NT AUTHORITY\SYSTEM', rights  => ['full'] },
  { identity  => 'Administrators', rights   => ['full'] },
  { identity  => 'Users', rights  => ['read','execute'] },
  { identity  => 'CREATOR OWNER', rights => ['full'], affects => 'children_only' },
  { identity  => 'Users', rights => ['mask_specific'], mask => '278', child_types => 'containers'},
  ],
  inherit_parent_permissions  => false,
  }

# Set ACL for "c:\"
  acl { 'c:/':
  purge => true,
  noop => false,
  permissions => [
  { identity  => 'NT AUTHORITY\SYSTEM', rights  => ['full'] },
  { identity  => 'Administrators', rights   => ['full'] },
  { identity  => 'Users', rights => ['read', 'execute'] },
  ],
  inherit_parent_permissions => false,
  }

# Ensure "c:\temp\" created
  file {'c:/temp':
  ensure => 'directory',
  }

# Set ACL for "C:\temp"
  acl { 'c:/temp':
  purge => true,
  noop => false,
  permissions => [
  { identity => 'NT AUTHORITY\SYSTEM', rights => ['full'] },
  { identity => 'Administrators', rights => ['full'] },
  { identity  => 'Authenticated users', rights => ['modify'], affects => 'children_only'},
  { identity  => 'Authenticated users', rights => ['write','read','execute'] },
  ],
  inherit_parent_permissions => false,
  }

# Remove read/execute permission for exam-user
  acl { 'c:/program files (x86)/Microsoft Office/Office16/PROOF/msspell7.dll':
  purge => false,
  noop => false,
  permissions => [
  { identity => 'YOURDOMAIN\your-exam-user', rights => ['read','execute'], perm_type => 'deny'},
  ]
  }
}
