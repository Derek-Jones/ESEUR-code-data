#
# ICPC15.R, 20 May 19
# Data from:
# License Usage and Changes: {A} Large-Scale Study on {GitHub}
# Christopher Vendome and Mario Linares-V\'{a}squez and Gabriele Bavota and Massimiliano {Di Penta} and Daniel German and Denys Poshyvanyk
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java licensing evolution

source("ESEUR_config.r")


library("plyr")


cnt_licenses=function(df)
{
return(data.frame(program=length(unique(df$program)),
			files=sum(df$files)))
}


cnt_prog_licenses=function(df)
{
return(data.frame(num_license=length(unique(df$license)),
			files=sum(df$files)))
}


sum_year=function(df)
{
return(data.frame(program=sum(df$program),
			files=sum(df$files)))
}


plot_lic_cnt=function(df)
{
if (sum(df$files) > 1000)
   lines(df$year, cumsum(df$files))
}


plot_lic_perc=function(df)
{
lines(df$year, 100*cumsum(df$files)/cumsum(year_total$files[df$year-1991]),
	col=df$col_str)
}


lic=read.csv(paste0(ESEUR_dir, "economics/ICPC15.csv.xz"), as.is=TRUE)
lic$year=as.integer(substr(lic$date, 1, 4))
lic=subset(lic, year >= 1992)

l_per_year=ddply(lic, .(year, license), cnt_licenses)
year_total=ddply(l_per_year, .(year), sum_year)

lic_1kfiles=ddply(l_per_year, .(license),
				function(df)
				   if(sum(df$files) < 1000) NULL else df)

lic_str=unique(lic_1kfiles$license)
pal_col=rainbow(length(lic_str))
lic_1kfiles$col_str=mapvalues(lic_1kfiles$license, lic_str, pal_col)

# plot(1950, type="n", log="y",
# 	xlim=c(1995, 2012), ylim=c(1, 1e6),
#	xlab="Year", ylab="Files")
# 
# d_ply(l1k_per_year, .(license), plot_lic_cnt)

plot(1950, type="n", log="y",
	xlim=c(2000, 2012), ylim=c(1e-0, 75),
 	xlab="Year", ylab="Files (cumulative percentage)")

d_ply(lic_1kfiles, .(license), plot_lic_perc)

legend(x="topright", legend=lic_str, bty="n", fill=pal_col, cex=0.9)


# Number of programs whose constituent files contain a given number
# of licenses (denoted by different colored lines; see legend).
# 
# pal_col=rainbow(10)
# 
# 
# cnt_prog_licenses=function(df)
# {
# return(data.frame(num_license=length(unique(df$license)),
# 			files=sum(df$files)))
# }
# 
# 
# plot_prog_lic=function(df)
# {
# lines(df$year, df$freq, col=pal_col[df$x])
# }
# 
# 
# prog_lic=ddply(lic, .(year, program), cnt_prog_licenses)
# year_total=ddply(prog_lic, .(year),
# 				function(df)
# 					count(df$num_license))
# 
# plot(1950, type="n", log="y",
# 	xlim=c(2000, 2012), ylim=c(1, 620),
#  	xlab="Year", ylab="Programs\n")
# 
# d_ply(year_total, .(x), plot_prog_lic)
# 
# 
# legend(x="topleft", legend=1:10, bty="n", fill=pal_col, cex=1.2)
# 
