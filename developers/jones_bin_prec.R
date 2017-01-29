#
# jones_bin_prec.R, 27 Jan 17
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

# subj_num,first_op,second_op,prec_order,is_correct,years_exp
bin_prec=read.csv(paste0(ESEUR_dir, "developers/jones_bin_prec.csv.xz"), as.is=TRUE)

prec_mod=glm(is_correct ~ (first_op+second_op+prec_order+years_exp)^2,
			data=bin_prec, family=binomial)


plot(1)
text(1, 1.1, "TODO")

