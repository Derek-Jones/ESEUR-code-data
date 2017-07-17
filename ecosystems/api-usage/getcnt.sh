#
# getcnt.sh, 10 Mar 15

echo "method_seq,uses,num_methods,uniq_id"

find . -name "*.csv" -exec awk -f /usr1/rbook/examples/ecosystem/api-usage/getmethod.awk {}  \;


