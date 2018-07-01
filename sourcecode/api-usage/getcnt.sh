#
# getcnt.sh, 12 Jun 18

echo "method_seq,uses,num_methods,uniq_id"

find . -name "*.csv" -exec awk -f /usr1/rbook/examples/sourcecode/api-usage/getmethod.awk {}  \;


