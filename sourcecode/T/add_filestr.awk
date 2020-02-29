#
# add_filestr.awk, 18 Jun 18

BEGIN {
	first_line=1
	gsub(".csv", "", file_str)
#	gsub("randomSuiteResults", "", file_str)
#	print "program,date,programs"
	}


	{
	print file_str "	" $0
	next
	}

