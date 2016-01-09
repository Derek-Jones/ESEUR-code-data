#
# daysbetween.awk,  4 Oct 13

BEGIN {
	month["jan"]=1
	month["feb"]=2
	month["mar"]=3
	month["apr"]=4
	month["may"]=5
	month["jun"]=6
	month["jul"]=7
	month["aug"]=8
	month["sep"]=9
	month["oct"]=10
	month["nov"]=11
	month["dec"]=12
	prev_secs=0
	total_secs=0
	num_dates=0
	print "release,day_diff,days"
	}

	{
	num_dates++
	gsub(/:/, " ", $4)
	cur_date=$1 " " month[tolower($2)] " " $3 " " $4
	cur_secs=mktime(cur_date)
	if (prev_secs == 0)
	   print "1,0,0"
	else
	   {
	   total_secs+=(cur_secs-prev_secs)
	   print num_dates "," (cur_secs-prev_secs)/86400, "," total_secs/86400
	   }
	prev_secs=cur_secs
# print cur_date " " cur_secs
	next
	}

