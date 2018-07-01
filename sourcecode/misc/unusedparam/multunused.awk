#
# multunused.awk,  8 May 11

BEGIN {
	filename=""
	}

length($1) > 1 {
	unused_list[$2]++  # there can only be one definition in a source file
	next
	}

	{
	param_count[$1]++
	}

filename != $3 {
	for (u in unused_list)
	   total_unused[unused_list[u]]++
	unused_list[1]="dummy"
	delete unused_list
	filename=$3
	next
	}

END {
	for (u=1; u <= 8; u++)
	   for (v=1; v <=u; v++)
	      cal_unused[v]+=param_count[u]/(u*7)
	for (u=1; u <= 8; u++)
	   printf("%d, %5d, %5d, %5d\n", u, total_unused[u], param_count[u], cal_unused[u])
	}

