#
# itemord.awk, 25 Jan 09

BEGIN {
	first_line=0
	line_count=0
	}

	{
	if (first_line == 0)
	   first_line=$0
	else
	   {
	   line_count++
	   line[line_count]=$0
	   }
	next
	}

END {
	max_lines=split(first_line, line_mapping)
	for (i=1; i <=max_lines; i++)
	   print i " " line[line_mapping[i]]
	}
 
