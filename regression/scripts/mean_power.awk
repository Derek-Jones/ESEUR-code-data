#
# mean_power.awk, 20 Jan 14

BEGIN {
	first_time=0
	total_power=0
	}

first_time == 0 {
	first_time=$1
	}

	{
	last_time=$1
	total_power+=$2+$3+$4
	next
	}

END {
	printf("%f,", total_power/(last_time-first_time))
	}

