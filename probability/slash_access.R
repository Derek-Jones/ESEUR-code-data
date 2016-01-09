#
# slash_access.R, 20 Jul 15
#
# Data from:
# Homogeneous temporal activity patterns in a large online communication space
# Andreas Kaltenbrunner and Vicen\c{c} G\'{o}mez and Ayman Moghnieh and Rodrigo Meza and Josep Blat and Vicente L\'{o}pez
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


slash = read.csv(paste0(ESEUR_dir, "probability/0708.1579v1.fig6.csv.xz"), as.is=TRUE)


# work_tab=table(log(slash$users))
work_den=density(log(slash$users), adjust=0.5)

# plot(work_tab, type="l",
# 	xlab="Minutes", ylab="Number of accesses")

plot(work_den, type="l",
	xlab="log(Minutes)", main="")


