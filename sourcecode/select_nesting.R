#
# select_nesting.R, 24 Apr 18
# Data from:
# The New C Standard
# Derek M. Jones
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG C statement selection nesting source-code


source("ESEUR_config.r")


pal_col=rainbow(2)


sn=read.csv(paste0(ESEUR_dir, "sourcecode/select_nesting.csv.xz"), as.is=TRUE)

plot(sn$nesting, sn$occurrences, log="y", col=point_col,
	xlim=c(0, 25),
	xlab="Nesting level", ylab="Selection-statements\n")

mod_17=glm(log(occurrences) ~ nesting, data=sn, subset=2:8)
pred=predict(mod_17)

lines(1:7, exp(pred), col=pal_col[2])

mod_813=glm(log(occurrences) ~ nesting, data=sn, subset=8:13)
pred=predict(mod_813)

lines(7:12, exp(pred), col=pal_col[2])

mod_113=glm(log(occurrences) ~ nesting, data=sn, subset=2:13)
pred=predict(mod_113)

lines(1:12, exp(pred), col=pal_col[1])

# Embedded from Engblom  <book Engblom_98>
# 1 0.495
# 2 0.196
# 3 0.095
# 4 0.067
# 5 0.065
# 6 0.063
# 7 0.019
# 8 0.014
# 9 0.007
# 10 0.008

