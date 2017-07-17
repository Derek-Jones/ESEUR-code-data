#
# build.csv, 25 Jul 16
#
# Data from:
# An empirical study of build maintenance effort
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


file_cnt=read.csv(paste0(ESEUR_dir, "ecosystems/misc/build.csv.xz"), as.is=TRUE)

sep_files=data.frame(build=subset(file_cnt, kind=="build.txt")$files,
		source=subset(file_cnt, kind=="source.txt")$files,
		test=subset(file_cnt, kind=="test.txt")$files)

plot(sep_files, log="xy")

plot(sep_files$source, sep_files$build, log="xy")

file_mod=glm(build ~ log(source), data=sep_files, family=poisson)

x_values=seq(1, 50000, by=20)
file_pred=predict(file_mod, newdata=data.frame(source=x_values),
			type="response")
lines(x_values, file_pred)


file_mod=glm(log(build) ~ log(source), data=sep_files)
summary(file_mod)

library("robustbase")
file_rmod=glmrob(log(build) ~ log(source), data=sep_files, family=gaussian)
summary(file_rmod)


library("MASS")
file_rlm=rlm(log(build) ~ log(source), data=sep_files)
summary(file_rlm)


