#
# 18-023a.R,  2 Dec 19
# Data from:
# Some Facts of High-Tech Patenting
# Michael Webb and Nicholas Bloom and Nick Short and Josh Lerner
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG patents_software

source("ESEUR_config.r")


library("plyr")


spat=read.csv(paste0(ESEUR_dir, "economics/18-023a.csv.xz"), as.is=TRUE)

u_str=unique(spat$File)
pal_col=rainbow(length(u_str))

spat$col_str=mapvalues(spat$File, u_str, pal_col)

plot(0, type="n", log="y",
	xlim=c(1980, 2017), ylim=c(1, 1e5),
	xlab="Year", ylab="Patents granted\n")

d_ply(spat, .(File), function(df) lines(df$filing_year, df$patent_count, col=df$col_str[1]))

legend(x="topleft", legend=rev(u_str), bty="n", fill=rev(pal_col), cex=1.2)


