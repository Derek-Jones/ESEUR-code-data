#
# param-cnt.R, 14 Apr 20
#
# Data from:
# Why {SpecInt95} Should Not Be Used to Benchmark Embedded Systems Tools
# Jakob Engblom
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG embedded-system_source-code SPEC benchmark_embedded-system function_parameter


source("ESEUR_config.r")


library("plyr")

# source,params,count,percent
params=read.csv(paste0(ESEUR_dir, "ecosystems/param-cnt.csv.xz"), as.is=TRUE)

# pal_col=rainbow(length(unique(params$source)))
# params$pal_col=pal_col[as.factor(params$source)]
# 
# plot(params$params, params$percent, type="n",
# 	xlim=c(0, 10),
# 	xlab="Number of parameters", ylab="Function definitions (percentage)\n")
# 
# d_ply(params, .(source), function(df) 
# 				lines(df$params, df$percent, col=df$pal_col[1]))

pal_col=rainbow(3)

cbook=subset(params, source == "cbook")
cbook$int_p=round(cbook$percent)
cb_cp=rep(0:(nrow(cbook)-1), cbook$int_p)
# mean(cb_cp)
# sd(cb_cp)


embed=subset(params, source == "Embedded")
embed$int_p=round(embed$percent)
embed_pc=rep(0:(nrow(embed)-1), embed$int_p)

plot(params$params, params$percent, type="n",
	xaxs="i", yaxs="i",
	xlim=c(-0.05, 10),
	xlab="Number of parameters", ylab="Function definitions (percentage)\n")
lines(embed$params, embed$percent, col=pal_col[2])
lines(cbook$params, cbook$percent, col=pal_col[2])
embed_pois=glm(embed_pc ~ 1, family=poisson(link="identity"))
points(0:8, dpois(0:8, coef(embed_pois)[1])*100, col=pal_col[1])
cbook_pois=glm(cb_cp ~ 1, family=poisson(link="identity"))
points(0:8, dpois(0:8, coef(cbook_pois)[1])*100, col=pal_col[3])

legend(x="topright", legend=c("C book", "Fitted model", "Embedded"), bty="n", fill=pal_col, cex=1.2)


# library("gamlss")

# zp_mod=gamlss(embed_pc ~ 1, family=ZIP)  # ZIP2 supports dispersion

# fitted(zp_mod, "mu")[1]
# fitted(zp_mod, "sigma")[1]
# fitted(zp_mod, "nu")[1]


# plot(dpois(1:20, 5), log="xy")

