#
# debnath.R, 25 Jun 20
# Data from:
# Exploiting the Impact of Database System Configuration Parameters: {A} Design of Experiments Approach
# Biplob K. Debnath and Mohamed F. Mokbel and David J. Lilja
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_design


source("ESEUR_config.r")


library("FrF2")


deb=read.csv(paste0(ESEUR_dir, "experiment/debnath.csv.xz"), as.is=TRUE)

# The Packett-Burman design used is:
t=pb(8, 7, randomize=FALSE)
deb_des=fold.design(t)

deb_resp=add.response(deb_des, deb$Q1)

# DanielPlot(deb_resp) # Does not handle foldover

deb_lm=lm(Q1 ~ P1+P2+P3+P4+P5+P6+P7, data=deb)

# No way of modifying the y-axis label
DanielPlot(deb_lm, half=TRUE, autolab=FALSE, col="red", pch=4,
		main="")

# The actual calculation
# pb_calc=apply(deb[, 1:7], MARGIN=2, function(X) sum(X*deb$Q1))

