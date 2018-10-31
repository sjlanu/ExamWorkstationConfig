class windows_xmltask::backup_tut_exam {
  windows_xmltask { 'schtask_backup_tut_exam_event7002':
  ensure  => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/schtask_backup_tut_exam_event7002.xml',
  }
}
