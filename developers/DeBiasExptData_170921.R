#
# DeBiasExptData_170921.R 30 Sep 17
# Data from:
# An Experimental Evaluation of a De-biasing Intervention for Professional Software Developers
# Shepperd, M., Mair, C. and Jørgensen, M.
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


DeB=read.csv(paste0(ESEUR_dir, "developers/DeBiasExptData_170921.csv.xz"), as.is=TRUE)

E_mod=glm(EstProd ~ (Workshop+Anchor)^2
			# +Workshop:Anchor:Block
			# +Block
			, data=DeB)

summary(E_mod)


