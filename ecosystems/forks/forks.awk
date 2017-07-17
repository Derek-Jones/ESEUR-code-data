#
# forks.awk,  5 Jun 17

BEGIN {
	print "Year"
	}

$1 == "Date:" {
	for (i=2; i <= NF; i++)
	   if (($i+0 == $i) && ($i > 1990))
	      {
	      print $i
	      next
	      }
	next
	}

