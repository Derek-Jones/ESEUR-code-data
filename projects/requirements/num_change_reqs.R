#
# num_change_reqs.R, 15 Jul 16
#
# Data from:
# Observational Models of Requirements Evolution
# Massimo Felici
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

plot_layout(2, 1)

# Values were estimated visually from the pdf.
# So some degree of fuzziness is to be expected.
req_changes=read.csv(paste0(ESEUR_dir, "projects/requirements/num_change_reqs.csv.xz"), as.is=TRUE)
req_changes=trunc(req_changes*100+0.5)

perc_changes=read.csv(paste0(ESEUR_dir, "projects/requirements/all_F1-8.csv.xz"), as.is=TRUE)

evol_reqs=read.csv(paste0(ESEUR_dir, "projects/requirements/evol-reqs.csv.xz"), as.is=TRUE)

plot_feature=function(X)
{
frac_changes=perc_changes[ , X]/100
lines(cumsum(frac_changes*req_changes$changes), col=pal_col[X])
}


pal_col=rainbow(ncol(perc_changes))

max_changes=max(colSums(perc_changes*req_changes$changes/100))

plot(0, type="n",
	xlim=c(1, nrow(req_changes)), ylim=c(1, max_changes),
	xlab="Releases", ylab="Cumulative requirement changes\n")

dummy=sapply(1:ncol(perc_changes), plot_feature)


total_changes=colSums(perc_changes*req_changes$changes/100)

req_normalise=total_changes[1]/evol_reqs$total_reqs[1]

evol_reqs$actual_reqs=evol_reqs$total_reqs*req_normalise

plot(evol_reqs$actual_reqs, evol_reqs$cum_changes, col=point_col,
	xlab="Actual requests", ylab="Actual changes")

