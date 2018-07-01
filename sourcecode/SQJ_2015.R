#
# SQJ_2015.R, 27 Jun 18
# Data from:
# Coherence of Comments and Method Implementations: a Dataset and an Empirical Investigation
# Anna Corazza and Valerio Maggio and Giuseppe Scanniello
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG comment consistency source-code Java


source("ESEUR_config.r")


coh=read.csv(paste0(ESEUR_dir, "sourcecode/SQJ_2015.csv.xz"), as.is=TRUE)

coh$line_len=coh$end_line-coh$start_line+1
coh$coh_status=(coh$status == "COHERENT")

c_mod=glm(coh_status ~ log(comment_lines)+log(line_len), data=coh, family=binomial)
summary(c_mod)


