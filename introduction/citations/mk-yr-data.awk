#
# mk-yr-data.awk, 16 Dec 19
#
#  year =         "2019",
#  data =         "NA",

BEGIN {
	print"year;data"
	}

$1 == "year" {
	year=substr($3, 2, 4)
	next
	}

$1 == "data" {
	print year ";" substr($3, 2, length($3)-3)
	next
	}

