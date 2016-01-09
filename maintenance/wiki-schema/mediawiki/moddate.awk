#
# moddate.awk, 20 Mar 11

# Extract modified date from saved Mediawiki tables svn page

BEGIN {
	mod_cnt=280
	}

$1 == "Modified" {
	print $6 " " $3 " " $4 " " $5 " " mod_cnt
	mod_cnt--
	next
	}

$1 == "Added" &&
$7 == "UTC/" {
	print $6 " " $3 " " $4 " " $5 " " mod_cnt
	mod_cnt--
	next
	}

