#
# readability-code.awk,  2 Oct 11

function init_vars()
{
total_lines=0
num_nb_lines=0
num_idents=0
total_chars=0
total_cmpd=0
}

BEGIN {
	init_vars()
	total_snippets=0
	}

$1 == "X-X-X" {
        total_snippets++
	sub(/snippets\//, "", $2)
        sub(/\.jsnp/, "", $2)
        num_snippets=$2
	snippet_len[num_snippets]=total_chars
	snippet_cmpd[num_snippets]=total_cmpd
	snippet_num_id[num_snippets]=num_idents
	snippet_nb_lines[num_snippets]=num_nb_lines
	snippet_total_lines[num_snippets]=total_lines
	init_vars()
	next
	}

	{
	total_lines++
	# remove indentation
	line=gensub(/^ +/, "", $0)
	line_len=length(line)
	if (line_len == 0)
	   next
	total_chars+=line_len

	# Blank lines not counted
	num_nb_lines++
	if (index(line, "if") != 0)
	   total_cmpd++
	else if (index(line, "else") != 0)
	   total_cmpd++
	else if (index(line, "for") != 0)
	   total_cmpd++
	else if (index(line, "while") != 0)
	   total_cmpd++
	else if (index(line, "switch") != 0)
	   total_cmpd++
	line=tolower(line)
	gsub(/[^a-z]+/, " ", line)
	# gensub(/[\+\-\()\[\;\{\}\]\*\.\<\>:=,\&\!]+/, " ", line)
	num_idents+=split(line, idents, " ")
	next
	}

END {
	print "length,num_cmpd,num_id,num_nb_lines,total_lines"
	for (ns=1; ns <= total_snippets; ns++)
	   print snippet_len[ns] "," snippet_cmpd[ns] "," snippet_num_id[ns] ","\
                              snippet_nb_lines[ns] ","snippet_total_lines[ns]
	}

# Other attributes that might be counted
# Number of unique identifiers
# Average number of times an identifier occurs
# if
# while
# assignment
# number of operators

