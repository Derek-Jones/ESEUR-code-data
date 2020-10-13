#
# composite-mean-diff.R, 17 Jul 20
# Data from:
# Cost and Schedule Estimation Study Report
# Steve Condon and Myrna Regardie and Mike Stark and Sharon Waligora
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG estimate_schedule composite-data project_schedule


source("ESEUR_config.r")


library("compositions")

reuse_pair=function()
{
# Sample reuse data and map to proportion of whole.
p1=sample(1:num_all, replace=TRUE)
s_ada=rcomp(reuse[p1[1:num_ada], ], parts=reuse_cols)
s_fortran=rcomp(reuse[p1[(num_ada+1):num_all], ], parts=reuse_cols)

# Calculate each mean and return distance
s_mean=rbind(mean(s_ada), mean(s_fortran))
return(dist(s_mean))
}


reuse=read.csv(paste0(ESEUR_dir, "projects/EstimationStudy.csv.xz"), as.is=TRUE)

ada=subset(reuse, Lang == "A")
fortran=subset(reuse, Lang == "F")

reuse_cols=c("New_written", "Extensive_modified", "Slight_modified", "Verbatim")
r_ada=rcomp(ada, parts=reuse_cols)
r_fortran=rcomp(fortran, parts=reuse_cols)

m_ada_r=mean(r_ada)
m_fortran_r=mean(r_fortran)

m_reuse=rbind(m_ada_r, m_fortran_r)

act_m_dist=dist(m_reuse)

num_ada=nrow(ada)
num_fortran=nrow(fortran)
num_all=num_ada+num_fortran

b_mean_dist=replicate(9999, reuse_pair())

# What percentage have a mean distance this large/small?
length(which(act_m_dist > b_mean_dist))/9999
# [1] 0.9675968
length(which(act_m_dist < b_mean_dist))/9999
# [1] 0.03240324
 
