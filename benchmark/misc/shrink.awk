#
# shrink.awk, 19 Aug 14
#
# Takes bounds_chk.csv as input

BEGIN {
	FS=","
	count=1
	}

# time,s_l,is_1st,opt,expr,expr_pos
# Very few instances of is_1st, so make sure we get them all
$3 == 1 {
	print $0
	next
	}

count == 1 {
	count=7
	print $0
	next
	}

	{
	count--
	next
	}

