#
# 2008merge.awk, 28 Jan 14

BEGIN {
	trial_num=0
	gsub("disktestResults.", "", file_name)
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

$1 == "blockCount:" {
	seeks_per_trial=$2
	next
	}

$1 == "blockSize:" {
	blockSize=$2
	next
	}

	{
	trial_num++
	for (b=1; b <= NF; b++)
	   print disk_str "," sd_str "," trial_num "," b*blockSize "," $b
	next
	}



