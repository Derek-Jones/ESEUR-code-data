#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

# 10.1.1.9.2569.R,  8 Dec 14
#
# Data from:
# A Study of Irregularities in File-Size Distributions
# Kylie M. Evans and Geoffrey H. Kuenning

source("ESEUR_config.r")


files=read.csv(paste0(ESEUR_dir, "probability/misc/multi01.csv.xz"), as.is=TRUE, header=FALSE)

# files$V3=as.numeric(files$V3)

# head(sort(table(files$V8), decreasing=TRUE), n=15)

suffix_cnt=function(suffix_str)
{
png_f=subset(files, V8 == suffix_str)
all_files=rep(png_f$V3, png_f$V1)
fd=density(log(all_files), na.rm=TRUE)
plot(fd,
	main="",
	xlab="File size")
# plot(table(log(all_files)))
# hist(log(all_files), breaks=50)
}

#suffix_cnt(".html")
suffix_cnt(".png")

# png_f=subset(files, V8 == ".html")
# all_files=rep(png_f$V3, png_f$V1)

