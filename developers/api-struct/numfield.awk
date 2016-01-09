#
# numfield.awk,  7 Apr 09

BEGIN {
	num_fields=0
	in_agriculture=0
}

$1 == "//API" {
	in_agriculture= ($2 == KIND_PROB)
	next
	}

in_agriculture == 0 {
	next
	}

$1 == "//" {
	next
	}

($1 == "class") || \
(($1 == "public") && ($2 == "class")) || \
(($1 == "public") && ($2 == "abstract") && ($3 == "class")) || \
($1 == "struct") || \
(($1 == "typedef") && ($2 == "struct")) {
	print "struct"
	if (num_fields != 0)
	   {
	   print num_fields
	   field_count[num_fields]++
	   }
	num_fields=0
	next
	}

($1 == "/*") && ($3 == "*/") {
	#print $0
	num_fields++
	next
	}

END {
	}

