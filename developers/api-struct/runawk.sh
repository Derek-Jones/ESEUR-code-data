#
# runawk.sh,  7 Mar 09
cat 2005/scan* | awk -f absfield.awk   | awk -f mkrobinson.awk > similar.05
cat 2008/scan* | awk -f absfield.awk   | awk -f mkrobinson.awk > similar.08
cat 2005/scan* 2008/scan* | awk -f absfield.awk   | awk -f mkrobinson.awk > similar.0508

cat loyola08-annotated/stud* | awk -f absfield.awk   | awk -f mkrobinson.awk > similar.loy

cat 2005/scan* 2008/scan* loyola08-annotated/stud* | awk -f absfield.awk   | awk -f mkrobinson.awk > similar.all
#

cat 2008/scan* 2008/scan* | awk -f fieldord.awk  > prof.ford
grep probability < prof.ford  | sort -g -k 2 > f_i_prof.d
cat loyola08-annotated/stud* | awk -f fieldord.awk > loy.ford
grep probability < loy.ford  | sort -g -k 2 > f_i_loy.d
cat 2005/scan* 2008/scan* loyola08-annotated/stud* | awk -f fieldord.awk > all.ford
grep probability < all.ford  | sort -g -k 2 > f_i_all.d

