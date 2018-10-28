#
# Profes2017-aman.csv, 10 Oct 18
# Data from:
# A Survival Analysis of Source Files Modified by New Developers
# Hirohisa Aman and Sousuke Amasaki and Tomoyuki Yokogawa and Minoru Kawahara
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG fault source-file developers project survival

source("ESEUR_config.r")


library("survival")


Prof=read.csv(paste0(ESEUR_dir, "survival/Profes2017-aman.csv.xz"), as.is=TRUE)
proj_list=read.csv(paste0(ESEUR_dir, "survival/Prof-projlist.csv.xz"), as.is=TRUE)
proj_list$git_url=NULL
proj_list$lang=ifelse(proj_list$no <= 50, "Java", "C++")

file_life=merge(Prof, proj_list, by="project_name", all=TRUE)

cpp=subset(file_life, lang="C++")
java=subset(file_life, lang="Java")

s_cpp=survfit(Surv(cpp$time, !cpp$status) ~ 1)
plot(s_cpp, col="red")
s_java=survfit(Surv(java$time, !java$status) ~ 1)
lines(s_java, col="green")


best_mod=coxph(Surv(time, !status) ~ lang
					, data=file_life)
summary(best_mod)
best_mod=coxph(Surv(time, !status) ~ author_count
					, data=file_life)
summary(best_mod)
best_mod=coxph(Surv(time, !status) ~ file_count
					, data=file_life)
summary(best_mod)
best_mod=coxph(Surv(time, !status) ~ category+frailty(project_name)
					, data=file_life)
summary(best_mod)
best_mod=coxph(Surv(time, !status) ~ frailty(project_name)
					, data=file_life)
summary(best_mod)

t=cox.zph(best_mod)
summary(best_mod)



