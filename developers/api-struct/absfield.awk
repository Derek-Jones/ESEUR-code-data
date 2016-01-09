#
# absfield.awk,  5 Mar 09

BEGIN {
	seen_descrip=0
	in_agriculture=0
	animal_crop=1
	item_count=0
	while (getline < "itemlist.txt")
	   {
	   item_count++
	   if ($1 == "====")
	      {
	      animal_crop=0
	      #item_count=0
	      }
	   else
	      {
	      num_items=split($0, desc, / \| /)
	      for (i=1; i <= num_items; i++)
		 {
		 #print "|" desc[i] "|"
		 if (item_info[desc[i]] == "")
		    item_info[desc[i]]=item_count " " i
		 }
	      }
	   }
	}

$1 == "//API" {
	in_agriculture= ($2 == "Agriculture")
	if (seen_descrip)
	   delete descrip_num
	seen_descrip=0
	next
	}

in_agriculture == 0 {
	next
	}

($1 == "class") || \
(($1 == "public") && ($2 == "class")) || \
(($1 == "/*public*/") && ($2 == "class")) || \
(($1 == "abstract") && ($2 == "class")) || \
(($1 == "/*abstract*/") && ($2 == "class")) || \
(($1 == "public") && ($2 == "abstract") && ($3 == "class")) || \
($1 == "struct") || \
(($1 == "typedef") && ($2 == "struct")) {
	print "struct"
	seen_struct=1
	num_fields=0
	next
	}

($2 == ")") {
	seen_descrip=1
	descrip=$3
	for (i=4; i <= NF; i++)
	   descrip=descrip " " $i
	if (item_info[descrip] == "")
	   print ">> Ill-formed |"  descrip "|"
	descrip_num[$1]=descrip
	next
	}

($1 == "/*") && ($3 == "*/") {
	if ($2 == "*")
	   next
	if (seen_descrip == 1)
	   {
	   if (item_info[descrip_num[$2]] == "")
	      print $0 ">" $2 " |" descrip_num[$2]
	   print item_info[descrip_num[$2]] " " $2
	   }
	else
	   {
	   split($0, desc, /\/\/\* /)
	   #print desc[2]
	   if (item_info[desc[2]] == "")
	      print ">> Ill-formed //* comment |"  desc[2] "|"
	   print item_info[desc[2]] " " $2
	   }
	next
	}

END {
	}

