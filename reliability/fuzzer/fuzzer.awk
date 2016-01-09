#
# fuzzer.awk  6 Mar 14

BEGIN {
	cur_line=""
	last_op=""
	print "program,language,operation,fuzz_status,comp_status,run_status,out_status"
	}

function write_line(line_str)
{
if (line_str == "")
   return
gsub("Fuzz", "", line_str)
if (last_op == "COMPILE")
   print line_str ",NA,NA"
else if (last_op == "RUN")
   print line_str ",NA"
else
   print line_str
last_op=""
cur_line=""
}


$3 == "prime" || $3 == "original" {
	next
	}

$4 == "FUZZ" {
	write_line(cur_line)
	if ($5 == "OK")
	   {
	   cur_line=$1 "," $2 "," $3 "," $5
	   }
	else
	   write_line($1 "," $2 "," $3 "," $5 ",NA,NA,NA")
	next
	}

	{
	last_op=$4
	cur_line=cur_line "," $5
	next
	}

END {
	write_line(cur_line)
	}

