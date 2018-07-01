#
# simp.awk, 11 Jun 18
#
# Simplify Landman_Jsrc_cc-sloc.csv

BEGIN {
	FS="\""
	num_f1=0
	num_f2=0
	num_f3=0
	first=1
	}

# 10_10_-truezip_explorer,"|corpus+sourcerer:///10/10/truezip-explorer/src/com/agiledevelopments/zippy/search/IndexResourcesConsumer.java|(2461,103,<55, 22>,<58,2>)",IndexResourcesConsumer,1,1,4
first != 1 {
	if (f1[$1] == "")
	   {
	   num_f1++
	   f1[$1]=num_f1
	   }
	split($2, file_str, "|")
	if (f2[file_str[2]] == "")
	   {
	   num_f2++
	   f2[file_str[2]]=num_f2
	   }
	split($3, name_cc, ",")
#	if (f3[name_cc[2]] == "")
#	   {
#	   num_f3++
#	   f3[name_cc[2]]=num_f3
#	   }
	print f1[$1] "," f2[file_str[2]] "," \
		name_cc[3] "," name_cc[5]
	next
	}

	{
# project,file,name,cc,ccWrong,sloc
	print "project,file,cc,sloc"
	first=0
	}

END {
#	print "---"
#	for (f in f1)
#	   print f1[f] "," f
#	print "---"
#	for (f in f2)
#	   print f2[f] "," f
#	print "---"
#	for (f in f3)
#	   print f3[f] "," f
	}

