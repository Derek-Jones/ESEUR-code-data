#
# pone-0157104.R, 18 Aug 17
# Data from:
# Dynamic Staffing and Rescheduling in Software Project Management: {A} Hybrid Approach
# Yujia Ge and Bin Xu
# Table 4
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plan")


gantt=read.csv(paste0(ESEUR_dir, "projects/pone-0157104.csv.xz"), as.is=TRUE)

# I'm guessing that the year is 2012 (earliest date in the XML file)
gantt$Start_Date=as.Date(paste0("2012 ", gantt$Start_Date), format="%Y %b %e")
gantt$End_Date=as.Date(paste0("2012 ", gantt$End_Date), format="%Y %b %e")

g_chart=as.gantt(key=gantt$Task_ID, description=gantt$Resource,
			start=gantt$Start_Date, end=gantt$End_Date)

plot(g_chart, col.notdone="yellow")

