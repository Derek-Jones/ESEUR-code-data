#
# fieldord.awk, 11 Jan 09

BEGIN {
	seen_struct=0
	while (getline < "a008302.txt")
	   {
	   if ($1 == "*")
	      {
	      cur_index=$2
	      num_comb=0
	      }
	   else
	      {
	      num_comb++
	      dist_count[cur_index " " num_comb]=$2
	      }
	   }
}

function field_info_dist()
{
if (num_fields < 2)
   return

distance=0
for (i=1; i <= num_fields; i++)
   for (j=i+1; j <= num_fields; j++)
      distance+= (info_num[i] < info_num[j])

sum_fact=0
for (i=1; i < num_fields; i++)
   {
   sum_fact += i;
   }

print "field-info " num_fields " distance " distance " " sum_fact

dist_diff=sum_fact-distance+1
dist_prob=dist_count[num_fields " " dist_diff]+0.0
print "diff " dist_diff " possibilities " dist_prob
for (i=2; i <=num_fields; i++)
   {
   dist_prob /= i
   }
printf("probability %7.5f  %5.3f\n", dist_prob*100.0, (distance*100.0)/sum_fact)
}

$1 == "//" {
	next
	}

($1 == "class") || \
(($1 == "public") && ($2 == "class")) || \
(($1 == "public") && ($2 == "abstract") && ($3 == "class")) || \
($1 == "struct") || \
(($1 == "typedef") && ($2 == "struct")) {
	if (seen_struct != 0)
	   field_info_dist()
	print "struct"
	seen_struct=1
	num_fields=0
	next
	}

($1 == "/*") && ($3 == "*/") {
	print $2
	if ($2 != "*")
	   {
	   for (i=1; i <=num_fields; i++)
	      if (info_num[i] == $2)
		 next
	   num_fields++
	   info_num[num_fields]=$2
	   }
	next
	}

END {
	field_info_dist()
	}

