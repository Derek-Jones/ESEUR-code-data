#
# 20132511-Experiment1.R, 16 Apr 19
# Data from:
# Sociality influences cultural complexity
# Michael Muthukrishna and Ben W. Shulman and Vlad Vasilescu and Joseph Henrich
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human learning

source("ESEUR_config.r")


pal_col=rainbow(2)


ex1=read.csv(paste0(ESEUR_dir, "economics/20132511-Experiment1.csv.xz"), as.is=TRUE)

gc1=subset(ex1, GroupCondition == 0)
gc5=subset(ex1, GroupCondition == 1)

plot(gc1$Generation, gc1$Rating, col=pal_col[1],
	xlab="Generation", ylab="Rating\n")
points(gc5$Generation, gc5$Rating, col=pal_col[2])

# ex_mod=glm(Rating ~ (Generation+GroupCondition)^2, data=ex1)
ex_mod=glm(Rating ~ Generation:GroupCondition+GroupCondition, data=ex1)
summary(ex_mod)

pred=predict(ex_mod, data.frame(Generation=1:10, GroupCondition=0))
lines(1:10, pred, col=pal_col[1])

pred=predict(ex_mod, data.frame(Generation=1:10, GroupCondition=1))
lines(1:10, pred, col=pal_col[2])


