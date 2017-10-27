#
# CSA-duration.R, 25 Oct 17
# Data from:
# The Effort Distribution of Software Development Phases
# Yong Wang and Jing Zhang
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


dur=read.csv(paste0(ESEUR_dir, "projects/CSA-duration.csv.xz"), as.is=TRUE)

dur$mean_K=dur$Effort_mean/1e3
dur$median_K=dur$Effort_median/1e3

plot(dur$Duration, dur$mean_K, col=pal_col[1],
	xlab="Duration (months)", ylab="Effort (mean thousand hours)\n")
points(dur$Duration, dur$median_K, col=pal_col[2])

m2_mod=glm(mean_K ~ I(Duration^2), data=dur)
summary(m2_mod)

# mexp_mod=glm(mean_K ~ exp(Duration), data=dur)
# summary(mexp_mod)

# mnl_mod=nls(mean_K ~ a*Duration^b, data=dur,
# 			start=list(a=20, b=2))
# summary(mnl_mod)


pred=predict(m2_mod)
lines(dur$Duration, pred, col=pal_col[1])

m2_mod=glm(median_K ~ I(Duration^2), data=dur)
summary(m2_mod)

# mexp_mod=glm(median_K ~ exp(Duration), data=dur)
# summary(mexp_mod)

pred=predict(m2_mod)
lines(dur$Duration, pred, col=pal_col[2])


# mnl_mod=nls(median_K ~ a*Duration^b, data=dur,
# 			start=list(a=20, b=2))
# summary(mnl_mod)

legend(x="topleft", legend=c("Mean", "Median"), bty="n", fill=pal_col, cex=1.2)

