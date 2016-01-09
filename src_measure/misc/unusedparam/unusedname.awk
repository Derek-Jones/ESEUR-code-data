#
# unusedname.awk,  7 May 11
#
# Compare unused parameter names
# counting how many have the same name as other unsued parameters
# in the same position in function definitions in the same source file.

BEGIN {
	file_name=""
	new_file=1
	}	

length($1) != 1 {
	# The first unused parameter in a source file is not counted
	if (param_pos[$1] == "")
	   {
	   param_pos[$1]=$3
	   next
	   }
	if (param_pos[$1] == $3)
	   s_count[$1]++
	else
	   {
	   param_pos[$1]=$3
	   d_count[$1]++
	   }
	next
	}

file_name != $3 {
	param_pos[1]="dummy value" # make sure it has at leasr one value
	delete param_pos
	file_name=$3
	next
	}

END {
   s_total=0
   d_total=0
   for (p in s_count)
      {
      printf("%s, %4d, %4d, %3.1f\n", p, s_count[p], d_count[p], \
			(100.0*s_count[p])/(s_count[p]+d_count[p]))
      s_total+=s_count[p]
      d_total+=d_count[p]
      }
   for (p in d_count)
      if (s_count[p] == 0)
	 {
	 printf("%s, %4d, %4d, %3.1f\n", p, s_count[p], d_count[p], \
			(100.0*s_count[p])/(s_count[p]+d_count[p]))
	 d_total+=d_count[p]
	 }
   printf("%s, %4d, %4d, %3.1f\n", "Total", s_total, d_total, \
			(100.0*s_total)/(s_total+d_total))
   }

