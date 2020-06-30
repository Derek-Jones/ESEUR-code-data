#
# WhoWillLeaveCompany.R, 21 Jun 20
# Data from:
# Who will leave the company?: {A} large-scale industry study of developer turnover by mining monthly work report
# Lingfeng Bao and Zhenchang Xing and Xin Xia and David Lo and Shanping Li
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG developer_employment project_hours project_staffing

source("ESEUR_config.r")


library("plyr")


# Convert a data.frame row to a vector
row2vec=function(df)
{
return(as.vector(t(df)))
}


mk_long=function(df)
{
return(data.frame(id=rep(df$id, 6),
	hours=row2vec(subset(df, select=grepl("hour[1-6]", colnames(df)))),
	p_person=row2vec(subset(df, select=grepl("person$", colnames(df)))),
	p_hour_mean=row2vec(subset(df, select=grepl("_hour_mean", colnames(df)))),
	p_hour_sum=row2vec(subset(df, select=grepl("_hour_sum", colnames(df)))),
	p_hour_std=row2vec(subset(df, select=grepl("_hour_std", colnames(df)))),
	p_person_change=row2vec(subset(df, select=grepl("[1-6]_person_change", colnames(df)))),
	project_num=rep(df$project_num, 6),
	multi_project=rep(df$mutli_project, 6),
	is_leave=rep(df$is_leave, 6))
	)
}


plot_sd=function(mon_mean, mon_sd, x_offset)
{
arrows(x_offset, mon_mean,
                x_offset, mon_mean-mon_sd, col=pal_col[2],
                length=0.1, angle=90, lwd=1.3)
arrows(x_offset, mon_mean,
                x_offset, mon_mean+mon_sd, col=pal_col[2],
                length=0.1, angle=90, lwd=1.3)
}


month_msd=function(df)
{
return(data.frame(month_mean=c(mean(df$hour1),
				mean(df$hour2),
				mean(df$hour3),
				mean(df$hour4),
				mean(df$hour5),
				mean(df$hour6)),
			month_sd=c(sd(df$hour1),
				sd(df$hour2),
				sd(df$hour3),
				sd(df$hour4),
				sd(df$hour5),
				sd(df$hour6)))
	)
}


mrhrs=read.csv(paste0(ESEUR_dir, "projects/WhoWillLeaveCompany.csv.xz"), as.is=TRUE)

# Remove what look like incorrect entries
mrhrs=subset(mrhrs, hour1 != 0)

# hrs=ddply(mrhrs, .(id), mk_long)

p1=subset(mrhrs, project_num == 1)
p2=subset(mrhrs, project_num == 2)

p1_mon=month_msd(p1)
p2_mon=month_msd(p2)

plot(0, type="n",
	xlim=c(1, 6), ylim=c(45, 210),
	xlab="Month", ylab="Project work (hours)\n")

x_range=1:6

lines(x_range-0.1, p1_mon$month_mean, col=pal_col[1])
d=sapply(1:6, function(X) plot_sd(p1_mon$month_mean[X], p1_mon$month_sd[X], X-0.1))

lines(x_range+0.1, p2_mon$month_mean, col=pal_col[1])
d=sapply(1:6, function(X) plot_sd(p2_mon$month_mean[X], p2_mon$month_sd[X], X+0.1))

# proj_1=subset(mrhrs, project_num == 1)
# 
# l_mod=glm(is_leave=="yes" ~
# 			# hour1+hour2+hour3+hour4+hour5+hour6+
# 			hour_sum+
# 			# hour_mean+
# 			hour_median+
# 			# hour_std+
# 			# hour_max+
# 			# task_len_sum+task_len_mean+
# 			# task_len_median+
# 			# task_len_std+task_len_max+
# 			task_zero+
# 			# token_sum+token_mean+
# 			# token_median+
# 			# token_std+
# 			# token_max+
# 			# flesch+smog+kincaid+
# 			# coleman_liau+automated_readability_index+
# 			# dale_chall+difficult_words+
# 			# linsear_write+gunning_fog+
# 			mutli_project+
# 			p1_person+
# 			I(p1_hour_mean/hour_mean)+
# 			# p1_hour_sum+p1_hour_std+
# 			# p1_person_change+
# 			# p2_person+
# 			I(p2_hour_mean/hour_mean)+
# 			# p2_hour_sum+p2_hour_std+
# 			p2_person_change+
# 			# p3_person+
# 			I(p3_hour_mean/hour_mean)+
# 			# p3_hour_sum+p3_hour_std+
# 			p3_person_change+
# 			# p4_person+
# 			I(p4_hour_mean/hour_mean)+
# 			# p4_hour_sum+p4_hour_std+
# 			p4_person_change+
# 			# p5_person+
# 			I(p5_hour_mean/hour_mean)+
# 			# p5_hour_sum+p5_hour_std+
# 			p5_person_change+
# 			# p6_person+
# 			I(p6_hour_mean/hour_mean)+
# 			# p6_hour_sum+
# 			p6_hour_std+
# 			p6_person_change+
# 			avg_person_change
# 			# +less_zero+equal_zero
# 			# +larger_zero
# 			, data=proj_1, family=binomial)
# summary(l_mod)
# 
