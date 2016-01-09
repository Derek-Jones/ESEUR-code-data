#
# patch-fsm-baysal.R, 15 Jan 15
#
# Data from:
# The Influence of Non-Technical Factors on Code Review
# Olga Baysal and Oleksii Kononenko and Reid Holmes and Michael W. Godfrey
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")


report_fsm=function(df)
{
if (df$flag_value[1] != "review?")
   return()
cur_state="init"
for (num in 1:nrow(df))
   {
#   print(c(cur_state, num, df$flag_value[num]))
   next_state=transitions[df$flag_value[num], cur_state]
# print(next_state)
   tran_count[cur_state, next_state]<<-1+tran_count[cur_state, next_state]
   cur_state=next_state
   }
if (cur_state == "resubmitted")
   return()
# print(cur_state)
next_state=final_trans[cur_state, "state"]
# print(next_state)
tran_count[cur_state, next_state]<<-1+tran_count[cur_state, next_state]
}


reviews=read.csv(paste0(ESEUR_dir, "faults/misc/patch-baysal.csv.xz"), as.is=TRUE)
transitions=read.csv(paste0(ESEUR_dir, "faults/misc/patch-baysal.fsm"), as.is=TRUE)

# Grrr, nonsense needed to undo creation of a factor
t=c("timeout", "landed", "abandoned")
final_trans=data.frame(state=rep(0, 3))
final_trans$state=t
rownames(final_trans)=c("submitted", "accepted", "rejected")

tran_count=matrix(data=0, nrow=4, ncol=7)
rownames(tran_count)=c("submitted", "accepted", "rejected", "init")
colnames(tran_count)=c("submitted", "accepted", "rejected",
			"landed", "resubmitted", "abandoned", "timeout")



d_ply(reviews, .(patch_id), report_fsm)

# values in tran_count not used...

