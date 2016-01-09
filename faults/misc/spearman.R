#
# spearman.R, 26 May 2015
#
# Data from:
# Predicting Defects for Eclipse
# Data source: "Predicting Defects for Eclipse" (dataset version 2.0a) by
#              Thomas Zimmermann and Rahul Premraj and Andreas Zeller
#              http://www.st.cs.uni-saarland.de/softevo/bug-data/eclipse/
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")



calc_spearman = function(ecl_data)
{

pre_p=apply(ecl_data, 2, function(X)
   			cor.test(X, ecl_data$pre, method="spearman", exact=FALSE)$p.value)
post_p=apply(ecl_data, 2, function(X)
   			cor.test(X, ecl_data$post, method="spearman", exact=FALSE)$p.value)

cbind(cor(ecl_data, ecl_data$pre, method="spearman"),
      cor(ecl_data, ecl_data$post, method="spearman"),
      (pre_p<0.01), (post_p<0.01))
}

read_data = function(filename)
{
eclipse_data=read.csv(paste0(ESEUR_dir, "faults/eclipse/", filename), sep=";", as.is=TRUE)

return (eclipse_data)
}

ecl_2.0=read_data("eclipse-metrics-files-2.0.csv.xz")
calc_spearman(ecl_2.0[, 3:35])
ecl_2.1=read_data("eclipse-metrics-files-2.1.csv.xz")
calc_spearman(ecl_2.1[, 3:35])
ecl_3.0=read_data("eclipse-metrics-files-3.0.csv.xz")
calc_spearman(ecl_3.0[, 3:35])

