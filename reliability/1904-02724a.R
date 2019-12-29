#
# 1904-02724a.R, 27 Dec 19
# Data from:
# Bounties in Open Source Development on {GitHub}: {A} Case Study of Bountysource Bounties
# Jiayuan Zhou and Shaowei Wang and Cor-Paul Bezemer and Ying Zou and Ahmed E. Hassan
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG bounty_money-offered fault-report_bountry

source("ESEUR_config.r")


pal_col=rainbow(2)


bs=read.csv(paste0(ESEUR_dir, "reliability/1904-02724a.csv.xz"), as.is=TRUE)

bsr=subset(bs, isBackerReporter == "yes")
bsnr=subset(bs, isBackerReporter != "yes")
plot(sort(bsnr$I_B_total_value), type="l", log="y", col=pal_col[1],
	xaxs="i",
	xlab="Bounty ID", ylab="Amount offered ($)\n")

lines(sort(bsr$I_B_total_value), col=pal_col[2])
legend(x="topleft", legend=rev(c("Independent reporter/bounty offerer", "Issue reporter offered bounty")), bty="n", fill=rev(pal_col), cex=1.2)


# A fishing expedition explains 25% of variance
# bs_mod=glm(I_B_total_value ~ (I_B_cnt+isBackerReporter+I_B_has_label+sqrt(I_content_len_before)+
# 				I_code_percentage_before+I_link_cnt_before+
# 				P_B_total_value_before)^2, data=bs, family=poisson)
# 
# summary(bs_mod)

