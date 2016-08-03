#
# java-type-quest.R, 14 Jul 16
#
# Data from:
#
# What Java Developers Know About Compatibility, And Why This Matters
# Jens Dietrich, Kamil Jezek, Premek Brada
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


answers=read.csv(paste0(ESEUR_dir, "developers/java-type-short.csv.xz"), as.is=TRUE)
solutions=read.csv(paste0(ESEUR_dir, "developers/java-type-quest.ans"), as.is=TRUE)


ans_base=43

# 1. Can the version of the client program compiled with lib-1.0.jar be executed with lib-2.0.jar ? The three possible answers are:
# (a) no, an error occurs
# (b) yes, but the behaviour of the program changes
# (c) yes, and the behaviour of the program does not change
# 2. Can the client program be compiled and then executed with lib-2.0.jar? The three possible answers are:
# (a) no, compilation fails
# (b) yes, but the behaviour of the program is different from the program version compiled and executed with lib-1.0.jar
# (c) yes, and the behaviour of the program is the same as the program version compiled and executed with lib-1.0.jar

# Mapping taken from file: .../cs/deploymentpuzzlersurvey/Response.java
solutions$ans_num=mapvalues(solutions$answer,
				c("UPGRADE_FAILS",
				  "UPGRADE_SUCCEEDS_BUT",
				  "UPGRADE_SUCCEEDS",
				  "RECOMPILE_FAILS",
				  "RECOMPILE_SUCCEEDS_BUT",
				  "RECOMPILE_SUCCEEDS",
				  "PRINTS_42",
				  "PRINTS_43"),
				c(1:3, 1:3, 1:2))
solutions$ans_num=as.integer(solutions$ans_num)

# answers$How.many.years.of.Java.programming.experience.do.you.have.
# answers$How.would.you.rank.your.Java.expertise.

cor.test(answers$How.many.years.of.Java.programming.experience.do.you.have.,
	 answers$How.would.you.rank.your.Java.expertise.)


num_correct=function(df)
{
df$ans_true=length(which(df[ans_base+cur_sols$short_offset] == cur_sols$ans_num))
df$ans_false=length(which(df[ans_base+cur_sols$short_offset] != cur_sols$ans_num))

return(df)
}

# ans_base=43 # for long
ans_base=42
x_range=seq(1, 4, by=0.5)
cur_sols=subset(solutions, !is.na(short_offset))

ans_vec=ddply(answers, .(RespondentID), num_correct)

ans_vec$perc=ans_vec$ans_true/(ans_vec$ans_true+ans_vec$ans_false)
ans_vec=subset(ans_vec, (perc > 0) & (perc < 1))


plot(ans_vec$How.many.years.of.Java.programming.experience.do.you.have.,
	ans_vec$ans_true+ans_vec$ans_false)

plot(ans_vec$How.many.years.of.Java.programming.experience.do.you.have., ans_vec$perc,
	ylab="T/(T+F)")

ans_mod=glm(cbind(ans_true,ans_false) ~ How.many.years.of.Java.programming.experience.do.you.have.,
			data=ans_vec, family=binomial,
			subset=(ans_true+ans_false >= 5))
g_pred=predict(ans_mod, newdata=data.frame(How.many.years.of.Java.programming.experience.do.you.have.=x_range), type="response")
lines(x_range, g_pred, col="green")



library("betareg")

b_mod=betareg(perc ~ How.many.years.of.Java.programming.experience.do.you.have., data=ans_vec)


b_pred=predict(b_mod, newdata=data.frame(How.many.years.of.Java.programming.experience.do.you.have.=x_range))
lines(x_range, b_pred, col="red")


