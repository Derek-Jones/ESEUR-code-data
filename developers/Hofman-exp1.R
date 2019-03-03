#
# Hofman-exp1.R, 12 Nov 17
# Data from:
# Behavioral Products Quality Assessment Model on the Software Market
# Rados{\l}aw Hofman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


library("plyr")


# S_AB,S_LH,S_1234M,H,Group,Task,Task_LH,F0,Correct actions,Correct perc,A1:Evaluation time,A2:Operations performed,A3:Critical failures,A4:Other failures,B1:Product quality,B2:Rich functionality,B3:Complies formal rules,B4:Efficiency,B5:Productivity,B6:Pleasentness,B7:Learnability,B8:Customizable,B9:Robustness,B10:Safety,B11:Security
# A,L,1,H,A.C,App1,A.L,0,99,100,30,100,2,NA,8,8,7,11,11,8,10,3,6,6,11
hof=read.csv(paste0(ESEUR_dir, "developers/Hofman-exp1.csv.xz"), as.is=TRUE)

AL=subset(hof, S_AB == "A" & S_LH == "L")
AH=subset(hof, S_AB == "A" & S_LH == "H")
BL=subset(hof, S_AB == "B" & S_LH == "L")
BH=subset(hof, S_AB == "B" & S_LH == "H")

