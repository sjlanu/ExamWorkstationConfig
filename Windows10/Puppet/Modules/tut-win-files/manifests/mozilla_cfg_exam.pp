class files::mozilla_cfg_exam {
  file_line { 'mozilla.cfg Reader View Disable':
  ensure => 'present',
  path => 'c:/program files (x86)/Mozilla Firefox/mozilla.cfg',
  line => 'defaultPref("reader.parse-on-load.enabled", false);',
  }
  file_line { 'Default homepage':
  ensure => 'present',
  path => 'c:/program files (x86)/Mozilla Firefox/mozilla.cfg',
  line => 'defaultPref("browser.startup.homepage", "data:text/plain,browser.startup.homepage=https://exam.tut.fi")',
  }
}
