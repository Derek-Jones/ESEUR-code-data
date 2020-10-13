#
# mkpic.sh,  4 Sep 20

GROFF=groff

for f in *.pic
   do   
   filename=`basename $f .pic`
#   pic $f | $GROFF > ps/$filename.ps
   $GROFF -p -Tpdf $f > $filename.pdf 
   $GROFF -p $f > $filename.ps 

   gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=png16m -r300 -sOutputFile=$filename.png $filename.ps
   rm $filename.ps
#   ./bndpdf.sh $filename.ps > $filename.pdf
   done 


# The .MC command uses paper width to calculate multi-column widths,
# not the current line length.
$GROFF -ms -Tpdf -dpaper=a4l < idexam1.rof > idexam1.pdf

