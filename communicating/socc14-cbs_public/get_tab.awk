#
# get-tab.awk, 29 Oct 15

BEGIN {
	sw_kind=""
	i_kind=""
	}

# [CASSANDRA-6622][Streaming session failures during node replace of same address]
# t-bug
# a-avail
# sw-logic
# i-down
# c-str

$1 ~ /^\[/ {
	if ((sw_kind != "") && (i_kind != ""))
	   sw_i_count[sw_kind "," i_kind] +=1
	sw_kind=""
	i_kind=""
	next
	}

$1 ~ /^sw/ {
	sw_kind=substr($1, 4)
	next
	}


$1 ~ /^i-/ {
	i_kind=substr($1, 3)
	next
	}

END {
	print "software,implication,count"
	for (k in sw_i_count)
	   print k "," sw_i_count[k]
	}


