#
# viability.R, 27 Dec 19
#
# Data from:
# Joseph David Lucente
# On the Viability of Quantitative Assessment Methods in Software Engineering and Software Services
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault-reports_installs


source("ESEUR_config.r")


pal_col=rainbow(2)

viability=read.csv(paste0(ESEUR_dir, "faults/viability.csv.xz"), as.is=TRUE)

plot(viability$installs, viability$incidents, log="xy", col=pal_col[2],
	xlab="Installs", ylab="Incidents\n")

x_bounds=exp(seq(log(1), log(1e6), by=0.1))

# viab_mod=glm(incidents ~ installs, data=viability)
# summary(viab_mod)
# 
viab_lmod=glm(log(incidents) ~ log(installs), data=viability)
# summary(viab_lmod)

pred=predict(viab_lmod, newdata=data.frame(installs=x_bounds))
lines(x_bounds, exp(pred), col=pal_col[1])

# loess_mod=loess(log(incidents) ~ log(installs), span=0.3, data=viability)
# loess_pred=predict(loess_mod, newdata=data.frame(installs=x_bounds))
# lines(x_bounds, exp(loess_pred), col=loess_col)

