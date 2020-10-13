#
# SiP-team-dev.R, 15 Sep 20
# Data from:
# Composing Effective Software Security Assurance Workflows
# William R. Nichols and James D. McHale and David Sweeney and William Snavely and Aaron Volkman
# A conversation around the analysis of the {SiP} effort estimation dataset
# Derek M. Jones and Stephen Cullum
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG Agile_tasks team_size Agile_team inspection_code inspection_design test_team

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(5)


team_size=function(phase_str, col_str)
{
ph=subset(tf, phase_short_name == phase_str)
team_size=count(count(ph$plan_item_key)$freq)

points(team_size, type="b", col=col_str)
}

# project_key     foreign key, unique project ID
# person_key      foreign key, unique developer ID
# team_key        foreign key, unique team ID
# wbs_element_key foreign key, unique work breakdown structure element ID
# plan_item_key   foreign key, unique  ID for the planned item associated with the task
# task_actual_start_date  time stamp for first work on task
# task_actual_complete_date       time stame when task was completed
# task_actual_time_minutes        total effort actually logged for the task
# task_plan_time_minutes  total effort planned for the task
# phase_key       unique key for the process phase in which the task work was done
# phase_short_name        readable name for process workflow phase
# process_name    readable name for process workflow
tf=read.csv(paste0(ESEUR_dir, "projects/2018_005_tf.csv.xz"), as.is=TRUE)

# tf=subset(tf, year >= 2010) # remove 2008 'mistake'

Sip_all=read.csv(paste0(ESEUR_dir, "projects/Sip-task-info.csv.xz"), as.is=TRUE)

# Removed the 190 tasks that were cancelled before completion
Sip=subset(Sip_all, StatusCode != "CANCELLED")
# Single instance of this in the data
Sip=subset(Sip, StatusCode != "TEMPLATE")
# Projects that were not completed at the time of the data snapshot
Sip=subset(Sip, StatusCode != "CHRONICLE")

devs=count(Sip$DeveloperID)
plot(sort(devs$freq, decreasing=TRUE), type="b", log="y", col=pal_col[5],
	yaxs="i",
	xlim=c(1, 20), ylim=c(1, 1e4),
        xlab="Developers", ylab="Tasks\n")


# These four phases are common and 'well-known'
phase_str=c("Code Inspect", "Design Inspect", "Code", "Test")
team_size(phase_str[1], pal_col[1])
team_size(phase_str[2], pal_col[2])
team_size(phase_str[3], pal_col[3])
team_size(phase_str[4], pal_col[4])

legend(x="topright", legend=c(phase_str, "SiP task"), bty="n", fill=pal_col, cex=1.2)


