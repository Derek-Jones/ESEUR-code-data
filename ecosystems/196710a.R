#
# 196710.R, 16 Sep 17
# Data from:
# Computer Time Sharing: {Its} Origins and Development
# T. James Glauthier
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


multi=read.csv(paste0(ESEUR_dir, "ecosystems/196710a.csv.xz"), as.is=TRUE)

plot(1900+multi$Year, multi$Systems, type="b", log="y", col=point_col,
	xlab="Date", ylab="Time-sharing systems")

# sys_mod=glm(Systems ~ Year, data=multi, family=poisson)
# 
# pred=predict(sys_mod, type="response")
# 
# lines(1900+multi$Year, pred)

