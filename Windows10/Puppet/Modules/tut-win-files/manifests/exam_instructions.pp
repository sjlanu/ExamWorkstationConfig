# Open 'EXAM Ohjeet - Instructions.pdf' at logon with Edge
class files::exam_instructions {
        file { 'c:\programdata\Microsoft\Windows\Start Menu\Programs\StartUp\exam_instructions.cmd':
        ensure  => present,
        source  => 'puppet:///modules/files/exam_instructions.cmd',
        }
}
