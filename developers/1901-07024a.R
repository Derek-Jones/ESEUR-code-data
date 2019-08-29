#
# 1901-07024a.R, 10 Feb 19
# Data from:
# Temporal Discounting in Technical Debt: {How} do Software Practitioners Discount the Future?
# Christoph Becker and Fabian Fagerholm and Rahul Mohanani and Alexander Chatzigeorgiou
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human subjects time-discounting

source("ESEUR_config.r")


library("plyr")


fit_subj=function(df)
{
ft=t(subset(df, select=grepl("TF", colnames(df))))
ft=ft/ft[1] # Normalise

lines(years, ft, type="b", col=df$col_str)
}


company=read.csv(paste0(ESEUR_dir, "developers/1901-07024.csv.xz"), as.is=TRUE)

c1=subset(company, Company == "C1")
c2=subset(company, Company == "C2")

c1$col_str=rainbow(nrow(c1))

years=c(1, 2, 3, 4, 5, 10)

plot(0, type="n",
	xaxt="n",
	yaxs="i",
	# xlim=c(0, 10), ylim=range(c1$TF10),
	xlim=c(1, 10), ylim=c(0, 11),
	xlab="Years", ylab="Days (normalised)\n")

axis(1, at=years, label=years)

# 'clean' data by removing subjects who savings requirement decreases with time
c1_grow=subset(c1, TF1 < TF10)

d_ply(c1_grow, .(individual), fit_subj)


# Try and fit a hyperbolic model

# library("lme4")
# library("reshape2")
# 
# 
# plot_indiv=function(df, indiv)
# {
# sA=subset(df, individual == indiv)
# 
# plot(sA$years, sA$discount, type="b", log="y", col=point_col,
# 	xlab="Years", ylab="Discount\n")
# 
# text(8, max(sA$discount*0.9), indiv, cex=1.6)
# }
# 
# 
# c12=read.csv(paste0(ESEUR_dir, "developers/1901-07024.csv.xz"), as.is=TRUE)
# 
# c12l=melt(c12, id.vars=c("Company", "individual", "PV_1"),
# 		measure.vars=c("TF1", "TF2", "TF3", "TF4", "TF5", "TF10"))
# c12l$variable=as.character(c12l$variable) # handle factor nonsense
# 
# c12l$years=as.integer(mapvalues(c12l$variable, 
# 				c("TF1", "TF2", "TF3", "TF4", "TF5", "TF10"),
# 				c(1:5, 10)))
# c12l$discount=c12l$PV_1/c12l$value
# 
# 
# c1=subset(c12l, Company == "C1")
# c2=subset(c12l, Company == "C2")
# 
# plot_layout(2, 3)
# 
# plot_indiv(c1, "A")
# plot_indiv(c1, "B")
# plot_indiv(c1, "C")
# plot_indiv(c1, "E")
# plot_indiv(c1, "G")
# plot_indiv(c1, "M")
# 
# exp_mod=glm(log(discount) ~ individual*years, data=c1)
# summary(exp_mod)
# 
# hyp_mod=glm(discount ~ individual+I(1/(1+years)), data=c2)
# summary(hyp_mod)
# 
# # Not quiet as good as a model that includes individuals
# # dis_mod=nls(discount ~ a+1/(1+b*years), data=c1,
# # 		start=list(a=0.26, b=0.9), trace=TRUE)
# 
# 
# sdis_mod=lmer(discount ~ I(1/(1+years))+(years | individual), data=c1)
# summary(sdis_mod)

