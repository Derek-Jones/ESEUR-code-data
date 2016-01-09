#
# mediawiki.R, 26 Dec 15
#
# Data from:
# Schema evolution in wikipedia toward a Web Information System Benchmark
# Carlo A. Curino and Hyun J. Moon and Letizia Tanca and Carlo Zaniolo
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 2)

col_tab=read.csv(paste0(ESEUR_dir, "maintenance/wiki-schema/col_tab_growth.csv.xz"), as.is=TRUE)
# cur_release,days_difference,days_since_start
ver_days=read.csv(paste0(ESEUR_dir, "maintenance/wiki-schema/ver-date-diff.csv.xz"), as.is=TRUE)


# Excluded modifications that did not change the col/table total
col_change=col_tab[(col_tab$col_added != 0) | (col_tab$col_deleted != 0),]
table_change=col_tab[(col_tab$table_added != 0) | (col_tab$table_deleted != 0),]

col_change_days=ver_days$days_since_start[(col_tab$col_added != 0) | (col_tab$col_deleted != 0)]
table_change_days=ver_days$days_since_start[(col_tab$table_added != 0) | (col_tab$table_deleted != 0)]

# Plot by elapsed days
plot(col_change_days, col_change$col_total, col=point_col,
	xlab="", ylab="Total columns\n")
plot(table_change_days, table_change$table_total, col=point_col,
	xlab="Days since start", ylab="Total tables")

# Plot by version number
plot(col_change$file, col_change$col_total, col=point_col,
	xlab="", ylab="")
plot(table_change$file, table_change$table_total, col=point_col,
	xlab="Checked in version", ylab="")

# col_tab_change=col_tab[(col_tab$col_added != 0) | (col_tab$col_deleted != 0) |
#                        (col_tab$table_added != 0) | (col_tab$table_deleted != 0),]
# col_tab_days=ver_days[(col_tab$col_added != 0) | (col_tab$col_deleted != 0) |
#                       (col_tab$table_added != 0) | (col_tab$table_deleted != 0),]
# plot(col_tab_change$file, col_tab_change$col_total/col_tab_change$table_total, xlab="Checked in version", ylab="Rows/Tables")
# plot(col_tab_days$days_since_start, col_tab_change$col_total/col_tab_change$table_total, xlab="Days since start", ylab="Rows/Tables")

