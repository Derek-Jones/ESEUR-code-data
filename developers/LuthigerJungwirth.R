#
# LuthigerJungwirth.R, 21 Sep 18
# Data from:
# Pervasive Fun
# Benno Luthiger and Carola Jungwirth
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG developer fun

source("ESEUR_config.r")

library("ordinal")


pal_col=rainbow(10)

# See LuthigerJungwirth.txt for information on columns
fasd=read.csv(paste0(ESEUR_dir, "developers/LuthigerJungwirth.csv.xz"), as.is=TRUE)

fasd[fasd == -1]=NA

# Response variable must be a factor.
# How much (on average, in percent) of your spare time do you spend on
# activities concerning open source projects?
# Response binned into 10% increments
fasd$q42=as.factor(fasd$q42)

fun_mod=clm(q42 ~ q1+q2+q3+q4+q5+q6+q7+q8+q9+
                  q11+q12+q13+q14+q15+q16+q17+q18+q19+
                  q21+q22+q23+q24+q25+q26+q27+q28+q29+
                  q31+q32+q33+q34+q35,
			data=fasd)

fun_mod=clm(q42 ~             q5+
#                      q12+q13+        q16+q17+
#                              q24+q25+            q29+
                                                  q29+
#                  q31+            q35,
                  q31                ,
			data=fasd)
# summary(fun_mod)

# drop1(fun_mod, test = "Chi")

# confint(fun_mod, type = "Wald")

# round(exp(fun_mod$beta), 1)
# round(exp(confint(fun_mod, type = "Wald")), 1)

# Difference between thresholds
# diff(fun_mod$alpha)

# Which link function gives the best fit?
# Highest (i.e., towards +infinity) is best.
# links = c("logit", "probit", "cloglog", "loglog", "cauchit")
# sapply(links, function(link)
# 		{
# 		clm(q42 ~ q5+ q29+ q31,
#                         data=fasd, link=link)$logLik
# 		})


# Fitted so a plot can be shown.
f_mod=clm(q42 ~ q31, data=fasd)
# summary(f_mod)

pred=predict(f_mod, newdata=data.frame(q31=1:6))

plot(-1, type="n",
	xaxs="i", yaxs="i",
	xlim=c(1, 6), ylim=c(0, 0.6),
	xlab="q31", ylab="Probability\n")

dummy=sapply(1:10, function(X)
			lines(1:6, pred$fit[ ,X], col=pal_col[X]))

legend(x="topright", legend=paste0(seq(0, 90, 10), "-", seq(10, 100, 10), "%"), bty="n", fill=pal_col, cex=1.2)

# Data and questionaire kindly provided by Luthiger 
# 
# How do you feel about being an open source developer?
# How often do the following statements apply to
# 
# 1 I lose my sense of time.
# 2 I cannot say how long I’ve been with programming.
# 3 I am in a state of flow when I’m working.
# 4 I forget all my worries when I’m working.
# 5 It’s easy for me to concentrate.
# 6 I’m all wrapped up in the action.
# 7 I am absolutely focused on what I’m programming.
# 8 The requirements of my work are clear to me.
# 9 I hardly think of the past or the future.
# 10 I know exactly what is required of me.
# 11 There are many things I would prefer doing.
# 12 I feel that I can cope well with the demands of the situation.
# 13 My work is solely motivated by the fact that it will pay for me.
# 14 I always know exactly what I have to do.
# 15 I’m very absent-minded.
# 16 I don’t have to muse over other things.
# 17 I know how to set about it.
# 18 I’m completely focused.
# 19 I feel able to handle the problem.
# 20 I am extremely concentrated.
# 21 I’m looking forward to my programming work.
# 22 I enjoy my work.
# 23 I feel the demands upon me are excessive.
# 24 Things just seem to fall into place.
# 25 I forget everything around me.
# 26 I accomplish my work for its own sake.
# 27 I completely concentrate on my programming work.
# 28 I am easily distracted by other things.
# 29 I’m looking forward to further development activities for open source software.
# 30 I’m prepared to increase my future commitment in the development of open source software.
# 31 With one more hour in the day, I would program open source software.
# How do you feel about the open source projects?
# 32 How often are the open source projects you work on based on a definite project vision?
# 33 How often is there a deadline for your open source projects?
# 34 How important is the vision behind an open source project for you to participate in the project?
# 35 How important is the professional competence of the project leader for your commitment in an open source project?
# 36 As a project member: What are your reasons for participating in open source projects?
# projects?
# a It was important for my work to have a certain functionality; that’s why I joined the open source project and got involved.
# b My employer asked me to participate in the open source project because he needed its functionality.
# c Because I wanted to do something for the open source community.
# d The project promised to be fun.
# e My colleagues motivated me to participate in the open source project.
# f By participating in the open source project you could become famous.
# g Because I wanted to learn and develop new skills.
# 37 As a project leader: For what reasons did you initiate your open source project(s)?
# a I needed a certain functionality for my work, and I wanted to make this functionality available as an open source application.
# b My employer asked me to start the open source project because he needed the functionality.
# c My employer asked me to start the open source projectbecause he could earn money with the application.
# d Because I wanted to do something for the open sourcecommunity.
# e One open source project in the past didn’t develop asdesired, therefore I had to start my own.
# f The project promised to be fun.
# g I needed assistants to complete a software project.
# h With an open source project you could become famous. 
# How do you organize your time and commitment in theopen source area?
# 38 How many patches have you developed for open source software?
# 39 How many classes/modules/files etc. have you developed for open source software?
# 40 Please estimate the time you spend for the development of open source software (average hours per week).
# 41 Of the total time spent for the development of open source software, how much in percent is part of your spare time?
# 42 How much (on average, in percent) of your spare time do you spend on activities concerning open source projects?
# 43 Please specify the most important position you hold or held in an open source project.
# Demographic data:
# 44 Please state the year in which you started to develop open source software.
# 45 How old were you when you started to develop open source software?
# 46 Do you have children?
# 47 Are there other adults living in the same household with you?
# 
