#
# pull-req-hclus.R,  4 Mar 20
#
# Data from:
# Georgios Gousios and Andy Zaidman
# A Dataset for Pull Request Research
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# Evidence-based Software Engineering: based on the publicly available data
#
# TAG change-control pull-requests


source("ESEUR_config.r")


library("dendextend")


par(mar=MAR_default+c(7, 0, 0, 0))


homebrew_req=read.csv(paste0(ESEUR_dir, "communicating/pull-homebrew.csv.xz"), as.is=TRUE)

# cor requires numeric columns
columns = c("lifetime_minutes", "mergetime_minutes",
            "num_commits", "src_churn", "test_churn",
            "files_added", "files_deleted",
            "files_modified", "files_changed",
	    "src_files", "doc_files", "other_files",
            "num_commit_comments", "num_issue_comments","num_comments",
            "num_participants",
            "sloc", "team_size",
            "perc_external_contribs", "commits_on_files_touched",
            "test_lines_per_kloc", "test_cases_per_kloc", "asserts_per_kloc",
            "watchers",
            "prev_pullreqs", "requester_succ_rate", "followers")

used = subset(homebrew_req, select=columns)

# Cross correlation
ctab = cor(used, method = "spearman", use="complete.obs")

pull_dist=as.dist((1-ctab)^2)
t=as.dendrogram(hclust(pull_dist), hang=0.2)
col_pull=color_labels(t, k=5)
col_pull=color_branches(col_pull, k=2)
plot(col_pull, main="", sub="", col=point_col,
	xlab="", ylab="Height\n")

mtext("Pull related variables", side=1, padj=14, cex=0.7)

# A packaged way of doing things
# library("Hmisc")
# 
# p=varclus(~ (lifetime_minutes+mergetime_minutes
#		+num_commits+src_churn+test_churn
#		+files_added+files_deleted
#		+files_modified+files_changed
#		+src_files+doc_files+other_files
#		+num_commit_comments+num_issue_comments
#		+num_participants
#		+sloc+team_size
#		+perc_external_contribs+commits_on_files_touched
#		+test_lines_per_kloc+test_cases_per_kloc+asserts_per_kloc
#		+watchers
#		+prev_pullreqs+requester_succ_rate+followers),
# 		similarity="spearman",
# 		data = used)
#  
# plot(p)


