#
# extractPSQL.awk,  1 Dec 13
#
# Split the data out of a PLSQL database dump into constituent files.
# Some post processing will be required

BEGIN {
	in_copy=0
	}

# COPY scc_author (id, name, email) FROM stdin;
# This is where the data is
$1 == "COPY" {
	in_copy=1
	filename=$2 ".tsv"
	col_str=$3
	for (c=4; c <= NF-2; c++)
	  col_str=col_str " " $c
	print col_str > filename
	next
	}

$1 == "\\." {
	close(filename)
	in_copy=0
	next
	}

in_copy == 1 {
	print $0 >> filename
	next
	}

END {
	close(filename)
	}

