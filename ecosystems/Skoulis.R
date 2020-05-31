#
# Skoulis.R, 24 May 20
# Data from:
# Analysis of Schema Evolution for Databases in Open-Source Software
# Ioannis Skoulis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAB database_evolution schema_evolution


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
	xaxs="i",
	xlab="Date", ylab="Tables\n")

t=rle(mediawiki$X.oldT)
t_ind=cumsum(c(1, t$lengths[-length(t$lengths)]))
points(mediawiki$time[t_ind], mediawiki$X.oldT[t_ind], col=pal_col[2])

legend(x="topleft", legend=c("Ensembl", "Mediawiki"), bty="n", fill=pal_col, cex=1.2)

