#
# 1905-12111.R, 21 Jan 20
# Data from:
# Analyzing and Supporting Adaptation of Online Code Examples
# Tianyi Zhang and Di Yang and Crista Lopes and Miryung Kim
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Stackoverflow_source-code Github_Stackoverflow

source("ESEUR_config.r")


pal_col=rainbow(2)

cfreq=read.csv(paste0(ESEUR_dir, "economics/1905-12111.csv.xz"), as.is=TRUE)

plot(cfreq$lines, cfreq$attributed/max(cfreq$attributed, na.rm=TRUE), log="x", col=pal_col[2],
	xlab="Lines", ylab="Code fragments (normalised occurrences)\n")

points(cfreq$lines, cfreq$clones/max(cfreq$clones, na.rm=TRUE), col=pal_col[1])

legend(x="topright", legend=c("Clones", "Attributed"), bty="n", fill=pal_col, cex=1.2)

# 
# library(fitdistrplus)
# 
# cl=subset(cfreq, !is.na(clones))
# 
# each_cl=rep(cl$lines, times=cl$clones)
# 
# dummy=descdist(each_cl, boot=500) 
# 
# # The two distributions suggested by descdist
# tln=fitdist(each_cl, distr="lnorm")
# tG=fitdist(each_cl, distr="gamma")
# 
# # summary(tln)
# 
# # gofstat is a simple 'universal' way of getting the values used for plotting
# # Distribution order chosen to get the desired colors.
# theo_vals=gofstat(list(tln, tG),
# 	chisqbreaks=1:120,
# 	fitnames=c("Log Normal", "Gamma"))
# 
# # The first entry in theo_vals$chisqtable, the the distribution, is the
# # cumulative value of everything to the left, i.e., not the actual value
# # at that point.
# lines(theo_vals$chisqbreaks, head(theo_vals$chisqtable[, 1+1], -1)/max(cfreq$clones, na.rm=TRUE), col=pal_col[1])
# lines(theo_vals$chisqbreaks, head(theo_vals$chisqtable[, 1+2], -1)/max(cfreq$clones, na.rm=TRUE), col=pal_col[2])
# 
