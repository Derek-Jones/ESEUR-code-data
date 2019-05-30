#
# drools.R, 18 Oct 18
# Data from:
# Parameter-Free Probabilistic {API} Mining across {GitHub}
# Jaroslav Fowkes and Charles Sutton
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG API method-calls


source("ESEUR_config.r")


library("arules")


# Convert original Fowkes and Sutton data into two column data transactions
# library("foreign")
# library("plyr")
# 
# 
# split_calls=function(df)
# {
# return(data.frame(called=unlist(strsplit(df$fqCalls, " "))))
# }
# 
# 
# drool=read.arff(paste0(ESEUR_dir, "odds-and-ends/drools.arff"))
# 
# d=ddply(drool, .(fqCaller), split_calls)
# 
# write.csv(d, file="drools.csv.xz", row.names=FALSE)


drools=read.transactions(paste0(ESEUR_dir, "odds-and-ends/drools.csv.xz"),
			format="single", cols=c(1, 2))

rules=apriori(drools, parameter=list(support=0.0001, confidence=0.1))

summary(rules)
inspect(head(rules, n=3, by = "confidence"))

