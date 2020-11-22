#
# fse15.R,  7 Oct 20
# Data from:
# Tianyin Xu and Long Jin and Xuepeng Fan and Yuanyuan Zhou and Shankar Pasupathy and Rukma Talwadker
# Hey, You Have Given Me Too Many Knobs! {Understanding} and Dealing with Over-Designed Configuration in System Software
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG mysql_option configuration_option


source("ESEUR_config.r")


mysql_opt=read.csv(paste0(ESEUR_dir, "reliability/fse15.csv.xz"), as.is=TRUE)

table(mysql_opt$section)
table(mysql_opt$option)


cnt_len=sapply(3:ncol(mysql_opt), function(X)
				 return(length(which(!is.na(mysql_opt[ , X])))))

plot(sort(cnt_len),
	ylab="Total entries")

#
# R, awk and sh files used to create a single csv from the mysql cnf files
#
# library("plyr")
# 
# 
# add_opts=function(file_str)
# {
# # print(file_str)
# opts=read.csv(file_str, as.is=TRUE)
# 
# t=rbind.fill(all_opts, opts)
# return(t)
# }
# 
# 
# 
# opt_files=list.files(path="v-5.x", pattern="*csv", full.names=TRUE)
# 
# all_opts=data.frame(null="")
# 
# all_opts=adply(opt_files, 1, add_opts)
# 
# 
# all_opts$X1=NULL
# all_opts$NULL.=NULL
# 
# write.csv(t(all_opts), file="/usr1/rbook/mysql_opts.csv")
# 
# 
# #
# # getopts.awk,  7 Oct 20
# 
# BEGIN {
# 	FS=" "
# 	opts=""
# 	opt_vals=""
# 	hdr_str="NULL_X_"
# 	}
# 
# # strip leading/trailing whitespace from line
# 	{
# 	gsub(/^[[:space:]]+/, "", $0)
# 	gsub(/[ \t\v]+$/, "", $0)
# 	}
# 
# 	{
# 	gsub(/set-variable[[:space:]]*=[[:space:]]*/, "", $0)
# 	}
# 
# # skip comments
# (index($0, "#") == 1) || (index($0, ";") == 1) {
# 	next
# 	}
# 
# # skip blank lines
# $0 == "" {
# 	next
# 	}
# 
# # include a file
# index($0, "!") == 1 {
# 	opts=opts "," substr($1, 2)
# 	opt_vals=opt_vals "," $2
# 	next
# 	}
# 
# 
# 
# 	{
# 	# skip headers
# 	if (index($1, "[") == 1)
# 	   {
# 	   hdr_str=tolower(substr($1, 2, length($1)-2)) "_X_"
# 	   next
# 	   }
# 	gsub(/[[:space:]]*#.*$/, "", $0) # comment after option
# 	# various whitespace between option and its value
# 	gsub(/\t=/, "=", $0)
# 	gsub(/ +=/, "=", $0)
# 	gsub(/\t=/, "=", $0)
# 	gsub(/= +/, "=", $0)
# 	# stop commas in option value confusing things
# 	gsub(/,/, "|", $0)
# 	# gsub(/\\/, "\\\\", $0)
# 	# gsub(/\"/, "\\\"", $0)
# 	num_parts=split($0, parts, "=")
# 	# - and _ are interchangeable in options
# 	gsub("-", "_", parts[1])
# 	hdr_opt=hdr_str parts[1]
# 	# Only keep one option setting, the first
# 	# for ease of implementation
# 	if (seen_ho[hdr_opt] == 1)
# 	   next
# 	seen_ho[hdr_opt]=1
# 	opts=opts "," hdr_opt
# 	if (num_parts == 1)
# 	   opt_vals=opt_vals ",\"\""
# 	else
# 	   opt_vals=opt_vals "," parts[2]
# 	   # opt_vals=opt_vals ",\"" parts[2] "\""
# 	next
# 	}
# 
# END {
# 	if (opts == "") # empty file
# 	   {
# 	   print "NULL"
# 	   print "NA"
# 	   }
# 	# remove leading comma
# 	else
# 	   {
# 	   print substr(opts, 2)
# 	   print substr(opt_vals, 2)
# 	   }
# 	}
# 
# 
# #
# # getopts.sh
# 
# for f in v-5.x/*.cnf
#    do
#    awk -f getopts.awk < $f > "$f.csv"
#    done
# 
