class windows_xmltask::exam_nightlyreboot_0100 {
  windows_xmltask { 'Exam_nightlyreboot_0100':
  ensure  => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/ExamNightlyReboot_0100.xml',
  }
}
