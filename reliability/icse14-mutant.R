#
# icse14-mutant.R, 21 Feb 18
#
# Data from:
# Code Coverage for Suite Evaluation by Developers
# Rahul Gopinath and Carlos Jensen and Alex Groce
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

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

# Adjust range so values are just inside (0,1), for beta regression to work
cov_info$line_cov=(cov_info$line_cov+1e-6)*0.999999
cov_info$mut_cov=(cov_info$mut_cov+1e-6)*0.999999
cov_info$path_cov=(cov_info$path_cov+1e-6)*0.999999
cov_info$branch_cov=(cov_info$branch_cov+1e-6)*0.999999

max_loc=max(cov_info$log_loc)


mut_coverage=function(x_measure, y_measure, x_str, y_str, legend_pos)
{
applic=(y_measure > 0) & !(is.na(x_measure) | is.na(y_measure))
x_measure=x_measure[applic]
y_measure=y_measure[applic]
log_loc=subset(cov_info, applic)$log_loc
plot(x_measure, y_measure, type="n",
	xlab=x_str, ylab=paste0(y_str, "\n"))

pal_col=rainbow(1+max_loc)
symbols(x_measure, y_measure, circles=log_loc,
		inches=1/15, add=T, fg=pal_col[log_loc+1])
# lines(loess.smooth(x_measure, y_measure, span=0.3), col="black")

mc_mod=betareg(y_measure ~ (x_measure+log_loc)^2)
# summary(mc_mod)

pred=predict(mc_mod, newdata=data.frame(x_measure=x_bounds, log_loc=log(10^2)))
lines(x_bounds, pred, col=pal_col[1+4])
pred=predict(mc_mod, newdata=data.frame(x_measure=x_bounds, log_loc=log(10^3)))
lines(x_bounds, pred, col=pal_col[1+6])
pred=predict(mc_mod, newdata=data.frame(x_measure=x_bounds, log_loc=log(10^4)))
lines(x_bounds, pred, col=pal_col[1+8])

legend(legend_pos,
	c(expression(LOC %~~% 10^2), expression(LOC %~~% 10^3), expression(LOC %~~% 10^4)),
	pch=21, bty='n',
	pt.cex=c(0.5, 1.0, 1.7),
	col=c(pal_col[1+4], pal_col[1+6], pal_col[1+8]))

return(mc_mod)
}

x_bounds=seq(0.01, 0.99, by=0.01)

lm_mod=mut_coverage(cov_info$line_cov, cov_info$mut_cov,
	"Statement coverage", "Percentage mutants killed", "bottomright")
# mut_coverage(cov_info$block_cov, cov_info$mut_cov,
# 	"Block coverage", "Percentage mutants killed", "bottomright")
# mut_coverage(cov_info$branch_cov, cov_info$mut_cov,
# 	"Branch coverage", "Percentage mutants killed", "bottomright")
# mut_coverage(cov_info$path_cov, cov_info$mut_cov,
# 	"Path coverage", "Percentage mutants killed", "bottomright")

lines(c(0.1, 1), c(0.1, 1), col="grey")


