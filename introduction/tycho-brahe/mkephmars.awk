#
# mkephmars.awk, 25 Nov 16

BEGIN {
	# Having problems with printing values containing lots of digits
	CONVFMT="%.10g"
	days_since=578150.5
	print "Days.since.1.AD,Declination"
	}

# 1582 11 13  09 24 47.332   +23 14 09.32  1.8050 2.2000  99.8

	{
	print days_since "," $7+($8/60)+($9/3600)
	days_since++
	next
	}

