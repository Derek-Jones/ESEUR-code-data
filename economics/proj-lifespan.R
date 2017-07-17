#
# proj-lifespan.R, 19 Apr 17
#
# Data from:
# Software Lifetime and its Evolution Process over Generations
# Tetsuo Tamai and Yohsuke Torimitsu
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

pal_col=rainbow(3)

life=read.csv(paste0(ESEUR_dir, "economics/system-lifetime.csv.xz"), as.is=TRUE)


num_years=nrow(life)
t=cumsum(life$projects)
num_proj=max(t)
life$remaining=num_proj-t
plot(life$years, life$remaining, log="y", col=pal_col[1],
	ylim=c(1, num_proj),
	xlab="Years", ylab="Systems in use")

yr1_mod=glm(remaining ~ years, data=life, family=poisson)
# summary(yr1_mod)
lines(predict(yr1_mod, type="response"), col=pal_col[2])

yr2_mod=glm(remaining ~ years+I(years^2), data=life, family=poisson)
# summary(yr2_mod)
lines(predict(yr2_mod, type="response"), col=pal_col[3])

# a power law model just to see what it looks like
# q=nls(remaining ~ a*b^years, data=life, start=list(a=100, b=0.8))
# summary(q)

# lines(predict(q), col=pal_col[3])

