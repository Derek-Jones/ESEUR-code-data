#
# x86_v4_9_filesym.R, 13 Jul 17
# Data from:
# Analyzing the Impact of Feature Changes in Linux∗
# Andreas Ziegler and Valentin Rothberg and Daniel Lohmann
# Paper uses v4.3
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)


filesym=read.csv(paste0(ESEUR_dir, "ecosystems/x86.v4.9.filesym.csv.xz"), as.is=TRUE)
filesym=subset(filesym, files.affected > 0)
total_features=sum(filesym$number.of.features.affecting.X.files)

dir_filesym=read.csv(paste0(ESEUR_dir, "ecosystems/x86.v4.9.direc.filesym.csv.xz"), as.is=TRUE)
dir_filesym=subset(dir_filesym, files.affected > 0)
total_dir_features=sum(dir_filesym$number.of.features.affecting.X.files)

plot(100*cumsum(filesym$number.of.features.affecting.X.files)/total_features, filesym$files.affected,
			type="l", log="y", col=pal_col[1],
	xlab="Options enabled (cumulative percentage)", ylab="Files\n")
lines(100*cumsum(dir_filesym$number.of.features.affecting.X.files)/total_dir_features, dir_filesym$files.affected,
	col=pal_col[2])

legend(x="topleft", legend=c("Nested #includes", "Direct"), bty="n", fill=pal_col, cex=1.2)

each_feature=rep(filesym$files.affected,
			times=filesym$number.of.features.affecting.X.files)
each_dir_feature=rep(dir_filesym$files.affected,
			times=dir_filesym$number.of.features.affecting.X.files)

mean(each_feature)
# [1] 3491.321
mean(each_dir_feature)
# [1] 293.205
sd(each_feature)
# [1] 6846.995
sd(each_dir_feature)
# [1] 1237.933
