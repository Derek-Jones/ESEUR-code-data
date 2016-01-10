#
# coderev-stream.R, 30 Dec 15
#
# Data from:
# An empirical study on the effectiveness of security code review
# Anne Edmundson and Brian Holtkamp and Emanuel Rivera and Matthew Finifter and Adrian Mettler and David Wagner
#
# R code for book "Empirical Software Engineering using R"
# Derek M. Jones, http://shape-of-code.coding-guidelines.com
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


source(paste0(ESEUR_dir, "common/vwReg.R"))

pal_col=rainbow(2)

# correct,false_report
rev_tf=read.csv(paste0(ESEUR_dir, "regression/coderev-cor_false.csv.xz"))

# Remove point to make plot look prittier.
rev_tf=rev_tf[-c(30), ]
#rev_tf=rev_tf[-c(28, 29, 30), ]
#rev_tf=rev_tf[-c(11, 22, 24, 25, 26, 27, 28, 29, 30), ]

# No support for poisson error distribution...
# or changing the axis...
t=vwReg(correct ~ false_report, data=rev_tf, method=glm)
plot(t)

