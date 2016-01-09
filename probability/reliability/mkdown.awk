#
# mkdown.awk, 24 Oct 13

BEGIN {
	TEN_MIN=60*10
	last_time=18222228/TEN_MIN
	col_str=""
	for (t=0; t<=last_time; t++)
	   total_avail[t]=""
	}

$2 > 10 {
	for (t=0; t<=last_time; t++)
	   avail[t]=0
# Last field has no end time and is ignored
	for (f=3; f < NF; f+=2)
	   {
	   start_t=int($f/TEN_MIN)
	   end_t=int($(f+1)/TEN_MIN)

	   for (t=start_t; t < end_t; t++)
	      avail[t]=1
	   }
	col_str=col_str "," $1
	for (t in avail)
	   total_avail[t]=total_avail[t] "," avail[t]
	next
	}

END {
	print col_str
	for (t=0; t<=last_time; t++)
	   print total_avail[t]
	}

