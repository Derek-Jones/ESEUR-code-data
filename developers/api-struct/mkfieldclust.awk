#
# mkfieldclust.awk,  8 Oct 16

function print_clust()
{
if (seen_clust_field == 1)
   {
   seen_clust_field=2
   printf("%d", subject_num)
   for (i=1; i <=25; i++)
      printf(",%d", item_list[i])
   printf("\n")
   }
}


BEGIN {
	item_list[1]=" " # prevent spurious errors from delete
	subject_num=0
	clust_field=fieldclust
	}

$1 == ">>" {
	next
	}

$1 == "New-Subject" {
	print_clust()
	subject_num++
	seen_clust_field=0
	next
	}

$1 == "struct" {
	print_clust()
	delete(item_list)
	next
	}

	{
	if ($1 == clust_field)
	   seen_clust_field=1
	item_list[$1]=1
	next
	}

END {
	print_clust()
	}
