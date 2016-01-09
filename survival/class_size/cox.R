#
# cox.R, 10 May 12
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("survival")

# Intervals terminate when a fault is detected or
# when changes are made to a file (ie, size changes).
# merge_intervals merges those intervals when the
# size changes.

merge_intervals=function(file_info)
{
if (nrow(file_info) <= 1)
   return(file_info)

final_int=vector()
mean_count=2
for (i in 1:(nrow(file_info)-1))
   {
   if (file_info$event[i] == 1)
      {
      final_int=rbind(final_int, file_info[i, ])
      mean_count=2
      }
   else
      {
# TODO average size to take account of time interval spent having a given size
      file_info$start[i+1]=file_info$start[i]
# Calculate running mean
      file_info$size[i+1]=file_info$size[i+1] +
			(file_info$size[i]-file_info$size[i+1])/mean_count
      mean_count=mean_count+1
      }
   }
final_int=rbind(final_int, file_info[nrow(file_info), ])

return(final_int)
}

# merge_intervals(kw_data[kw_data$id == 14, ])

bind_list=function(k_list)
{
res=vector()
for (i in 1:length(k_list))
   res=rbind(res, k_list[[i]])

return(res)
}

kw_data=read.csv(paste0(ESEUR_dir, "survival/class_size/kword.csv.xz"), as.is=TRUE)


# Use lapply because sapply does weird things when
# function can return either a vector or array.
# k_merged=lapply(14:15, function(x) merge_intervals(kw_data[kw_data$id == x, ]))
k_merged=lapply(1:max(kw_data$id), function(x) merge_intervals(kw_data[kw_data$id == x, ]))

k_merged=bind_list(k_merged)

kw = coxph(Surv(start, end, event) ~ size, data=k_merged)

kw = coxph(Surv(start, end, event) ~ size, data=kw_data)
summary(kw)
cox.zph(kw)


# Paper used Design package which has been superceeded by rms package
library("rms")

d=datadist(kw_data)
options(datadist="d")
kw = cph(Surv(start, end, event) ~ size, data=kw_data, x=TRUE, y=TRUE)
summary(kw)
cox.zph(kw)
survplot(kw, size)

# coxph/cph give a beta of 9.210e-04
# which disagree with Theory of relative defect proneness paper
# which gives a value of 0.74

