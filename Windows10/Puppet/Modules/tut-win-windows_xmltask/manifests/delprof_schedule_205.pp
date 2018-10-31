# schtask
class windows_xmltask::delprof_schedule_205 {
  windows_xmltask { 'delprof_schedule_205':
  ensure  => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/DelProf_schedule_205.xml',
  }
}
