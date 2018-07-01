#
# adelson1981.R, 12 May 18
# Data from:
# Problem solving and the development of abstract categories in programming languages
# Beth Adelson
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG experiment cognition memory-recall


source("ESEUR_config.r")


plot_layout(2, 1)


# Martix for holding the item pairwise distances
mk_item_mat=function()
{
item_mat=matrix(data=0, nrow=length(line_loc), ncol=length(line_loc))
colnames(item_mat)=line_loc
rownames(item_mat)=line_loc

return(item_mat)
}



# Calculate the distance between all pairs of items in a list
calc_dist=function(items)
{

   # Calculate distance between one item and all other items
   item_dist=function(X)
   {
   items=items[!is.na(items)]

   op_pos=which(items == X)
   # Missing items are given fixed distance from all other items
   if (length(op_pos) == 0)
      {
      recall_mat[cbind(rep(X, length(line_loc)), line_loc)] <<- item_na_len
      recall_mat[cbind(line_loc, rep(X, length(line_loc)))] <<- item_na_len
      recall_mat[X, X] <<- 0
      return(0)
      }
   
   dist_vec=abs(1:length(items) - op_pos)
   
   # print(c(X, dist_vec))
   
   recall_mat[cbind(rep(X, length(items)), items)] <<- dist_vec
   
   return(0)
   }

recall_mat=mk_item_mat()
d_mat=sapply(line_loc, item_dist)

return(recall_mat)
}


adel=read.csv(paste0(ESEUR_dir, "developers/adelson1981.csv.xz"), as.is=TRUE)

# Three programs and the lines they contain
line_loc=c("1_0", "1_1", "1_2", "1_3", "1_4",
		"2_0", "2_1", "2_2", "2_3", "2_4",
		"3_0", "3_1", "3_2", "3_3", "3_4", "3_5")
# Program statement kind.  This entry has no NAs
line_kind=adel$e7C[order(adel$e7p)]

# Seems as good a value as any other
item_na_len=length(line_loc)/2

teacher_dist=calc_dist(adel$e6p)
teacher_dist=teacher_dist+calc_dist(adel$e7p)
teacher_dist=teacher_dist+calc_dist(adel$e8p)
teacher_dist=teacher_dist+calc_dist(adel$e9p)
teacher_dist=teacher_dist+calc_dist(adel$e10p)

d_dist=dist(teacher_dist/5)
hc=hclust(d_dist)

plot(hc, main="Teachers", sub="", col=point_col,
	xlab="Items", ylab="")


student_dist=calc_dist(adel$n1p)
student_dist=student_dist+calc_dist(adel$n2p)
student_dist=student_dist+calc_dist(adel$n3p)
student_dist=student_dist+calc_dist(adel$n4p)
student_dist=student_dist+calc_dist(adel$n5p)

rownames(student_dist)=paste0(line_loc, "-", line_kind)

d_dist=dist(student_dist/5)
hc=hclust(d_dist)

plot(hc, main="Students", sub="", col=point_col,
	xlab="Items", ylab="")


