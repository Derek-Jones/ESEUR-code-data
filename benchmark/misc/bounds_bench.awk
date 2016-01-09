#
# bounds_bench.awk, 17 Aug 14
#
# Takes original data, samples.txt, and produces bounds_chk.csv as output
# A Case study of Performance Degradation Attributable to Run-Time Bounds Checks on {C++} Vector Access

function print_val(s_l, val)
{
# "time,s_l,is_1st,opt,expr
printf("%d", val)
printf(",%s", s_l)
printf(",%d", is_1st)
printf(",o%d", cur_opt)
printf(",v%d", cur_variant)
printf(",vp%d", variant_pos)
printf("\n")
}


BEGIN {
	is_1st=0
	prev_opt=""

# numOpt       =  7
# numCVariant  =  3
# numVariant   = 12
# numRotation  =  9

	opts[0]= "--O0"
	opts[1]= "--O1"
	opts[2]= "--O2"
	opts[3]= "--O3"
# Ought to split the following up into their component parts...
	opts[4]= "--O3 --flto"
	opts[5]= "--O3 --fmudflap --fmudflapir"
	opts[6]= "--O3 --fmudflap"

	variants[0]= "C pointer"
	variants[1]= "C array[i]"
	variants[2]= "C array[x[i]]"
	variants[3]= "C++ pointer"
	variants[4]= "C++ array[i]"
	variants[5]= "C++ array[x[i]]"
	variants[6]= "C++ vector std::fill"
	variants[7]= "C++ vector iterator"
	variants[8]= "C++ vector[i]"
	variants[9]= "C++ vector.at(i)"
	variants[10]= "C++ vector[x[i]]"
	variants[11]= "C++ vector.at(x[i])"
	print "time,s_l,is_1st,opt,expr,expr_pos"
	}

$1 == "begin" {
# Variant order changes according to a latin square design.
# Record variant position in order
	if (prev_opt != $2)
	   {
	   prev_opt=$2
	   variant_pos=1
	   }
	else
	   {
	   if ($2 < 5)
	      max=12
	   else
	      max=3
	   if (variant_pos >= max)
	      variant_pos=0
	   variant_pos++
	   }
	cur_opt=$2
	cur_variant=$3
	is_1st=1
	next
	}

	{
	print_val("S", $1)
	print_val("L", $2)
	is_1st=0
	next
	}

