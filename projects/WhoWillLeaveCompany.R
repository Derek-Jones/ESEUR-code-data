#
# WhoWillLeaveCompany.R, 13 Feb 19
# Data from:
# Who will leave the company?: {A} large-scale industry study of developer turnover by mining monthly work report
# Lingfeng Bao and Zhenchang Xing and Xin Xia and David Lo and Shanping Li
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG developer employment project

source("ESEUR_config.r")

library("plyr")


mk_long=function(df)
{
return(data.frame(id=rep(df$id, 6),
	hours=t(subset(df, select=grepl("hour[1-6]", colnames(df)))),
	person=t(subset(df, select=grepl("person$", colnames(df)))),
	p_hour_mean=t(subset(df, select=grepl("_hour_mean", colnames(df)))),
	p_hour_sum=t(subset(df, select=grepl("_hour_sum", colnames(df)))),
	p_hour_std=t(subset(df, select=grepl("_hour_std", colnames(df)))),
	p_person_change=t(subset(df, select=grepl("[1-6]_person_change", colnames(df)))),
	project_num=rep(df$project_num, 6),
	multi_project=rep(df$mutli_project, 6),
	is_leave=rep(df$is_leave, 6))
	)
}


mrhrs=read.csv(paste0(ESEUR_dir, "projects/WhoWillLeaveCompany.csv.xz"), as.is=TRUE)

# Remove what look like incorrect entries
mrhrs=subset(mrhrs, hour1 != 0)

hrs=ddply(mrhrs, .(id), mk_long)

stay=subset(hrs, is_leave == "no")
leave=subset(hrs, is_leave == "yes")

plot(0, type="n",
	xlim=c(1, 6), ylim=c(0, 400))

d_ply(stay, .(id), function(df) lines(df$X1))


proj_1=subset(mrhrs, project_num == 1)

l_mod=glm(is_leave=="yes" ~
			# hour1+hour2+hour3+hour4+hour5+hour6+
			hour_sum+
			# hour_mean+
			hour_median+hour_std+hour_max+
			task_len_sum+task_len_mean+
			task_len_median+task_len_std+
			task_len_max+task_zero+
			token_sum+token_mean+
			token_median+token_std+
			token_max+
			# flesch+smog+kincaid+
			# coleman_liau+automated_readability_index+
			# dale_chall+difficult_words+
			# linsear_write+gunning_fog+
			mutli_project+
			p1_person+
			I(p1_hour_mean/hour_mean)+
			p1_hour_sum+p1_hour_std+
			# p1_person_change+
			# p2_person+
			I(p2_hour_mean/hour_mean)+
			p2_hour_sum+p2_hour_std+
			p2_person_change+
			# p3_person+
			I(p3_hour_mean/hour_mean)+
			p3_hour_sum+p3_hour_std+
			p3_person_change+
			# p4_person+
			I(p4_hour_mean/hour_mean)+
			p4_hour_sum+p4_hour_std+
			p4_person_change+
			# p5_person+
			I(p5_hour_mean/hour_mean)+
			p5_hour_sum+p5_hour_std+
			p5_person_change+
			# p6_person+
			I(p6_hour_mean/hour_mean)+
			p6_hour_sum+p6_hour_std+
			p6_person_change+
			avg_person_change+less_zero+
			equal_zero
			# +larger_zero
			, data=proj_1, family=binomial)
summary(l_mod)

