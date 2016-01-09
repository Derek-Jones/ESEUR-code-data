#
# proj-lifespan.R, 26 Dec 15
#
# Data from:
# Software Lifetime and its Evolution Process over Generations
# Tetsuo Tamai and Yohsuke Torimitsu
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

pal_col=rainbow(2)

life=read.csv(paste0(ESEUR_dir, "economics/system-lifetime.csv.xz"), as.is=TRUE)


num_years=nrow(life)
t=cumsum(life$projects)
num_proj=max(t)
t=num_proj-t
plot(t, col=pal_col[1],
	ylim=c(0,num_proj),
	xlab="Years", ylab="Systems still in Use")

x=1:num_years

# and glm is not used because???
q=nls(t ~ a*b^x, start=list(a=100, b=0.8))
#q=nls(t ~ a*exp(b*x), start=list(a=100, b=0.2))
#summary(q)

lines(predict(q), col=pal_col[2])

