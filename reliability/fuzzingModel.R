#
# fuzzingModel, 22 Feb 18
# Data from:
# Empirical Analysis and Modeling of Black-Box Mutational Fuzzing
# Mingyi Zhao and Peng Liu
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault_count bi-exponential


source("ESEUR_config.r")


library("gnm")


# plot_layout(3, 2)
plot_layout(2, 1)

pal_col=rainbow(3)


bi_exp_fit=function(vec, in1, sl1, in2, sl2, prog_str)
{
prog=subset(data.frame(count=vec, ind=1:length(vec)), !is.na(count))


plot(prog$count, log="y", col=point_col,
        xlab="Fault", ylab="Occurrences\n")

text(nrow(prog)/2, max(prog$count)/1.5, prog_str, cex=1.2)

fail_mod=gnm(count ~ instances(Mult(1, Exp(ind)), 2)-1,
                data=prog, verbose=FALSE, trace=FALSE,
                start=c(in1, sl1, in2, sl2),
                family=poisson(link="identity"))
summary(fail_mod)

exp_coef=as.numeric(coef(fail_mod))

t=predict(fail_mod)
lines(t, col=pal_col[2])

lines(exp_coef[1]*exp(exp_coef[2]*prog$ind), col=pal_col[1])
lines(exp_coef[3]*exp(exp_coef[4]*prog$ind), col=pal_col[3])

return(fail_mod)
}


fuz=read.csv(paste0(ESEUR_dir, "reliability/fuzzingModel.csv.xz"), as.is=TRUE)

# xpdf=bi_exp_fit(fuz$xpdf, 100, -0.6, 30, -0.1, "xpdf")
# mupdf=bi_exp_fit(fuz$mupdf, 85, -0.5, 5, -0.02, "mupdf")
convert=bi_exp_fit(fuz$convert, 3000, -0.1, 500, -0.1, "convert")
# ffmpeg=bi_exp_fit(fuz$ffmpeg, 2000, -0.5, 100, -0.08, "ffmpeg")
autotrace=bi_exp_fit(fuz$autotrace, 1000, -0.4, 25, -0.09, "autotrace")
# jpegtran=bi_exp_fit(fuz$jpegtran, 40, -0.2, 2, -0.07, "jpegtran")

legend(x="bottomright", legend=c("Amdahl", "Quadratic", "Queueing"), bty="n", fill=pal_col, cex=1.2)

# prog=subset(data.frame(count=fuz$mupdf, ind=1:length(fuz$mupdf)), !is.na(count))
# 
# 
# plot(prog$count, log="y", col=point_col,
#         xlab="Fault id", ylab="Failing programs\n")
# 
# 
# fail_mod=gnm(count ~ instances(Mult(1, Exp(ind)), 2)-1,
#                 data=prog, trace=TRUE, verbose=TRUE,
#                 start=c(60, -0.5, 20, -0.1),
#                 family=poisson(link="identity"))
# summary(fail_mod)
# 
