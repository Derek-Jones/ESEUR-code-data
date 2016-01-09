#
# merge-data.awk, 28 Jan 14

BEGIN {
	gsub(".data", "", file_name)
	gsub(".test0", "", file_name)
	num_sub=split(file_name, name_sub, ".")
	disk_str=name_sub[1]
	trial_num=0
	for (s=2; s <= num_sub; s++)
	   {
	   if (index(name_sub[s], "trial") == 1)
	      {
	      gsub("trial", "", name_sub[s])
	      trial_num=name_sub[s]
	      }
	   else if (index(name_sub[s], "sd") == 1)
	      {
	      sd_str=name_sub[s]
	      }
	   else
	      disk_str=disk_str "." name_sub[s]
	   }
	}

$1 == "NUM_SEEKS_PER_TRIAL:" {
	seeks_per_trial=$2
	next
	}

$1 == "NUM_TRIALS:" {
	num_trials=$2
	next
	}

# bufaliged ix fa50000
$1 == "bufaliged" {
	next
	}

$1 == "total" && ($2 == "sectors:" ||$2 == "blocks:") {
	total_sectors=$3
	next
	}

# 128.000000, 1863578, 68.685078
	{
	gsub(" ", "", $0)
	print disk_str "," sd_str "," trial_num "," total_sectors "," $0
	next
	}



