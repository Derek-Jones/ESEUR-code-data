#
# hemmati2018.R, 26 Oct 20
#
# Data from:
# Utilizing Product Usage Data for Requirements Evaluation
# Ashkan Hemmati and S. M. Didar Al Alam and Chris Carlson
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_tasks task_estimate

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)

id=read.csv(paste0(ESEUR_dir, "projects/hemmati2018.csv.xz"), as.is=TRUE)

id$dateC=as.Date(id$Created, format="%d/%m/%Y")
id$dateR=as.Date(id$Resolved, format="%d/%m/%Y")

plot(id$Original.Estimate, id$Time.Spent, log="xy")

plot(id$dateR-id$dateC, id$Time.Spent,log="xy")

idt=subset(id, Time.Spent > 0)

# ts_mod=glm(log(Time.Spent) ~ (log(Original.Estimate)+Issue.Type)^2, data=idt)
# summary(ts_mod)

oe=count(id$Original.Estimate/60)

plot(oe, log="xy", las=1, bty="l", col=pal_col[2],
	xlab="Estimate (minutes)", ylab="Tasks\n")
text(1, 60, "1", col=pal_col[1])
text(2, 11, "2", col=pal_col[1])
text(5, 20, "5", col=pal_col[1])
text(10, 10, "10", col=pal_col[1])
text(15, 22, "15", col=pal_col[1])
text(30, 80, "30", col=pal_col[1])
# text(50, 90, "50", col=pal_col[1])
text(90, 35, "90", col=pal_col[1])
text(150, 25, "150", col=pal_col[1])
# text(200, 20, "5", col=pal_col[1])

text(60*1, 250, "1 hr", col=pal_col[1])
text(60*2, 250, "2 hr", col=pal_col[1])
text(60*3, 100, "3 hr", col=pal_col[1])
text(60*4, 170, "4 hr", col=pal_col[1])
text(60*5, 25, "5 hr", col=pal_col[1])
text(60*6, 40, "6 hr", col=pal_col[1])
text(60*8, 80, "1 day", col=pal_col[1])
# text(60*15, 20, col=pal_col[1])
text(60*8*2, 35, "2 days", col=pal_col[1])
text(60*8*3, 10, "3 days", col=pal_col[1])
text(60*8*5, 5.5, "5 days", col=pal_col[1])

