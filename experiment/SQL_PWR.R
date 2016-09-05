#
# SQL_PWR.R, 23 Aug 16
# Data from:
# Variability-Aware Performance Prediction: {A} Statistical Learning Approach
# Jianmei Guo and Krzysztof Czarnecki and Sven Apel and Norbert Siegmund and Andrzej W\c{a}sowski
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


merge_df=function(file_str)
{
sql_t=read.csv(paste0(ESEUR_dir, file_str), as.is=TRUE)
sql=rbind(sql, sql_t)
}


sql=read.csv(paste0(ESEUR_dir, "experiment/SQL_PWR1.csv.xz"), as.is=TRUE)
sql=merge_df("experiment/SQL_PWR2.csv.xz")
sql=merge_df("experiment/SQL_PWR3.csv.xz")
sql=merge_df("experiment/SQL_PWR4.csv.xz")
sql=merge_df("experiment/SQL_PWR5.csv.xz")

s_mod=glm(Performance ~ ., data=sql)
summary(s_mod)

sapply(1:(ncol(sql)-1), function(X) table(sql[, X]))

