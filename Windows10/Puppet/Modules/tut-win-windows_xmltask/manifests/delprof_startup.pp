# schtask
class windows_xmltask::delprof_startup {
  windows_xmltask { 'delprof_startup':
  ensure  => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/delprof_startup.xml',
  }
}
