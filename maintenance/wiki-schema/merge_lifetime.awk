#
# merge_lifetime.awk, 23 Mar 11

BEGIN {
	print "table_row_name,first_version,last_version,single_occur"
	}

	{
	printf("%s", $1)
	num_singles=0
	last_ver=$2
	lower_bound=$2
	upper_bound=$2
	had_range=0
	for (v=3; v <= NF; v++)
	   {
	   if ((last_ver+1 == $v) ||
	       (last_ver+2 == $v))  # Allow one missing revision
	      {
	      last_ver=$v
	      upper_bound=$v
	      }
	   else
	      {
	      if (lower_bound == upper_bound)
		 {
		 num_singles++
		 }
	      else
		 {
		 printf(",%d,%d", lower_bound, upper_bound)
		 had_range=1
		 }
	      last_ver=$v
	      lower_bound=$v
	      upper_bound=$v
	      }
	   }
	if (lower_bound == upper_bound)
	   num_singles++
	else
	   {
	   printf(",%d,%d", lower_bound, upper_bound)
	   had_range=1
	   }
	if (had_range == 1)
	   printf(",%d\n", num_singles)
	else
	   printf(",0,0,%d\n", num_singles)
	next
	}

