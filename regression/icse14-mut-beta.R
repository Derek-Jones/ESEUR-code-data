#
# icse14-mut-beta.R,  9 Jul 16
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


plot_layout(2, 2)

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
plot(x_measure, y_measure, type="n",
	xlab=x_str, ylab=paste0(y_str, "\n"))

pal_col=rainbow(1+max_loc)
symbols(x_measure, y_measure, circles=log_loc,
		inches=1/15, add=T, fg=pal_col[log_loc+1])
legend(legend_pos,
	c(expression(LOC %~~% 10^1), expression(LOC %~~% 10^3), expression(LOC %~~% 10^5)),
	pch=21, bty='n',
	pt.cex=c(0.5, 1.0, 1.7),
	col=c(pal_col[1+2], pal_col[1+6], pal_col[1+max_loc]))

cov_mod=betareg(y_measure ~ I(x_measure^0.5))
pred=predict(cov_mod, newdata=data.frame(x_measure=x_vals))
lines(x_vals, pred, col=line_col[1])

cov_gmod=glm(y_measure ~ I(x_measure^0.5))
g_pred=predict(cov_gmod, newdata=data.frame(x_measure=x_vals))
lines(x_vals, g_pred, col=line_col[2])


# lines(loess.smooth(x_measure, y_measure, span=0.3), col="black")

return(cov_mod)
}


line_col=rainbow(2)
x_vals=seq(0, 1, by=0.01)

# mut_coverage(cov_info$line_cov, cov_info$mut_cov,
# 	"Statement coverage", "Percentage mutants killed", "bottomright")

mod=mut_coverage(cov_info$path_cov, cov_info$mut_cov,
	"Path coverage", "Percentage mutants killed", "bottomright")
# summary(mod)

# clean_cov=subset(cov_info, (path_cov > 0) & (mut_cov > 0) & (mut_cov < 1) & !(is.na(path_cov) | is.na(mut_cov)))
# cov_nls_mod=nls(mut_cov ~ a+b*path_cov^c, data=clean_cov,
#  			start=list(a=0, b=1, c=0.5))
# cov_bmod=betareg(mut_cov ~ I(line_cov^0.5), data=clean_cov)
# pred=predict(cov_nls_mod, newdata=data.frame(path_cov=x_vals))
# lines(x_vals, pred, col="green")


# mut_coverage(cov_info$line_cov, cov_info$path_cov,
# 		"Statement coverage", "Path coverage", "topleft")
# mut_coverage(cov_info$line_cov, cov_info$block_cov,
# 		"Statement coverage", "Block coverage", "topleft")
# mut_coverage(cov_info$line_cov, cov_info$branch_cov,
# 		"Statement coverage", "Branch coverage", "topleft")

# plot(cov_info$loc, cov_info$line_cov, log="x",
# 	xlab="Lines of code", ylab="Statement coverage")

# cov_mod=glm(log_loc ~ line_cov, data=cov_info)

