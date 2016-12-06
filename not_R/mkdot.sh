#
# mkdot.sh, 13 Nov 16
#
# dot is part of graphviz

for f in *.dot
   do
   filename=`basename $f .dot`
   dot -Tpdf $f > $filename.pdf
   dot -Tpng $f > $filename.png
   done

