#
# 1507-04587.R, 23 Nov 17
# Data from:
# Lessons learned from applying social network analysis on an industrial Free/Libre/Open Source Software ecosystem
# Jose Teixeira and Gregorio Robles and Jes{\'u}s M. Gonz{\'a}lez-Barahona
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


plot_devs=function(df)
{
pd=t(subset(df, Measure == "perc_developers"))
lines(pd[-(1:2)], col=pal_col[df$col_num])
}


os=read.csv(paste0(ESEUR_dir, "projects/1507.04587.csv.xz"), as.is=TRUE)
companies=unique(os$Company)[-1] # Remove Total

releases=colnames(os)
releases=releases[-(1:2)]

os$col_num=as.integer(mapvalues(os$Company, companies, 1:length(companies)))
pal_col=rainbow(max(os$col_num, na.rm=TRUE))

plot(0, type="n",
	xaxs="i", yaxs="i",
	xaxt="n",
	xlim=c(1, 8), ylim=c(0, 80),
	xlab="", ylab="Developers (%)\n")

x_at=1:8
axis(1, at=x_at, labels=FALSE)
text(x=x_at+0.3, y=par()$usr[3]-0.03*(par()$usr[4]-par()$usr[3]),
                labels=releases, pos=2, srt=30, cex=1.1, xpd=TRUE)

d_ply(os, .(Company), plot_devs)

legend(x="topright", legend=companies, bty="n", fill=pal_col, cex=1.2)

