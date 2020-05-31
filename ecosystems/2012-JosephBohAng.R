#
# 2012-JosephBohAng.R, 13 May 20
# Data from:
# The Career Paths Less (or More) Traveled: {A} Sequence Analysis of {IT} Career Histories, Mobility Patterns, and Career Success
# Damien Joseph and Wai Fong Boh and Soon Ang and Sandra A. Slaughter
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG career_developer

source("ESEUR_config.r")


library("plyr")


career_path=function(cpath, y_off)
{
col_vec=col=mapvalues(cpath, u_jobs, pal_col)
sapply(1:length(cpath), function(X)
		lines(c(start_year+X-2, start_year+X-1), rep(y_off, 2),
			col=col_vec[X], lwd=4))
return(NULL)
}


# Use data from table 3 until I figur eout a way around the NLSY data.
jba=read.csv(paste0(ESEUR_dir, "ecosystems/2012-JosephBohAng.csv.xz"), as.is=TRUE)

plot(-1, bty="n", type="n",
	yaxs="i", yaxt="n",
	xlim=c(1976, 2000), ylim=c(0.0, 0.7),
	xlab="Year", ylab="Career paths")

start_year=min(jba$Year)
u_jobs=unique(c(NA, "I", jba$G1, jba$G2, jba$G3, jba$G4, jba$G5, jba$G13, jba$G14))

pal_col=c("white", rainbow(length(u_jobs)-1))

d=career_path(jba$G1, 0.1)
d=career_path(jba$G2, 0.18)
d=career_path(jba$G3, 0.29)
d=career_path(jba$G4, 0.39)
d=career_path(jba$G5, 0.48)
d=career_path(jba$G13, 0.57)
d=career_path(jba$G14, 0.67)

legend(x="left", legend=c("IT", "School", "Non-IT professional", "Craft", "Sales", "Technician", "Clerical", "IT management", "Non-IT manager", "Unemployed"),
	inset=c(-0.045, 0), bty="n", fill=pal_col[-1], cex=1.2)


