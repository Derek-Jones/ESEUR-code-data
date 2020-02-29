#
# obj_use.R, 27 Feb 20
# Data from:
# The New C Standard: An Economic and Cultural Commentary
# Derek M. Jones
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG C variable_read variable_write function_variable-use

source("ESEUR_config.r")


library("plyr")

plot_layout(2, 1)


plot_points=function(df, t_lty)
{
lines(df$objects, df$occurrences, col=df$col_str[1], lty=t_lty)
}


ext_int_loc=function(df, x_str)
{
pal_col=rainbow(3)
df$col_str[grepl("loc_", df$use)]=pal_col[1]
df$col_str[grepl("ext_", df$use)]=pal_col[2]
df$col_str[grepl("int_", df$use)]=pal_col[3]

acc=subset(df, subset=grepl("_access", df$use))
mod=subset(df, subset=grepl("_modify", df$use))

plot(0.5, type="n", log="y",
	xaxs="i", yaxs="i",
	xlim=c(0, 50), ylim=c(1, 1e5),
	xlab=x_str, ylab="Functions\n")

legend(x="topright", legend=c("Function", "External", "File"), bty="n", fill=pal_col, cex=1.2)

d_ply(acc, .(use), plot_points, 1)
d_ply(mod, .(use), plot_points, 2)
}


# ext - external linkage, e.g., extern
# int - internal linkage, e.g., static
# loc - locals (technically no linkage)
# ind references to the same object (cannot remember what ind means)
ou=read.csv(paste0(ESEUR_dir, "sourcecode/obj_use.csv.xz"), as.is=TRUE)

tot_use=subset(ou, subset=!grepl("^ind_", ou$use))
ind_use=subset(ou, subset=grepl("^ind_", ou$use))
loc_use=subset(ou, subset=grepl("loc_", ou$use))

ext_int_loc(ind_use, "References to same variable")
ext_int_loc(tot_use, "References to all variable")


