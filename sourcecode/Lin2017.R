#
# Lin2017.R, 11 Jan 20
# Data from:
# On the Uniqueness of Code Redundancies
# Bi Lin and Luca Ponzanelli and Andrea Mocci and Gabriele Bavota and Michele Lanza
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Java token-sequence_clone

source("ESEUR_config.r")


library("vioplot")


Lin=read.csv(paste0(ESEUR_dir, "sourcecode/Lin2017.csv.xz"), as.is=TRUE)

Lin$noab_project_dup_rate=Lin$noab_project_dup_no/Lin$noab_project_total_no
Lin$lex_project_dup_rate=Lin$lex_project_dup_no/Lin$lex_project_total_no

# nop_mod=glm(noab_project_dup_rate ~ I(granularity^-0.0064), data=Lin)
# nop_mod=glm(noab_project_dup_rate ~ I(granularity^-0.04), data=Lin)
# summary(nop_mod)
# 
nop_mod=nls(noab_project_dup_rate ~ a+b*granularity^c, data=Lin, # trace=TRUE,
		start=list(a=0.8, b=-0.4, c=-0.1))
# #		start=list(a=0.0, b=0.8, c=-0.1))
# summary(nop_mod)
pred=predict(nop_mod, newdata=data.frame(granularity=seq(3, 60, by =3)))


pal_col=rainbow(length(unique(Lin$granularity)))

vioplot(noab_project_dup_rate ~ granularity, data=Lin,
        col=pal_col, border=pal_col,
	yaxs="i",
	ylim=c(0, 1),
	xlab="Sequence length", ylab="Sequence duplicated (fraction)\n")

lines(1:20, pred, col="yellow")

# When all identifiers are treated as the same token
# vioplot(lex_project_dup_rate ~ granularity, data=Lin,
#       col=pal_col, border=pal_col,
# 	yaxs="i",
# 	ylim=c(0, 1),
# 	xlab="Sequence length", ylab="Sequence duplicated (fraction)\n")


