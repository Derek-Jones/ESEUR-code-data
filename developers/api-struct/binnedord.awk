#
# binnedord.awk,  1 Feb 09

BEGIN {
	for (b=0; b <= 20; b++)
	   bins[b]=0
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
# Pick 8 fields as a 'typical' large value.
# Sum all combinations and work out a binned probability so a
# 'bell' shaped graph can be compared against the experimental data.
	total_8_fields=0
	for (b=0; b <= 50; b++)
	   total_8_fields += dist_count[8 " " b]
	max_combos=0
	for (b=0; b <= 50; b++)
	   if (dist_count[8 " " b] != 0)
	      max_combos=b
	for (b=0; b <= max_combos; b++)
	   dist_bins[b]+=(100.0*dist_count[8 " " b])/total_8_fields
	}

$2 < 5.0 {
	bins[int($3/5)]++
	next
	}

END {
	bin_total=0
	for (b=0; b <= 20; b++)
	   bin_total += bins[b]
# Values are binned, so we need to multiply by some value to take into
# account adjacent binned data that is not displayed.
# max_combos/20 is a very rough and ready value.
	for (b=0; b <= 20; b++)
	   printf("%d %5.2f %5.2f\n", 5*b, (100.0*bins[b])/bin_total, \
				(max_combos/20.0)*dist_bins[int(b*((max_combos-0.9)/20.0))])
	}

