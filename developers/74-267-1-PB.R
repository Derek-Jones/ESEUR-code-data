#
# 74-267-1-PB.R, 16 Oct 16
# Data from:
# Andreas H{\"o}fer
# Exploratory comparison of expert and novice pair programmers
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


devs=read.csv(paste0(ESEUR_dir, "developers/74-267-1-PB.csv.xz"), as.is=TRUE)

devs$drive_time=strtoi(substr(devs$mean_driving_time, 1, 2))*60+
			strtoi(substr(devs$mean_driving_time, 4, 5))

orig_devs=devs
test_change_out=devs[7,] # An outlier for another variable
devs=devs[-7,] # An outlier for another variable

# devs=devs[-3,] # An outlier for one variable
plot(devs[,c(2:9, 13)])
cor(devs[,c(2:9, 13)], method="spearman")

plot(devs$test_changes, devs$pair == "E", col=point_col,
	xlim=range(orig_devs$test_changes),
	xlab="Test changes", ylab="Pair")
points(test_change_out$test_changes, test_change_out$pair == "E", col="green")



dev_mod=glm(pair=="E" ~ 
			#log(impl_time)
			#+line_cov
			#+method_cov
			log(test_changes)
			#+app_code_changes
			#+log(accept_tests)
			#+acceptance_passed
			#+log(drive_time)
			, data=orig_devs, family=binomial)
summary(dev_mod)

xbounds=1:300
dev_pred=predict(dev_mod, type="response", newdata=data.frame(test_changes=xbounds))

lines(xbounds, dev_pred, col=pal_col[1])


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
summary(dev_mod)

xbounds=1:300
dev_pred=predict(dev_mod, type="response", newdata=data.frame(test_changes=xbounds))

lines(xbounds, dev_pred, col=pal_col[2])



