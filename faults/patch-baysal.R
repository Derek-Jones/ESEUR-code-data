#
# patch-baysal.R, 21 Feb 15
#
# Data from:
# The Influence of Non-Technical Factors on Code Review
# Olga Baysal and Oleksii Kononenko and Reid Holmes and Michael W. Godfrey
# SQL cur-pasted from personal email from Olga Baysal
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("diagram")
library("RSQLite")


plot_wide()


con=dbConnect(RSQLite::SQLite(), dbname=paste0(ESEUR_dir, "faults/patch-baysal.sqlite"))

# for landed/abandoned/timeout:
res=dbSendQuery(con,
 "SELECT f.flag_value, COUNT(DISTINCT p2.patch_id)
 FROM patches p2
 JOIN (
 SELECT p.bug_id, MAX(p.date_in) AS last_date
 FROM patches p
 GROUP BY p.bug_id) lp ON lp.bug_id = p2.bug_id AND lp.last_date =
 p2.date_in
 JOIN flags f ON f.patch_id = p2.patch_id AND f.flag_num = p2.last_flag_num
 group by f.flag_value
 ;")
land_ab_time=dbFetch(res)
dbClearResult(res)

# review+ 16079
# review- 426
# review? 954


# for 3 resubs lines (r? -> Resubs; r+ -> Resubs; r- -> Rusubs):
res=dbSendQuery(con,
 "SELECT f.flag_value, COUNT(DISTINCT p2.patch_id)
 FROM patches p2
 JOIN (
   SELECT p.bug_id, MAX(p.date_in) AS last_date
   FROM patches p
   GROUP BY p.bug_id) lp ON lp.bug_id = p2.bug_id AND lp.last_date !=
 p2.date_in
 JOIN flags f ON f.patch_id = p2.patch_id AND f.flag_num = p2.last_flag_num
 group by f.flag_value
 ;")
resubmit=dbFetch(res)
dbClearResult(res)

# review+|2761
# review-|3958
# review?|10571


# for transitions such as r? -> r+, etc.:
res=dbSendQuery(con,
 "select  f1.flag_value||f2.flag_value pair, count(p.patch_id)
 from flags f1 inner join flags f2 on f1.patch_id=f2.patch_id
 inner join patches p on p.patch_id = f1.patch_id
 where f1.flag_num-f2.flag_num=-1
 group by pair
 having pair not in (\"review+review+\",\"review-review-\",\"review?review?\")
 ;")
main_trans=dbFetch(res)
dbClearResult(res)

# review+review-|279
# review+review?|34
# review-review+|165
# review-review?|35
# review?review+|18767
# review?review-|4243

dbDisconnect(con)

names=c("Submitted", "Accepted", "Rejected",
			"Landed", "Resubmitted", "Abandoned", "Timeout")
M=matrix(data=0, nrow=length(names), ncol=length(names))
colnames(M)=names
rownames(M)=names

# The following uses hard-coded transition offsets, ie, assumes
# a given ordering of values returned by the select statements :-O
# 
M["Accepted", "Landed"]=land_ab_time[1, 2]
M["Rejected", "Abandoned"]=land_ab_time[2, 2]
M["Submitted", "Timeout"]=land_ab_time[3, 2]

M["Accepted", "Resubmitted"]=resubmit[1, 2]
M["Rejected", "Resubmitted"]=resubmit[2, 2]
M["Submitted", "Resubmitted"]=resubmit[3, 2]

M["Accepted", "Rejected"]=main_trans[1, 2]
M["Accepted", "Submitted"]=main_trans[2, 2]
M["Rejected", "Accepted"]=main_trans[3, 2]
M["Rejected", "Submitted"]=main_trans[4, 2]
M["Submitted", "Accepted"]=main_trans[5, 2]
M["Submitted", "Rejected"]=main_trans[6, 2]
sub_total=sum(M["Submitted", ])
M=signif(100*M/sub_total, 2)

plotmat(t(M), pos=c(1, 2, 4), lwd=1, arr.pos=0.62, cex=1.3,
	 box.type="rect", box.prop=0.5, box.cex=1.3, shadow.size=0)

