#
# mkit.sh, 18 Aug 16

GROFF=groff

for f in *.pic
   do   
   filename=`basename $f .pic`
#   pic $f | $GROFF > ps/$filename.ps
   $GROFF -p $f > $filename.ps 
   done 

gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m -r300 -sOutputFile=$filename.png $filename.ps

