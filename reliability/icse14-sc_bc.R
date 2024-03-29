#
# icse14-sc_bc.R, 25 Jun 20
# Data from:
# Code Coverage for Suite Evaluation by Developers
# Rahul Gopinath and Carlos Jensen and Alex Groce
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG code_coverage branch-coverage statement_coverage

source("ESEUR_config.r")


library("betareg")


# plot_wide()

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

# Ignore entries with less than 20 (i.e., exp(3)) lines.
# It makes the plot look better.
pal_col=rainbow(max_loc-2)


mut_coverage=function(x_measure, y_measure, x_str, y_str, legend_pos)
{
applic=(y_measure >= 0) & !(is.na(x_measure) | is.na(y_measure))
x_measure=x_measure[applic]
y_measure=y_measure[applic]
log_loc=subset(cov_info, applic)$log_loc
plot(x_measure, y_measure, type="n",
	xlab=x_str, ylab=paste0(y_str, "\n"))

symbols(x_measure, y_measure, circles=log_loc,
		inches=1/15, add=T, fg=pal_col[log_loc-2])
# lines(loess.smooth(x_measure, y_measure, span=0.3), col="black")

mc_mod=betareg(y_measure ~ (x_measure+log_loc)^2)
# summary(mc_mod)

pred=predict(mc_mod, newdata=data.frame(x_measure=x_bounds, log_loc=log(10^2)))
lines(x_bounds, pred, col=pal_col[5-2])
pred=predict(mc_mod, newdata=data.frame(x_measure=x_bounds, log_loc=log(10^3)))
lines(x_bounds, pred, col=pal_col[7-2])
pred=predict(mc_mod, newdata=data.frame(x_measure=x_bounds, log_loc=log(10^4)))
lines(x_bounds, pred, col=pal_col[9-2])

legend(legend_pos,
	c(expression(LOC %~~% 10^2), expression(LOC %~~% 10^3), expression(LOC %~~% 10^4)),
	pch=21, bty='n',
	pt.cex=c(0.5, 1.0, 1.7),
	col=c(pal_col[5-2], pal_col[7-2], pal_col[9-2]),	
	cex=1.2)

return(mc_mod)
}

x_bounds=seq(0.01, 0.99, by=0.01)


# lp_mod=mut_coverage(cov_info$line_cov, cov_info$path_cov,
# 		"Statement coverage", "Path coverage", "topleft")
# mut_coverage(cov_info$line_cov, cov_info$block_cov,
# 		"Statement coverage", "Block coverage", "topleft")
lb_mod=mut_coverage(cov_info$line_cov, cov_info$branch_cov,
		"Statement coverage", "Branch coverage", "topleft")

lines(c(0, 1), c(0, 1), col="grey")

# plot(cov_info$log_loc, cov_info$line_cov,
# 	xlab="log(LOC)", ylab="Statement coverage")

# lines(loess.smooth(cov_info$log_loc, cov_info$line_cov, span=0.3), col="black")
# loc_mod=betareg(line_cov ~ log_loc, data=cov_info)
# summary(loc_mod)


