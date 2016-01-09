#
# num_auth_AW.R,  4 Mar 14
#
# Data from:
# On the variation and specialisation of workload - A case study of the Gnome ecosystem community
# Bogdan Vasilescu and Alexander Serebrenik and Mathieu Goeminne and Tom Mens
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

aw_path = paste0(ESEUR_dir, "regression/AW.csv.xz")
nta_path = paste0(ESEUR_dir, "regression/NTA.csv.xz")

AW = read.csv(file=aw_path, head=TRUE, sep=";")
NTA = read.csv(file=nta_path, head=TRUE, sep=";")

mdf = merge(AW, NTA)

# Ignore 'unknown' activities
# Authors with 14 activities become authors with 13 activities
mdf1 = mdf
mdf1[which(mdf1$NTA == 14),]$NTA = 13

# Figure 13 from paper [how not to do it]
# hist(log(mdf1$AW), breaks=24,
# 	main="", xlab="log(author workload)", ylab="Number of authors")

# When density is plotted the result does not look as interesting,
# from the perspective of a combination of multiple distributions,
# as what appears in the paper :-(
plot(density(mdf1$AW), log="x", type="l",
	xlab="Author workload", main="")

bin_offset=exp(seq(0, log(max(mdf1$AW)), length.out=24))

t=hist(mdf1$AW, breaks=bin_offset, plot=FALSE)

plot(bin_offset[-length(t$count)], t$density, log="x", type="s",
	col="blue",
	xlim=c(1, 100),
	xlab="Author workload", ylab="Author density")


# A mixture of Poissons seems to give the best fit
reb_mod=REBMIX(Dataset=list(data.frame(AW=mdf1$AW)),
		Preprocessing="histogram",
		cmax=5,
		Variables="continuous",
		pdf="Poisson",
		K=10:50)

# work_tab=table(mdf1$AW)
# mix_mod=poisregmixEM(as.vector(work_tab), as.integer(names(work_tab)))

# mix_mod=normalmixEM(mdf1$AW)

# reb_mod=REBMIX(Dataset=list(data.frame(AW=log(mdf1$AW))),
# 		Preprocessing="histogram",
# 		cmax=5,
# 		Variables="continuous",
# 		pdf="gamma",
# 		K=10:50)

# plot(reb_mod)
# summary(reb_mod)

print(coef(reb_mod))

