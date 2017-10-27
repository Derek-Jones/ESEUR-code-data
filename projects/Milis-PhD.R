#
# Milis-PhD.R, 20 Aug 17
# Data from:
# Success factors for {ICT} projects: {Empirical} research, utilising qualitative and quantitative approaches (incl. {Bayesian} networks, Probabilistic feature models)",
# Koen Milis
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


proj=read.csv(paste0(ESEUR_dir, "projects/Milis-PhD.csv.xz"), as.is=TRUE)

library("MASS")

# Pairwise association
EU_mod=glm(cbind(EU_f, EU_s) ~ (on_time+ within_budget+ to_specification
				+management_happy+ proj_team_happy+ user_happy
				+fin_com_succ)^2,
				data=proj, family=binomial)
# Remove deadwood
T_mod=stepAIC(EU_mod)

# Gives: 
#  cbind(EU_f, EU_s) ~ on_time + within_budget + to_specification + 
#     management_happy + user_happy + fin_com_succ + on_time:to_specification + 
#     on_time:management_happy + on_time:user_happy + on_time:fin_com_succ + 
#     to_specification:management_happy + management_happy:user_happy
# 
# which is overfitted

# Simplifying on p-values we get:
EU_mod=glm(cbind(EU_f, EU_s) ~ on_time
#				+within_budget
#				+to_specification
#				+management_happy
#				+proj_team_happy
				+user_happy
				+fin_com_succ
				+to_specification:management_happy,
				data=proj, family=binomial)
summary(EU_mod)


# Repeat for management outlook
M_mod=glm(cbind(M_f, M_s) ~ (on_time+ within_budget+ to_specification
				+management_happy+ proj_team_happy+ user_happy
				+fin_com_succ)^2,
				data=proj, family=binomial)
# Remove deadwood
T_mod=stepAIC(M_mod)

# Gives: 
# cbind(M_f, M_s) ~ on_time + within_budget + to_specification + 
#     management_happy + proj_team_happy + user_happy + fin_com_succ + 
#     on_time:within_budget + on_time:to_specification + on_time:management_happy + 
#     within_budget:user_happy + within_budget:fin_com_succ + to_specification:management_happy + 
#     to_specification:proj_team_happy + to_specification:fin_com_succ + 
#     management_happy:proj_team_happy + management_happy:user_happy
# which is overfitted

# Simplifying on p-values we get:
M_mod=glm(cbind(EU_f, EU_s) ~ on_time
				+within_budget
#				+to_specification
#				+management_happy
				+proj_team_happy
				+user_happy
				+fin_com_succ
#				+on_time:within_budget
#				+management_happy:proj_team_happy
				,
				data=proj, family=binomial)
summary(M_mod)


# Repeat for Team member not benefactor (i.e., not going to use the system)
# outlook
TNB_mod=glm(cbind(TNB_f, TNB_s) ~ (on_time+ within_budget+ to_specification
				+management_happy+ proj_team_happy+ user_happy
				+fin_com_succ)^2,
				data=proj, family=binomial)
# Remove deadwood
T_mod=stepAIC(TNB_mod)

# Gives: 
# cbind(TNB_f, TNB_s) ~ on_time + within_budget + to_specification + 
#     management_happy + proj_team_happy + user_happy + fin_com_succ + 
#     on_time:fin_com_succ + within_budget:proj_team_happy + within_budget:fin_com_succ + 
#     to_specification:proj_team_happy + to_specification:user_happy + 
#     management_happy:user_happy
# which is overfitted

# Simplifying on p-values we get:
TNB_mod=glm(cbind(TNB_f, TNB_s) ~ # on_time+
				within_budget
#				+to_specification
#				+management_happy
#				+proj_team_happy
				+user_happy
#				+fin_com_succ
				+to_specification:user_happy
				,
				data=proj, family=binomial)
summary(TNB_mod)


# Repeat for Team member benefactor outlook
TB_mod=glm(cbind(TB_f, TB_s) ~ (on_time+ within_budget+ to_specification
				+management_happy+ proj_team_happy+ user_happy
				+fin_com_succ)^2,
				data=proj, family=binomial)
# Remove deadwood
T_mod=stepAIC(TB_mod)

# Gives: 
# cbind(TB_f, TB_s) ~ on_time + within_budget + to_specification + 
#     management_happy + proj_team_happy + user_happy + fin_com_succ + 
#     on_time:within_budget + on_time:to_specification + on_time:management_happy + 
#     on_time:proj_team_happy + on_time:user_happy + within_budget:to_specification + 
#     within_budget:management_happy + within_budget:proj_team_happy + 
#     within_budget:user_happy + to_specification:management_happy + 
#     to_specification:user_happy + to_specification:fin_com_succ + 
#     management_happy:proj_team_happy + management_happy:user_happy
# which is overfitted

# Simplifying on p-values we get:
TB_mod=glm(cbind(TB_f, TB_s) ~ on_time
#				+within_budget
#				+to_specification
#				+management_happy
#				+proj_team_happy
				+user_happy
				+fin_com_succ
				+to_specification:fin_com_succ
				,
				data=proj, family=binomial)
summary(TB_mod)






