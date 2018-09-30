#
# 74-267-1-PB.R, 20 Sep 18
# Data from:
# Exploratory comparison of expert and novice pair programmers
# Andreas H{\"o}fer
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG pair-programming student professional


source("ESEUR_config.r")


pal_col=rainbow(3)


devs=read.csv(paste0(ESEUR_dir, "developers/74-267-1-PB.csv.xz"), as.is=TRUE)

devs$drive_time=strtoi(substr(devs$mean_driving_time, 1, 2))*60+
			strtoi(substr(devs$mean_driving_time, 4, 5))

orig_devs=devs
test_change_out=devs[7,] # An outlier for another variable
devs=devs[-7,] # An outlier for another variable

# devs=devs[-3,] # An outlier for one variable
# plot(devs[,c(2:9, 13)])
# cor(devs[,c(2:9, 13)], method="spearman")

plot(devs$test_changes, devs$pair == "E", col=pal_col[1],
	yaxt="n",
	xlim=range(orig_devs$test_changes),
	xlab="Test code changed LOC", ylab="")
axis(side=2, at=c(0, 1), label=c("Student", "Professional"))

points(test_change_out$test_changes, test_change_out$pair == "E", col="grey")

xbounds=1:300

dev_mod=glm(pair=="E" ~ 
			#log(impl_time)
			#+line_cov
			#+method_cov
			test_changes
			#+app_code_changes
			#+log(accept_tests)
			#+acceptance_passed
			#+log(drive_time)
			, data=devs)
# summary(dev_mod)

dev_pred=predict(dev_mod, type="response", newdata=data.frame(test_changes=xbounds))

lines(xbounds, dev_pred, col=pal_col[2])


dev_mod=glm(pair=="E" ~ 
			#log(impl_time)
			#+line_cov
			#+method_cov
			test_changes
			#+app_code_changes
			#+log(accept_tests)
			#+acceptance_passed
			#+log(drive_time)
			, data=devs, family=binomial)
# summary(dev_mod)

dev_pred=predict(dev_mod, type="response", newdata=data.frame(test_changes=xbounds))

lines(xbounds, dev_pred, col=pal_col[3])


