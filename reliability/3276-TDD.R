#
# 3276-TDD.R, 12 Nov 15
#
# Data from:
# Effects of Negative Testing on {TDD}: {An} Industrial Experiment
# Adnan Causevic and Rakesh Shukla and Sasikumar Punnekkat and Daniel Sundmark
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


TDD=read.csv(paste0(ESEUR_dir, "reliability/3276-data.csv.xz"), as.is=TRUE, sep=";")

pal_col=rainbow(3)

TDD$neg_ratio=TDD$NumberOfNegTests/TDD$NumberOfTests


boxplot(neg_ratio ~ Group, data=TDD)

nt_mod=glm(NumberOfNegTests ~ NumberOfPosTests+Group, data=TDD)

td=subset(TDD, Group == "TDD")
tl=subset(TDD, Group == "TL")

plot(td$NumberOfNegTests , td$NumberOfPosTests, col="red")
points(tl$NumberOfNegTests , tl$NumberOfPosTests, col="green")


