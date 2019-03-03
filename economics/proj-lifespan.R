#
# proj-lifespan.R, 27 Nov 18
#
# Data from:
# Mainframe data:
# Software Lifetime and its Evolution Process over Generations
# Tetsuo Tamai and Yohsuke Torimitsu
# Google data:
# https://killedbygoogle.com
# Cody Ogden
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG lifetime software mainframe 1990 Google 2010 SaaS


source("ESEUR_config.r")


library(jsonlite)


pal_col=rainbow(2)


mainf=read.csv(paste0(ESEUR_dir, "economics/system-lifetime.csv.xz"), as.is=TRUE)

mainf$days=mainf$years*365.25

goog=fromJSON(paste0(ESEUR_dir, "ecosystems/graveyard.json.xz"))

goog$dateOpen=as.Date(goog$dateOpen, format="%Y-%m-%d")
goog$dateClose=as.Date(goog$dateClose, format="%Y-%m-%d")

goog$lifetime=as.numeric(goog$dateClose-goog$dateOpen+1)

soft_only=subset(goog, !(grepl("Pixel", goog$description) |
			  grepl("Nexus", goog$description) |
			  grepl("Google Glass", goog$description)))

lifetime=data.frame(available=nrow(soft_only):1, age=sort(soft_only$lifetime))

plot(sort(soft_only$lifetime), nrow(soft_only):1, log="y", col=pal_col[2],
	xaxs="i",
	xlim=range(mainf$days), ylim=c(1, nrow(soft_only)),
	xlab="Days", ylab="Software systems in use\n")

# Additive error gives a fit with smaller percentage of residual deviance
# But is a multiplicative error more realistic?
# l_mod=glm(log(available) ~ age, data=lifetime)
l_mod=glm(available ~ age, data=lifetime, family=poisson)
# summary(l_mod)
pred=predict(l_mod)
lines(lifetime$age, exp(pred), col=pal_col[2])

# hist(round(goog$lifetime/365.25), breaks=20)
# 
# plot(density(goog$lifetime, cut=0, n=32))


num_years=nrow(mainf)
t=cumsum(mainf$projects)
num_proj=max(t)
mainf$remaining=num_proj-t
points(mainf$days, mainf$remaining, col=pal_col[1])

mainf=head(mainf, n=-1)

# IBM_mod=glm(log(remaining) ~ days, data=mainf)
# summary(IBM_mod)
# lines(mainf$days, exp(predict(IBM_mod)), col=pal_col[1])

# Additive error gives a fit with smaller percentage of residual deviance
yr1_mod=glm(remaining ~ days, data=mainf, family=poisson)
summary(yr1_mod)
lines(mainf$days, predict(yr1_mod, type="response"), col=pal_col[1])

# yr2_mod=glm(remaining ~ days+I(days^2), data=mainf, family=poisson)
# summary(yr2_mod)
# lines(mainf$days, predict(yr2_mod, type="response"), col=pal_col[1])

# a power law model just to see what it looks like
# q=nls(remaining ~ a*b^years, data=mainf, start=list(a=100, b=0.8))
# summary(q)

# lines(predict(q), col=pal_col[3])

legend(x="bottomleft", legend=c("Mainframe", "Google"), bty="n", fill=pal_col, cex=1.2)


