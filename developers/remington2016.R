#
# remington2016.R, 28 Jan 17
# Data from:
# With Practice, Keyboard Shortcuts Become Faster Than Menu Selection: {A} Crossover Interaction
# Roger W. Remington and Ho Wang Holman Yuen and Harold Pashler
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("lme4")
# library("plyr")


add_seq_num=function(df)
{
t=df[order(df$TotalItems), ]
t$seq_num=1:nrow(t)

return(t)
}

# SubjectID Item# TotalItems Lag Response Time CatLag Category CategoryCount

response=read.csv(paste0(ESEUR_dir, "developers/remington-data.tsv.xz"), as.is=TRUE, sep="\t")

C01=subset(response, Condition == "C01")
C01=subset(C01, CorrectFlag == "true")
C02=subset(response, Condition == "C02")
C02=subset(C02, CorrectFlag == "true" & ActionUsed == 1)

s204=subset(C02, SubjectID == 204)
s208=subset(C01, SubjectID == 208)

plot(0, type="n",
	xlim=c(1, 30), ylim=c(1000, 7000),
	xlab="Trial", ylab="Response time\n")

# s204_sn=ddply(s204, .(Item), add_seq_num)

points(s204$CurrentScreen, s204$TimeUsed, col=point_col)

lines(loess.smooth(s204$CurrentScreen, s204$TimeUsed, span=0.3), col="green")
# lines(loess.smooth(s208$CurrentScreen, s208$TimeUsed, span=0.3), col="red")

# Fit a power law of practice
# s204_mod=nls(TimeUsed ~ b*CurrentScreen^c, data=s204,
# 			start=list(b=4000, c=-0.5))
# summary(s204_mod)
# # C02_mod=nls(TimeUsed ~ a+b*CurrentScreen^c, data=C02,
# # 			start=list(a=1000, b=4000, c=-0.5))
# C02_mod=nls(TimeUsed ~ b*CurrentScreen^c, data=C02,
# 			start=list(b=4000, c=-0.5))
# summary(C02_mod)
# 
# s208_mod=nls(TimeUsed ~ b*CurrentScreen^c, data=s208,
# 			start=list(b=2000, c=-0.1))
# summary(s208_mod)
# C01_mod=nls(TimeUsed ~ b*CurrentScreen^c, data=C01,
# 			start=list(b=2000, c=-0.1))
# summary(C01_mod)

# A mixed model enables us to extract variation across subjects
# power.f=deriv(~ b*CurrentScreen^c,
# 			namevec=c("b", "c"),
# 			function.arg=c("CurrentScreen", "b", "c"))
# nlme_C02_mod=nlmer(TimeUsed ~ power.f(CurrentScreen, b, c) ~ (b | SubjectID) + (b | Action),
# 		nAGQ=0,
# 		data=C02,
# 		start=c(b=4000, c=-0.27))
# summary(nlme_C02_mod)
# confint(nlme_C02_mod)
# 
# nlme_C01_mod=nlmer(TimeUsed ~ power.f(CurrentScreen, b, c) ~ (b | SubjectID) + (b | Action),
# 		nAGQ=0,
# 		data=C01,
# 		start=c(b=1000, c=-0.05))
# summary(nlme_C01_mod)
# confint(nlme_C01_mod)
# 
