#
# debnath.R, 23 Nov 17
# Data from:
# Exploiting the Impact of Database System Configuration Parameters: {A} Design of Experiments Approach
# Biplob K. Debnath and Mohamed F. Mokbel and David J. Lilja
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


deb=read.csv(paste0(ESEUR_dir, "experiment/debnath.csv.xz"), as.is=TRUE)

# The Packett-Burman design used is:
t=pb(8, 7, randomize=FALSE)
deb_des=fold.design(t)

deb_resp=add.response(deb_des, deb$Q1)

# DanielPlot(deb_resp) # Does not handle foldover

deb_lm=lm(Q1 ~ P1+P2+P3+P4+P5+P6+P7, data=deb)

DanielPlot(deb_lm, half=TRUE, autolab=FALSE, col="red", pch=4,
		main="")

# The actual calculation
# pb_calc=apply(deb[, 1:7], MARGIN=2, function(X) sum(X*deb$Q1))

