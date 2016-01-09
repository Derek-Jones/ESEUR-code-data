#
# mkrobinson.awk, 27 Jan 09

BEGIN {
	item_list[1]=" "
	}

$1 == ">>" {
	next
	}

$1 == "struct" {
	delete(item_list)
	next
	}

	{
	item_list[$1]="_"
	for (i in item_list)
	   if (i != $1)
	      {
	      robinson[i " " $1]++
	      robinson[$1 " " i]++
	      }
	next
	}

END {
	for (i=1; i <=25; i++)
	   {
	   for (j=1; j <= 25; j++)
	      printf("%d ", robinson[i " " j])
	   printf("\n")
	   }
	}
