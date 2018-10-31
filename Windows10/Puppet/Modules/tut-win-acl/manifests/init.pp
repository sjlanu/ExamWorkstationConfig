# EXAM configuration
class acl {
##
#  acl { 'c:/users/public':
#    purge => true,
#    noop => false,
#    permissions => [
#        { identity      => 'NT AUTHORITY\SYSTEM', rights        => ['full'] },
#        { identity      => 'Administrators', rights             => ['full'] },
#        ##{ identity     => 'Users', rights                      => ['read', 'execute'], affects => 'all' },
#        { identity  => 'CREATOR OWNER', rights => ['full'], affects => 'children_only' },
#  ## { identity  => 'INTRA\Domain Users', rights => ['full'], perm_type  => 'deny'},
#  ## { identity      => 'Users', rights                      => ['modify'] },
#        ],
#        inherit_parent_permissions  => false,
#    }
  acl { 'c:/programdata':
  purge   => true,
        noop => false,
  permissions => [
  { identity  => 'NT AUTHORITY\SYSTEM', rights  => ['full'] },
  { identity  => 'Administrators', rights   => ['full'] },
  { identity  => 'Users', rights  => ['read','execute'] },
  { identity  => 'CREATOR OWNER', rights => ['full'], affects => 'children_only' },
  { identity  => 'Users', rights => ['mask_specific'], mask => '278', child_types => 'containers'},
#  { identity  => 'INTRA\Domain Users', rights => ['full'], perm_type  => 'deny' }
  ],
  inherit_parent_permissions  => false,
  }
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
  file {'c:/temp':
  ensure => 'directory',
  }
  # acl { 'c:/temp':
  # purge => true,
  # noop => false,
  # permissions => [
  # #{ identity  => 'Authenticated users', rights  => ['read','write','execute'] },
  # { identity  => 'Authenticated users', rights => ['modify'] },
  # { identity => 'NT AUTHORITY\SYSTEM', rights => ['full'] },
  # { identity => 'Administrators', rights => ['full'] },
  # { identity => 'Users', rights => ['read','execute'] },
  # ],
  # inherit_parent_permissions => true,
  # }

  acl { 'c:/temp':
  purge => true,
  noop => false,
  permissions => [
  { identity => 'NT AUTHORITY\SYSTEM', rights => ['full'] },
  { identity => 'Administrators', rights => ['full'] },
  { identity  => 'Authenticated users', rights => ['modify'], affects => 'children_only'},
  { identity  => 'Authenticated users', rights => ['write','read','execute'] },
  #{ identity  => 'Authenticated users', rights => ['modify'], affects => 'children_only'},
  #{ identity => 'NT AUTHORITY\SYSTEM', rights => ['full'] },
  #{ identity => 'Administrators', rights => ['full'] },
  ],
  inherit_parent_permissions => false,
  }

  acl { 'c:/program files (x86)/Microsoft Office/Office16/PROOF/msspell7.dll':
  purge => false,
  noop => false,
  permissions => [
  { identity => 'YOURDOMAIN\your-exam-user', rights => ['read','execute'], perm_type => 'deny'},
  ]
  }
}
