#
# icse14-beta-sum.R, 12 Jul 16
#
# Data from:
# Code Coverage for Suite Evaluation by Developers
# Rahul Gopinath and Carlos Jensen and Alex Groce
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG coverage testing mutants


source("ESEUR_config.r")

library("betareg")


load(paste0(ESEUR_dir, "reliability/o.db.rda"))


cov_info=subset(o.db, loc > 0)
cov_info$log_loc=log(cov_info$loc)
cov_info$line_cov=cov_info$cobertura.line.num/cov_info$cobertura.line.total
cov_info$branch_cov=cov_info$cobertura.branch.num/cov_info$cobertura.branch.total
cov_info$block_cov=cov_info$nemma.block.num/cov_info$nemma.block.total
cov_info$path_cov=cov_info$mockit.path.num/cov_info$mockit.path.total
cov_info$mut_cov=cov_info$pit.mutation.num/cov_info$pit.mutation.total

max_loc=max(cov_info$log_loc)


mut_coverage=function(x_measure, y_measure, x_str, y_str, legend_pos)
{
applic=(x_measure > 0) & (y_measure > 0) & (y_measure < 1) & !(is.na(x_measure) | is.na(y_measure))
x_measure=x_measure[applic]
y_measure=y_measure[applic]
# print(c(x_measure[135:145], y_measure[135:145]))
log_loc=subset(cov_info, applic)$log_loc

cov_mod=betareg(y_measure ~ I(x_measure^0.5))

return(cov_mod)
}


mod=mut_coverage(cov_info$path_cov, cov_info$mut_cov,
	"Path coverage", "Percentage mutants killed", "bottomright")

print(summary(mod))

