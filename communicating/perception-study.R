#
# perception-study.R,  3 Mar 20
# Data from:
# A Psychophysical Investigation of Size as a Physical Variable
# Yvonne Jansen and Kasper Hornb{\ae}k
# Alternative analysis at: http://yvonnejansen.me/size/scripts
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment_human estimate_visual

source("ESEUR_config.r")


library("betareg")
library("plyr")


plot_layout(2, 1)

pal_col=rainbow(10) # 10 subjects


fit_participant=function(df)
{
# Model fitted in the paper.
# s_mod=nls(est_frac ~ size_frac^a, data=df,
# 			start=list(a=1))

p_mod=betareg(est_frac ~ size_frac, data=df)
# summary(p_mod)

x_bounds=5:90
pred=predict(p_mod, newdata=data.frame(size_frac=x_bounds/100))
lines(x_bounds, 100*pred, col=pal_col[df$participant[1]])
}

fit_combo=function(combo, obj_str)
{
plot(combo$size_ratio, combo$estimate, col=pal_col[combo$participant],
	xaxs="i", yaxs="i",
	xlim=c(0, 100), ylim=c(0, 100),
	xlab="Actual size ratio", ylab="Estimated size ratio\n")
lines(c(0, 100), c(0, 100), col="grey")

# sr_mod=nls(est_frac ~ size_frac^a, data=combo,
# 			start=list(a=1))
# 
# sr_mod=betareg(est_frac ~ size_frac, data=combo)
# summary(sr_mod)

text(20, 95, obj_str, cex=1.5)
d_ply(combo, .(participant), fit_participant)
}



per=read.csv(paste0(ESEUR_dir, "communicating/perception-study.csv.xz"), as.is=TRUE)

per$estimate=estimate=ifelse(per$method == "ratioPercentage", 
                per$estimateRatio.Percentage,
                100*(100-per$estimateConstant.Sum)/per$estimateConstant.Sum)
per$est_frac=per$estimate/100
per$size_frac=per$size1/per$size2
per$size_ratio=100*per$size_frac

# Remove 'impossible' values
per=subset(per, (estimateRatio.Percentage > 0) & (estimateRatio.Percentage < 100))

bar_csum=subset(per, (condition == "bar-slider") & (method == "constantSum"))
bar_rper=subset(per, (condition == "bar-number") & (method == "ratioPercentage"))
sph_csum=subset(per, (condition == "sphere-slider") & (method == "constantSum"))
sph_rper=subset(per, (condition == "sphere-number") & (method == "ratioPercentage"))


# fit_combo(bar_csum, "Bars")
fit_combo(bar_rper, "Bars")

# fit_combo(sph_csum, "Spheres")
fit_combo(sph_rper, "Spheres")


