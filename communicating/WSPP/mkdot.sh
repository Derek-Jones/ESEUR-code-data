#
# mkdot.sh, 24 Aug 15

awk -f xref.awk wspp-09-xref.txt > interest.dot
awk -f xref.awk -vkeep_pop=1 wspp-09-xref.txt > all.dot

dot -Tps interest.dot > interest.ps
dot -Tps all.dot > all.ps


