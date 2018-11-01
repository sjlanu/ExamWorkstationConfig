# Set 'c:\Users\default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml' file for windows_exam environment
# from 'moduledir/files/ExamLayoutModification.xml'
class files::startmenulayout_exam {
	file { 'c:\Users\default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml':
	ensure	=> present,
	source	=> 'puppet:///modules/files/ExamLayoutModification.xml',
	}
}
