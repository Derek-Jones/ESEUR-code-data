#
# kripp-spearman-lowsd.R, 11 Oct 12
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Data from paper "Learning a Metric for Code Readability",
# by Raymond P. L. Buse and Westley R. Weimer
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

# Only snippets having a rating sd of less than 1

#jk_kripp.alpha(cs1_subj[ , apply(cs1_subj, 2, sd) < 1])
#jk_kripp.alpha(cs2_subj[ , apply(cs2_subj, 2, sd) < 1])
#jk_kripp.alpha(cs4_subj[ , apply(cs4_subj, 2, sd) < 1])

# The calculation takes for every, so here is one I did earlier...
cat("Krippendorff's alpha\n")
cat("cs1: 0.2139179 0.2493418\n")
cat("cs2: 0.3706919 0.3826060\n")
cat("cs4: 0.4386240 0.4542783\n")


#jk_meanrho(cs1_subj[ , apply(cs1_subj, 2, sd) < 1])
#jk_meanrho(cs2_subj[ , apply(cs2_subj, 2, sd) < 1])
#jk_meanrho(cs4_subj[ , apply(cs4_subj, 2, sd) < 1])

cat("mean Spearman's rho\n")
cat("cs1: 0.3033275 0.3485862\n")
cat("cs2: 0.4312944 0.4443740\n")
cat("cs4: 0.4868830 0.5034737\n")

