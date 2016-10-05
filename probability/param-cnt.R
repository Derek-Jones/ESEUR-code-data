#
# param-cnt.R, 27 Sep 16
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("gamlss")
library("plyr")

# source,params,count,percent
params=read.csv(paste0(ESEUR_dir, "probability/param-cnt.csv"), as.is=TRUE)

pal_col=rainbow(length(unique(params$source)))
params$pal_col=pal_col[as.factor(params$source)]

plot(params$params, params$percent, type="n",
	xlim=c(0, 10),
	xlab="Number of parameters", ylab="Function definitions (percentage)")

d_ply(params, .(source), function(df) 
				lines(df$params, df$percent, col=df$pal_col[1]))

legend(x="topright", legend=unique(params$source), bty="n", fill=unique(params$pal_col), cex=1.2)


# cbook=subset(params, source == "cbook")
# cbook$int_p=round(cbook$percent)
# cb_cp=rep(0:(nrow(cbook)-1), cbook$int_p)
# mean(cb_cp)
# sd(cb_cp)


# embed=subset(params, source == "Embedded")
# embed$int_p=round(embed$percent)
# embed_pc=rep(0:(nrow(embed)-1), embed$int_p)

# beta_embed=embed_pc/(1+max(embed_pc))
# zp_mod=gamlss(beta_embed ~ 1, family=BEZI)

# fitted(zp_mod, "mu")[1]
# fitted(zp_mod, "sigma")[1]
# fitted(zp_mod, "nu")[1]


# plot(dpois(1:20, 5), log="xy")

