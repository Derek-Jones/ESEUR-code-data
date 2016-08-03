#
# strip4.awk, 31 May 11

   {
   printf("%s", $5)
   for (i=6; i <= NF; i++)
      printf(" %s", $i)
   printf("\n")
   next
   }

