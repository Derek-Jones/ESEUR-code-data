#
# qrs_2019_zou.R, 16 May 20
# Data from:
# Branch Use in Practice: {A} Large-Scale Empirical Study of 2,923 Projects on {GitHub}
# Weiqin Zou and Weiqiang Zhang and Xin Xia and Reid Holmes and Zhenyu Chen
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG version-control_branches

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)


br=read.csv(paste0(ESEUR_dir, "projects/qrs_2019_zou.csv.xz"), as.is=TRUE)

# plot( ~ log(branch_count)+log(developer_count)+log(project_size)+
# 				project_age+log(fork_count), data=br)
# 
# b_mod=glm(log(branch_count) ~ log(developer_count)+log(project_size), data=pd)
# summary(b_mod)

bc=count(br$branch_count)

plot(bc, log="xy", col=pal_col[2],
	xaxs="i",
	xlim=c(0.95, 70),
	xlab="Branches", ylab="Projects\n")


bf_mod=glm(log(freq) ~ log(x), data=bc,
				subset=(x > 1) & (x < 40))
summary(bf_mod)
pred=predict(bf_mod)

lines(2:39, exp(pred), col=pal_col[1])

