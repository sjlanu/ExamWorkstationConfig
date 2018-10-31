class windows_xmltask::remove_office2016fff {
  windows_xmltask { 'RemoveOffice2016FirstThingsFirst':
  ensure  => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/RemoveOffice2016FirstThingsFirst.xml',
  }
}
