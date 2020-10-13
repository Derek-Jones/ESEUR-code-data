#
# 2018_005_est.R, 25 Aug 20
# Data from:
# Composing Effective Software Security Assurance Workflows
# William R. Nichols and James D. McHale and David Sweeney and William Snavely and Aaron Volkman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


library("lubridate")
library("plyr")   


pal_col=rainbow(4)


planned_actual=function(p_time)
{
p30=subset(tf, task_plan_time_minutes == p_time)
cnt_p30=count(p30$task_actual_time_minutes)

plot(cnt_p30, type="b", log="xy")
}

model_phase=function(df, phase_str, col_num)
{
ci=subset(df, phase_short_name == phase_str)
points(ci$task_plan_time_minutes, ci$task_actual_time_minutes, col=pal_col[col_num])

# tf_mod=glm(log(task_actual_time_minutes) ~ log(task_plan_time_minutes)+factor(person_key),
tf_mod=glm(log(task_actual_time_minutes) ~ log(task_plan_time_minutes),
                        subset=(task_plan_time_minutes!=0), data=ci)
print(summary(tf_mod))

x_bounds=1:5000
pred=predict(tf_mod, newdata=data.frame(task_plan_time_minutes=x_bounds))
lines(x_bounds, exp(pred))
text(10, 5000, phase_str)
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

tf$start_date=as.Date(tf$task_actual_start_date, format="%m/%d/%Y")
tf$end_date=as.Date(tf$task_actual_complete_date, format="%m/%d/%Y")

plot(tf$task_actual_time_minutes, tf$task_plan_time_minutes, log="xy")

tf_mod=glm(log(task_actual_time_minutes) ~ log(task_plan_time_minutes)+factor(person_key)+factor(team_key)+phase_key,
			subset=(task_plan_time_minutes!=0), data=tf)
summary(tf_mod)

# planned_actual(30)
# planned_actual(60)


p615=subset(tf, project_key == 615)

plot(p615$task_plan_time_minutes, p615$task_actual_time_minutes, log="xy")

plot_layout(2, 2)

plot(type="n", p615$task_plan_time_minutes, p615$task_actual_time_minutes, log="xy",
	xlim=c(1, 5000), ylim=c(1, 5000),
	xlab="Planned time (minutes)", ylab="Actual time (minutes)\n")

model_phase(p615, "HLD Inspect", 1)
plot(type="n", p615$task_plan_time_minutes, p615$task_actual_time_minutes, log="xy",
	xlim=c(1, 5000), ylim=c(1, 5000),
	xlab="Planned time (minutes)", ylab="Actual time (minutes)\n")
model_phase(p615, "Reqts Inspect", 2)
plot(type="n", p615$task_plan_time_minutes, p615$task_actual_time_minutes, log="xy",
	xlim=c(1, 5000), ylim=c(1, 5000),
	xlab="Planned time (minutes)", ylab="Actual time (minutes)\n")
model_phase(p615, "Design Inspect", 3)
plot(type="n", p615$task_plan_time_minutes, p615$task_actual_time_minutes, log="xy",
	xlim=c(1, 5000), ylim=c(1, 5000),
	xlab="Planned time (minutes)", ylab="Actual time (minutes)\n")
model_phase(p615, "Code Inspect", 4)

