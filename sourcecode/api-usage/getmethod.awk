#
# getmethod.awk, 10 Mar 15

# call:<int length()> call:<char charAt(int)>,39
BEGIN {
	FS=" "
	total_uses=0
	num_seqs=-1  # So the header is not counted
	}

	{
	num_seqs++
	m_len=split($NF, m_fields, ",")
	use_cnt=m_fields[m_len]
	total_uses+=use_cnt

	name_list=""
	last_name=""

	for (m=2; m <= NF; m+=2)
	   {
	   open_b=index($m, "(")
	   next_name=substr($m, 1, open_b-1)
# Merge same method called with different parameter types
	   if (next_name != last_name)
	      name_list=name_list "-" next_name
	   last_name=next_name
	   }
# Remove leading -
	name_list=substr(name_list, 2)
# Not the header
	if (NF > 1)
	   meth_cnt[name_list]+=use_cnt
	next
	}

END {
	if (total_uses < 100)
	   exit
	if (num_seqs < 10)
	   exit
	srand(total_uses)
	uniq_id=PROCINFO["pid"]+int(100000000*rand()) # pid might wrap
	for (m in meth_cnt)
	   print m "," meth_cnt[m] "," split(m, dummy, "-") "," uniq_id
	}

