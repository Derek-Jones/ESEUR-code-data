#
# mksurvive.awk,  3 Oct 13

BEGIN {
	init_v=-10
	print "tab_col,first_v,last_v"
	}

function print_versions(first, last)
{
if (last-first < 1)
   return
print $1 "," first "," last
}


#
# Merge lifetimes into a first/last range
	{
	start_v=init_v
	last_v=init_v
	for (v=2; v <= NF; v++)
	   {
	   if ((last_v+1 == $v) ||
	       (last_v+2 == $v)) # Allow a gap of one version
	      last_v=$v
	   else
	      {
	      print_versions(start_v, last_v)
	      start_v=$v
	      last_v=$v
	      }
	   }
	print_versions(start_v, last_v)
	next
	}

