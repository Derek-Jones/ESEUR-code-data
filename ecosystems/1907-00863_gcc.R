#
# 1907-00863_gcc.R, 10 Jul 19
# Data from:
# Understanding {GCC} Builtins to Develop Better Tools
# Manuel Rigger and Stefan Marr and Bram Adams and Hanspeter M{\"o}ssenb{\"o}ck
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG GCC language_extension builtin

source("ESEUR_config.r")


library("plyr")


# totals for each project
count_builtin=function(df)
{
return(data.frame(unq_bi=length(unique(df$BUILTIN_ID)),
			num_bi=nrow(df),
			num_func=length(unique(df$file_num)),
			cloc=df$CLOC[1]))
}


# GITHUB_PROJECT_ID,BUILTIN_ID,CLOC,num_func
bi=read.csv(paste0(ESEUR_dir, "ecosystems/1907-00863_gcc.csv.xz"), as.is=TRUE)

# bi_cnt=ddply(bi, .(GITHUB_PROJECT_ID), count_builtin)
# 
# plot(bi_cnt$cloc, bi_cnt$num_bi, log="xy")
# plot(bi_cnt$unq_bi, bi_cnt$num_bi, log="xy")

# Below is trial and error, no theory
# loc_mod=glm(log(cloc) ~ log(num_bi)*log(unq_bi)+sqrt(num_func), data=bi_cnt)
# loc_mod=glm(log(cloc) ~ sqrt(num_func)*log(num_bi)-log(num_bi)+I(log(num_bi)^2), data=bi_cnt)
# summary(loc_mod)

# List of unique builtins used by each project
unique_bi=ddply(bi, .(GITHUB_PROJECT_ID), function(df)
				data.frame(bi=unique(df$BUILTIN_ID)))

# How many projects are supported, as builtins are implemented?
# A simple algorithm, which assumes the builtins most frequently used
# by projects are implemented first.
t=count(unique_bi$bi)
bi_freq=t$x[order(t$freq, decreasing=TRUE)]

cur_proj=length(unique(unique_bi$GITHUB_PROJECT_ID))
proj_supported=0

# Assume implemented one at a time, and count number of new projects that are
# now fully supported.
for (b_num in 1:length(bi_freq))
   {
   u_bi=subset(unique_bi, bi != bi_freq[b_num]) # implemented, so remove
   new_proj=length(unique(u_bi$GITHUB_PROJECT_ID))
   proj_supported=c(proj_supported, cur_proj-new_proj)
   unique_bi=u_bi
   cur_proj=new_proj
   }

proj_supported=tail(proj_supported, n=-1)

plot(cumsum(proj_supported), log="xy", col=point_col,
	xlab="Builtins implemented", ylab="Projects fully supported\n")



