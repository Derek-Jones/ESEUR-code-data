#
# patchinf.awk,  9 Jun 13

BEGIN {
	print "kind,file,added,deleted"
	}

$1 == "." {
	if (index($2, ":(b:") != 0)
	   printf("bug")
	else if (index($2, ":(p:") != 0)
	   printf("performance")
	else if (index($2, ":(c:") != 0)
	   printf("reliability")
	else if (index($2, ":(misc->") != 0)
	   printf("maintenance")
	else if (index($2, ":(f)") != 0)
	   printf("feature")
	else
	   printf("unknown")
	if (NF > 4)
	   print "," $(NF-2) "," $(NF-1) "," $NF
	else
	   print "NA,NA,NA"
	next
	}

