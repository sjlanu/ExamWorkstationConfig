class windows_xmltask::copy_pycharm2017settings {
  windows_xmltask { 'CopyPyCharm2017Settings':
  ensure  => present,
  overwrite => 'false',
  xmlfile => 'puppet:///modules/windows_xmltask/CopyPyCharm2017Settings.xml',
  }
}
