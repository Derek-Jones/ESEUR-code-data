#
# warning-lifetime.R,  5 May 14
#
# Data from:
# The Life and Death of Statically Detected Vulnerabilities: an Empirical Study
# Massimiliano Di Penta and Luigi Cerulo and Lerina Aversano
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")

library("survival")


pal_col=rainbow(2)
plot_layout(1, 2)


get_prog_hist=function(prog_str)
{
prog_hist=read.csv(paste0(ESEUR_dir, "faults/tool-rep/", prog_str), as.is=TRUE)

# Extract and order by SNAPSHOT so we can lookup TIMESTAMP
prog_hist=subset(prog_hist, TOOL == "Splint")
prog_hist=prog_hist[order(prog_hist$SNAPSHOT), ]

# Zero base and convert to days
prog_hist$TIMESTAMP=(prog_hist$TIMESTAMP-min(prog_hist$TIMESTAMP))/(60*60*24)

return(prog_hist)
}


plot_surv=function(df, tool_hist, prog_str, col_str)
{
max_end=max(tool_hist$TIMESTAMP)
df_event=!is.na(df$END)
df$START=tool_hist$TIMESTAMP[df$START]
df$END=tool_hist$TIMESTAMP[df$END]

df_surv=Surv(df$END-df$START, df_event)

df_mod=survfit(df_surv ~1)

plot(df_mod, col=col_str,
	xlim=c(0, 1000),
	xlab="Days since created")
text(600, 0.8, prog_str)
}

plot_categ=function(df, tool_hist, prog_str)
{
splint_mem=subset(df, CATEG == "Memory Problem")
splint_type=subset(df, CATEG == "Type Mismatch")
plot_surv(splint_mem, tool_hist, prog_str, pal_col[1])
par(new=TRUE)
plot_surv(splint_type, tool_hist, prog_str, pal_col[2])

legend(x="topright", legend=c("Memory problem", "Type mismatch"),
			bty="n", fill=pal_col, cex=1.3)
}


splint_rep=read.csv(paste0(ESEUR_dir, "faults/tool-rep/splint.csv.xz"), as.is=TRUE)

splint_samba=subset(splint_rep, SYSTEM == "samba")
splint_squid=subset(splint_rep, SYSTEM == "squid")

samba_hist=get_prog_hist("Samba-hist.csv.xz")
squid_hist=get_prog_hist("Squid-hist.csv.xz")

# plot_surv(splint_samba, samba_hist, pal_col[1])
# par(new=TRUE)
# plot_surv(splint_squid, squid_hist, pal_col[2])


plot_categ(splint_samba, samba_hist, "Samba\n")
plot_categ(splint_squid, squid_hist, "Squid\n")

