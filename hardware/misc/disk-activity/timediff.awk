#
# timediff.awk, 25 Jun 11

BEGIN {
	print "time_gap"
	}

$5 == read_write {
	print $4
	next
	}

