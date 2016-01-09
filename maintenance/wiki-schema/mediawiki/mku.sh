
for f in $1 $2 $3 $4 $5 $6 $7
   do
   tr -d "\r" < $f > t
   mv t $f
   done

