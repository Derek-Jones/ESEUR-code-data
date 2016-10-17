#
# mkrobinson.awk,  8 Oct 16

BEGIN {
	item_list[1]=" "
	}

$1 == ">>" ||
$1 == "New-Subject" {
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
	   printf("%d", robinson[1 " " j])
	   for (j=2; j <= 25; j++)
	      printf(",%d", robinson[i " " j])
	   printf("\n")
	   }
	}
