#
# dev-hist.awk, 27 Oct 14

# Author: Linus Torvalds <torvalds@home.osdl.org>
# Date:   Thu Jan 8 06:57:32 2004 -0800

BEGIN {
	}

$1 == "Author:" {
	$1=""
	author=substr($0, 2)
	gsub(",", ":", author)
	author_cnt[author]++
	getline
# Date: is sometimes missing, so use last seen date
	if ($1 == "Date:")
	   cur_date=$3 "-" $4 "-" $6
	if (author_cnt[author] == 1)
	   first_date[author]=cur_date
	next
	}

END {
	for (a in author_cnt)
	   print a "," author_cnt[a] "," first_date[a] "," linux_rel
	}

