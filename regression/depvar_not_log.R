#
# depvar_not_log.R, 24 Dec 15
#
# Data from:
# On the variation and specialisation of workload - A case study of the Gnome ecosystem community
# Bogdan Vasilescu and Alexander Serebrenik and Mathieu Goeminne and Tom Mens
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

pal_col=rainbow(4)

aw_path = paste0(ESEUR_dir, "regression/AW.csv.xz")
nta_path = paste0(ESEUR_dir, "regression/NTA.csv.xz")

AW = read.csv(file=aw_path, head=TRUE, sep=";")
NTA = read.csv(file=nta_path, head=TRUE, sep=";")

mdf = merge(AW, NTA)

# Ignore 'unknown' activities
# Authors with 14 activities become authors with 13 activities
mdf1 = mdf
mdf1[which(mdf1$NTA == 14),]$NTA = 13

AW_ident = glm(log(AW) ~ NTA, data=mdf1)
AW_log = glm(AW ~ NTA, data=mdf1, family=gaussian(link="log"))
# AW_gamma = glm(AW ~ NTA, data=mdf1, family=Gamma(link="log"))

# par(mfrow=c(1,2))
# 
# plot(mdf1$NTA, mdf1$AW, xlab="NTA", ylab="AW")

plot(mdf1$NTA, mdf1$AW, log="y", col=point_col,
	xlab="Activity types per author", ylab="Author workload\n")

NTA_bounds=1:13
pred=predict(AW_ident, newdata=data.frame(NTA=NTA_bounds), se.fit=TRUE)
lines(NTA_bounds, exp(pred$fit), col=pal_col[1])
lines(exp(pred$fit+1.96*pred$se.fit), col=pal_col[2])
lines(exp(pred$fit-1.96*pred$se.fit), col=pal_col[2])

pred=predict(AW_log, newdata=data.frame(NTA=NTA_bounds), type="link", se.fit=TRUE)
lines(exp(pred$fit), col=pal_col[3])
lines(exp(pred$fit+1.96*pred$se.fit), col=pal_col[4])
lines(exp(pred$fit-1.96*pred$se.fit), col=pal_col[4])

# pred=predict(AW_gamma, newdata=data.frame(NTA=NTA_bounds), type="link", se.fit=TRUE)
# lines(exp(pred$fit), col=pal_col[3])
# lines(exp(pred$fit+1.96*pred$se.fit), col=pal_col[4])
# lines(exp(pred$fit-1.96*pred$se.fit), col=pal_col[4])


# Values are not symmetricly distributed abount their median
# plot(density(mdf1$AW[mdf1$NTA == 1], adjust=0.5), log="x", col=point_col)
# plot(density(mdf1$AW[mdf1$NTA == 2], adjust=0.5), log="x", col=point_col)
# plot(density(mdf1$AW[mdf1$NTA == 3], adjust=0.5), log="x", col=point_col)
# plot(density(mdf1$AW[mdf1$NTA == 4], adjust=0.5), log="x", col=point_col)

