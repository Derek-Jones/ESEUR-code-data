#
# pull-req-corrg.R, 22 Aug 18
#
# Data from:
#
# Georgios Gousios and Andy Zaidman
# A Dataset for Pull Request Research
# Code below is a modified version of code supplied with the data.
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG pull-request development

source("ESEUR_config.r")


library("corrgram")

par(fin=c(4.0, 4.0))

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

# Cross correlation ellipses
ctab = cor(used, method = "spearman", use="complete.obs")


corrgram(ctab, upper.panel=panel.pie, lower.panel=panel.shade)


