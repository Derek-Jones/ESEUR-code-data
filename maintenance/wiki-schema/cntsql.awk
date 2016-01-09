#
# cntsql.awk,  4 Oct 13

# Count tables/rows in a Mediawiki table.sql file.
# Count tables/rows that have been added/deleted between consecutive releases 

BEGIN {
	num_file=0
	in_table=0
	prev_total_tables=0; prev_total_rows=0
	total_tables=0 ; tables_added=0
	total_rows=0 ; rows_added=0 ; num_row_diff_type=0
	prev_db[" "]=0 # this array has to exist	
	cur_db[" "]=0 # this array has to exist
	tab_col[" "]=0 # this array has to exist
	print "version,table_total,table_added,table_deleted,row_total,row_added,row_deleted,row_type_change"
	}

# END_FILE is added between files by cnt.sh script
$1 == "END_FILE" {
	num_file++
	printf("%d,", num_file)
	printf("%d,%d,%d,", total_tables, tables_added, (prev_total_tables+tables_added)-total_tables)
	prev_total_tables=total_tables
	total_tables=0 ; tables_added=0
	printf("%d,%d,%d,%d\n", total_rows, rows_added, (prev_total_rows+rows_added)-total_rows, num_row_diff_type)
	prev_total_rows=total_rows
	total_rows=0 ; rows_added=0 ; num_row_diff_type=0
	for (i in tab_col)
	   lifetime[i]=lifetime[i] " " num_file
	delete tab_col
	delete prev_db
	for (i in cur_db)
	   prev_db[i]=cur_db[i]
	delete cur_db
	next
	}

$1 == "CREATE" &&
$2 == "TABLE" {
	# The prefix /*$wgDBprefix*/ is replaced during installation
	sub(/\/\*.+\*\//, "", $3)
	gsub(/`/, "", $3)
	table_name=$3
#print $3 " " total_tables
	if (prev_db[table_name] == 0)
	   tables_added++
	cur_db[table_name]=1
	total_tables++
	in_table=1
	num_rows=0
	next
	}

in_table == 0 {
	next
	}

$1 == "UNIQUE" ||
$1 == "PRIMARY" ||
$1 == "FULLTEXT" ||
$1 == "INDEX" ||
$1 == "KEY" { # ignore keys, unique or otherwise
	next
	}

$1 == ")" ||
$1 == ");" {
	in_table=0
# print table_name
	next
	}

	{
	gsub(/^ +/, "", $0)
	if (($0 == "") || (index($1, "--") == 1))
	   next
	num_rows++
	total_rows++
	gsub(/`/, "", $1)
	table_row=table_name "." $1
	# Reduce lines to some canonical form
	$0=tolower($0)
	gsub(/	/, " ", $0)
	gsub(/ +/, " ", $0)
	gsub(/ +$/, "", $0)
	gsub(/,$/, "", $0)
	gsub(/;$/, "", $0)
	tab_col[table_row]=$0
	cur_db[table_row]=$0
	if (prev_db[table_row] == 0)
	   {
	   num_new_rows++
	   rows_added++
	   }
	else
	   {
# print $0
	   if (prev_db[table_row] != $0)
	      {
# print ">" prev_db[table_row] "< | >"  $0 "<"
	      num_row_diff_type++
	      }
	   }
	next
	}

END {
	print "versions"
	for (i in lifetime)
	   print i " " lifetime[i]
	}

