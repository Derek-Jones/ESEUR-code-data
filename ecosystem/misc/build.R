#
# build.csv, 26 May 14
#
# Data from:
# An empirical study of build maintenance effort
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


file_cnt=read.csv(paste0(ESEUR_dir, "ecosystem/misc/build.csv.xz"), as.is=TRUE)

build_files=subset(file_cnt, kind=="build.txt.xz")
source_files=subset(file_cnt, kind=="source.txt.xz")
test_files=subset(file_cnt, kind=="test.txt.xz")

plot(source_files$files, build_files$files)

file_mod=glm(test_files$files ~ build_files$files + source_files$files)

file_pred=predict(file_mod)
lines(source_files$files, file_pred)

