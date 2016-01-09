#
# getlinecnt.awk, 19 Oct 13

#  . (10):(super):(b:sem->gene):(s:crash->af):(r:fail):(rep:divide_by_zero) 1 18 12
$1 == "." {
	if (NF < 5)
	   next
	nf=split($2, info_str, ":")
	reason_ch=substr(info_str[3], 2, 1)
# maintenance patches follow a different format  (misc->maintenance_type)
	if (reason_ch == "")
	   reason_ch="m"
	files[reason_ch "," $3]++
	added_lines[reason_ch "," $4]++
	deleted_lines[reason_ch "," $5]++
	next
	}

END {
	print "Files"
	for (f in files)
	   print f "," files[f]

	print "added"
	for (f in added_lines)
	   print f "," added_lines[f]

	print "deleted"
	for (f in deleted_lines)
	   print f "," deleted_lines[f]
	}

