#
# Taylor2012.R, 12 Apr 18
# Data from:
# Analysis and Characterization of Author Contribution Patterns in Open Source Software Development
# Quinn C. Taylor

# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(2)

af=read.csv(paste0(ESEUR_dir, "sourcecode/Taylor2012.csv.xz"), as.is=TRUE)

plot(af$authors, af$files, log="y", col=pal_col[1],
	xlab="Authors", ylab="Files")

af_mod=glm(log(files) ~ authors+I(authors^2), data=af)

summary(af_mod)

pred=predict(af_mod)
lines(af$authors, exp(pred), col=pal_col[2])

