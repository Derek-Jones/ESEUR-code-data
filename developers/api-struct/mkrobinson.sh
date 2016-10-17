#
# mkrobinson.sh,  8 Oct 16

cat item.list > similar_08.csv

cat 2008/scan* | awk -f absfield.awk   | awk -f mkrobinson.awk >> similar_08.csv

