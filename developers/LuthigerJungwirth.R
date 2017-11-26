#
# LuthigerJungwirth.R, 14 Nov 17
# Data from:
# Pervasive Fun
# Benno Luthiger and Carola Jungwirth
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("dplyr")
library("ordinal")

# See LuthigerJungwirth.txt for information on columns
fasd=read.csv(paste0(ESEUR_dir, "developers/LuthigerJungwirth.csv.xz"), as.is=TRUE)

fasd[fasd == -1]=NA

# Most columns are factors, so easier to special case those that are not
fasd=mutate_if(fasd, is.numeric, as.factor)

# fun_mod=clm(q42 ~ q1+q2+q3+q4+q5+q6+q7+q8+q9+
#                   q11+q12+q13+q14+q15+q16+q17+q18+q19+
#                   q21+q22+q23+q24+q25+q26+q27+q28+q29+
#                   q31+q32+q33+q34+q35,
# 			data=fasd)

fun_mod=clm(q42 ~                q6+   
                          q23+                    q29,
			data=fasd)
summary(fun_mod)


