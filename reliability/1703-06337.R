#
# 1703-06337.R,  2 Apr 18
# Data from:
# Mefta Sadat and Ayse Basar Bener and Andriy V. Miranskyy
# Rediscovery Datasets: Connecting Duplicate Reports

# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("gnm")
library("plyr")

# 
# 
# plot_dups=function(df)
# {
# t=count(count(df$root_id)$freq)
# if (nrow(t) < 15)
#    return()
# 
# lines(t$x, t$freq)
# }


# plot_layout(2, 1)

pal_col=rainbow(4)

kde=read.csv(paste0(ESEUR_dir, "reliability/kde.csv.xz"), as.is=TRUE)


dups=subset(kde, !is.na(root_id))

# plot(0.9, type="n", log="xy",
# 	xlim=c(1, 20), ylim=c(1, 400),
# 	xlab="Reports", ylab="Duplicates")
# 
# d_ply(t, .(product), plot_dups)
# 
# 

# Cannot get any convergence if the first count is included
dup_cnt=count(count(dups$root_id)$freq)

# plot(dup_cnt$freq, log="y", col=point_col,
#         xlab="Duplicates", ylab="Reports\n")
# 
# fail_mod=gnm(freq ~ instances(Mult(1, Exp(x)), 2)-1,
#                 data=dup_cnt[-1, ], verbose=TRUE, trace=TRUE,
#                 start=c(30000.0, -0.7, 300.0, -0.1),
#                 family=poisson(link="identity"))
# summary(fail_mod)
# 
# exp_coef=as.numeric(coef(fail_mod))
# 
# lines(exp_coef[1]*exp(exp_coef[2]*dup_cnt$x), col=pal_col[1])
# lines(exp_coef[3]*exp(exp_coef[4]*dup_cnt$x), col=pal_col[3])
# 
# t=predict(fail_mod)
# lines(t, col=pal_col[2])


plot(dup_cnt$freq, log="y", col=point_col,
        xlab="Fault report", ylab="Duplicates\n")

fail_mod=gnm(freq ~ instances(Mult(1, Exp(x)), 3)-1,
                data=dup_cnt[-1, ], verbose=FALSE, trace=FALSE,
                start=c(230000.0, -1.0, 2100.0, -0.3, 21, -0.03),
                family=poisson(link="identity"))
summary(fail_mod)

exp_coef=as.numeric(coef(fail_mod))

lines(exp_coef[1]*exp(exp_coef[2]*dup_cnt$x), col=pal_col[1])
lines(exp_coef[3]*exp(exp_coef[4]*dup_cnt$x), col=pal_col[3])
lines(exp_coef[5]*exp(exp_coef[6]*dup_cnt$x), col=pal_col[4])

t=predict(fail_mod)
lines(t, col=pal_col[2])

