class windows_xmltask::create_tutwsadmin_eventsource {
  windows_xmltask { 'create_tutwsadmin_eventsource':
  ensure  => absent,
  overwrite => 'true',
  xmlfile => 'puppet:///modules/windows_xmltask/create_tutwsadmin_eventsource.xml',
  }
}
