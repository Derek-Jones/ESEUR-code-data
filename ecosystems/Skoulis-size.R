#
# Skoulis-size.R, 19 Jun 17
# Data from:
# Analysis of Schema Evolution for Databases in Open-Source Software
# Ioannis Skoulis
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")
library("survival")

pal_col=rainbow(2)


get_life_death=function(vec)
{
t=rle(c(0, vec) != 0)
t_start=which(t$values)

return(data.frame(start=t$lengths[t_start-1],
			end=t$lengths[t_start-1]+t$lengths[t_start]-1))
}


survival_curve=function(size_history, updates, col_str)
{
s_t=t(size_history)

size_se=adply(s_t, 2, get_life_death)
size_se$lifetime=(updates[size_se$end]-updates[size_se$start])/(60*60*24)

end_time=max(size_se$end)

size_mod=survfit(Surv(size_se$lifetime, size_se$end != end_time) ~ 1)
lines(size_mod, col=col_str)
}


# First non-zero row is version that creates the table, version
# following last non-zero row is when table is deleted.
mediawiki=read.csv(paste0(ESEUR_dir, "ecosystems/mediawiki-size.csv.xz"), as.is=TRUE)
mediawiki$table=NULL
mediawiki$X0=NULL  # No idea why the data contains a zero'th entry
ensembl=read.csv(paste0(ESEUR_dir, "ecosystems/ensembl-size.csv.xz"), as.is=TRUE)
ensembl$table=NULL
ensembl$X0=NULL  # No idea why the data contains a zero'th entry


schema=read.csv(paste0(ESEUR_dir, "ecosystems/Skoulis.csv.xz"), as.is=TRUE)

plot(0, type="n",
	xlim=c(0, 5000), ylim=c(0, 1),
	xlab="Days", ylab="Survival\n")

survival_curve(ensembl, subset(schema, system == "ensembl")$time, pal_col[1])
survival_curve(mediawiki, subset(schema, system == "mediawiki")$time, pal_col[2])

# Legend/color ordering is reversed to match earlier plot, Skoulis.R
legend(x="bottom", legend=c("Mediawiki", "Ensembl"), bty="n", fill=rev(pal_col), cex=1.2)

