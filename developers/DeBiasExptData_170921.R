#
# DeBiasExptData_170921.R 30 Sep 17
# Data from:
# An Experimental Evaluation of a De-biasing Intervention for Professional Software Developers
# Martin Shepperd and Carolyn Mair and Magne J{\o}rgensen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human cognitive_anchoring

source("ESEUR_config.r")


DeB=read.csv(paste0(ESEUR_dir, "developers/DeBiasExptData_170921.csv.xz"), as.is=TRUE)

E_mod=glm(EstProd ~ (Workshop+Anchor)^2
			# +Workshop:Anchor:Block
			# +Block
			, data=DeB)

summary(E_mod)


