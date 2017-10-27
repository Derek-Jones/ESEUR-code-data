#
# req-delay.R, 16 Sep 17
# Data from:
# Towards Exploring Factors Affecting Decision Outcome and Lead-time in Large-Scale Requirements Engineering
# Krzysztof Wnuk∗and Jaap Kabbedijk and Sjaak Brinkkemper and Björn Regnell
# emailed... waiting...
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


delay=read.csv(paste0(ESEUR_dir, "projects/req-delay.csv.xz"), as.is=TRUE)

# acf(delay$requirements)

d_frac=c(0, 0, 1/5, 2/5, 3/5, 4/5, 5/5)

days=rep(1:7, length.out=nrow(delay))

d1_shift=c(0, 0, 2, 2, 2, 2, 2)*rep(1:6, each=7)
d1_shift=d1_shift[1:nrow(delay)]
d2_shift=c(2, 2, 2, 2, 2, 0, 0)*rep(0:5, each=7)
d2_shift=d2_shift[1:nrow(delay)]

d1_correction=delay$requirements*d_frac[days]
d2_correction=delay$requirements*(1-d_frac[days])

work_reqs=rep(0, nrow(delay))
work_reqs[1:nrow(delay)-d1_shift]=work_reqs[1:nrow(delay)-d1_shift]+
							d1_correction
work_reqs[1:nrow(delay)-d2_shift]=work_reqs[1:nrow(delay)-d2_shift]+
							d2_correction

plot(delay$requirements, col="red", type="l")
lines(work_reqs, col="blue")

