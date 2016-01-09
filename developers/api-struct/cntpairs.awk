#
# cntpairs.awk,  5 Mar 09

BEGIN {
	item_last_seen=0
	}

$1 == ">>" {
	next
	}

$1 == "struct" {
	item_last_seen=0
	next
	}

NF == 3 {
	if (item_last_seen > 0)
	   item_pair[item_last_seen " " $3]++
	item_last_seen=$3
	next
	}

END {
	for (ip in item_pair)
	   print item_pair[ip] "  " ip
	}
