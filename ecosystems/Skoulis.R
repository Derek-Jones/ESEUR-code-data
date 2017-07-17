#
# Skoulis.R,  6 Jun 17
# Data from:
# Analysis of Schema Evolution for Databases in Open-Source Software
# Ioannis Skoulis
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


schema=read.csv(paste0(ESEUR_dir, "ecosystems/Skoulis.csv.xz"), as.is=TRUE)

schema$Date=as.POSIXct(schema$time, origin="1970-01-01")

mediawiki=subset(schema, system == "mediawiki")
ensembl=subset(schema, system == "ensembl")

# Diplaying sequential same value entries creates a cluttered plot
t=rle(ensembl$X.oldT)
t_ind=cumsum(c(1, t$lengths[-length(t$lengths)]))

plot(ensembl$Date[t_ind], ensembl$X.oldT[t_ind], col=pal_col[1],
	xlab="Date", ylab="Tables")

t=rle(mediawiki$X.oldT)
t_ind=cumsum(c(1, t$lengths[-length(t$lengths)]))
points(mediawiki$time[t_ind], mediawiki$X.oldT[t_ind], col=pal_col[2])

legend(x="topleft", legend=c("Ensembl", "Mediawiki"), bty="n", fill=pal_col, cex=1.2)

