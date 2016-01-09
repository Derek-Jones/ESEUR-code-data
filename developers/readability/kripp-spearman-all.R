#
# kripp-spearman-all.R,  5 Jan 16
#
# Data from:
# Learning a Metric for Code Readability
# Raymond P. L. Buse and Westley R. Weimer
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("irr")

all_snip_data=read.csv(paste0(ESEUR_dir, "developers/readability/readability-tse.csv.xz"),
                   header=FALSE, as.is=TRUE)

cs1_subj=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs1", ][, -2:-1]
cs2_subj=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs2", ][, -2:-1]
cs4_subj=all_snip_data[substr(all_snip_data[, 2], 1, 3) =="cs4", ][, -2:-1]

# point values
c(cs1=kripp.alpha(as.matrix(cs1_subj), method="ordinal")$value,
  cs2=kripp.alpha(as.matrix(cs2_subj), method="ordinal")$value,
  cs4=kripp.alpha(as.matrix(cs4_subj), method="ordinal")$value)

c(cs1=meanrho(t(cs1_subj))$value,
  cs2=meanrho(t(cs2_subj))$value,
  cs4=meanrho(t(cs4_subj))$value)


library("bootstrap")

kripp.alpha_theta=function(x, xdata)
{
kripp.alpha(as.matrix(xdata[x,]), method="ordinal")$value
}

jk_kripp.alpha=function(cs_subj)
{
cs_jackknife=jackknife(1:nrow(cs_subj), kripp.alpha_theta, cs_subj)
quantile(cs_jackknife$jack.values, c(0.025, 0.975))
}


#jk_kripp.alpha(cs1_subj)
#jk_kripp.alpha(cs2_subj)
#jk_kripp.alpha(cs4_subj)

# The calculation takes for every, so here is one I did earlier...
cat("Krippendorff's alpha\n")
# jk_kripp.alpha(cs1_subj)
cat("cs1: 0.1225897 0.1483692\n")
# jk_kripp.alpha(cs2_subj)
cat("cs2: 0.2768906 0.2865904\n")
# jk_kripp.alpha(cs4_subj)
cat("cs4: 0.3245399 0.3405599\n")

meanrho_theta=function(x, xdata)
{
meanrho(t(xdata[x,]))$value
}

jk_meanrho=function(cs_subj)
{
cs_jackknife=jackknife(1:nrow(cs_subj), meanrho_theta, cs_subj)
quantile(cs_jackknife$jack.values, c(0.025, 0.975))
}


#jk_meanrho(cs1_subj)
#jk_meanrho(cs2_subj)
#jk_meanrho(cs4_subj)

cat("mean Spearman's rho\n")
# jk_meanrho(cs1_subj)
cat("cs1: 0.1844359 0.2167592\n")
# jk_meanrho(cs2_subj)
cat("cs2: 0.3305273 0.3406769\n")
# jk_meanrho(cs4_subj)
cat("cs4: 0.3651752 0.3813630\n")

