# For Exam  environment
# hiera_include is being deprecated in Hiera5, using lookup function instead
#hiera_include('classes')
lookup('classes', Array[String], 'unique').include
