#
# pani-depth.R, 13 Jan 19
# Data from:
# Loop Patterns in C Programs
# Thomas Pani
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG loop basic-block_depth source-code_loop C_loop


source("ESEUR_config.r")


plot_layout(2, 1)
pal_col=rainbow(2)

depth=read.csv(paste0(ESEUR_dir, "sourcecode/pani-depth.csv.xz"), as.is=TRUE)

depth=subset(depth, (num > 0) & (bound > 0))

cbench=subset(depth, project == "cBench")
CU=subset(depth, project == "coreutils")

# plot(cbench$num, cbench$bound, log="y", col=pal_col[1],
# 	xlim=c(0, 30),
# 	xlab="Max nesting", ylab="Loops")


fit_expo=function(df)
{
plot(df$num, df$bound, log="y", col=pal_col[2],
        xlab="Basic block depth", ylab="Loops\n")

# Fit nesting to depth 10, assuming that after that screen width has an impact
cb_mod=glm(log(bound) ~ num, data=df, subset=(num > 2))
summary(cb_mod)

pred=predict(cb_mod)
lines(df$num[3:25], exp(pred), col=pal_col[1])

return(cb_mod)
}


cb_mod=fit_expo(cbench[1:25, ])
# CU_mod=fit_expo(CU[1:20, ])


fit_power=function(df)
{
plot(df$num, df$bound, log="xy", col=pal_col[2],
        xlab="Basic block depth", ylab="Loops\n")

# Fit nesting to depth 10, assuming that after that screen width has an impact
cb_mod=glm(log(bound) ~ log(num), data=df, subset=(num < 11))
summary(cb_mod)

pred=predict(cb_mod)
lines(df$num[1:10], exp(pred), col=pal_col[1])

return(cb_mod)
}


cb_mod=fit_power(cbench[1:25, ])
# CU_mod=fit_power(CU[1:20, ])


