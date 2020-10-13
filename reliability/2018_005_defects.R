#
# 2018_005_defects.R, 21 Sep 20
# Data from:
# Composing Effective Software Security Assurance Workflows
# William R. Nichols and James D. McHale and David Sweeney and William Snavely and Aaron Volkman
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG project_phases project_mistakes mistake_costs mistake_time

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(2)


# Number of phases between Creation and Discovery phase
phase_dist=function(Cp, Dp, phases)
{
return(match(Dp, phases)-match(Cp, phases))
}

# phase_dist("HLD", "Compile")


# Map related phases to 'main' phase
merge_phases=function(df, phases)
{
df$injected_phase_name[df$injected_phase_name %in% phases]=phases[1]
df$removed_phase_name[df$removed_phase_name %in% phases]=phases[1]

return(df)
}


fit_line=function(df, min_fix_time)
{
# Require at least a minute to fix a problem
df=subset(df, defect_fix_time_minutes >= min_fix_time)

# lines(loess.smooth(df$dist, df$value, span=0.8), col=loess_col)

x_bounds=0:20
ct_mod=glm(log(defect_fix_time_minutes) ~ I(phase_dist^0.5), data=df)
pred=predict(ct_mod, newdata=data.frame(phase_dist=x_bounds))

lines(x_bounds, exp(pred), col=pal_col[1])

text(2.5, exp(pred[2]), min_fix_time)

return(ct_mod)
}


# Time to fix a mistake, broken down by Create/Discover
phase_fix_time=function(df, phase_order)
{
# Number of phases between inject/detected
df$phase_dist=phase_dist(df$injected_phase_name, df$removed_phase_name, phase_order)
# df=subset(df, dist >= 0)

plot(df$phase_dist, df$defect_fix_time_minutes, log="y", col=pal_col[2],
	xlab="Phase separation", ylab="Fix time (minutes)\n")

t=fit_line(df, 1)

# print(t)
}


fix_order=function(df)
{
df$fix_num=NA
df$fix_num[order(df$found_date)]=1:nrow(df)
return(df)
}


df=read.csv(paste0(ESEUR_dir, "reliability/2018_005_defects.csv.xz"), as.is=TRUE)
df$found_date=as.Date(df$defect_found_date, format="%m/%d/%Y")

# Phase order for Organization A (not all phases included)
Ident_seq=c("Ident", "Ident Inspect")
Reqts_seq=c("Reqts", "Reqts Review", "Reqts Inspect")
HLD_seq=c("HLD", "HLD Review", "HLD Inspect")
Design_seq=c("Design", "Design Review", "Design Inspect")
Code_seq=c("Code", "Code Review", "Compile", "Code Inspect")
Test_seq=c("Unit Test", "Int Test", "Test")

all_phase_order=c(Ident_seq,
		Reqts_seq,
		HLD_seq,
		Design_seq,
		"Test Devel",
		Code_seq,
		Test_seq,
		"IT", "Product Life")

main_phase_order=c(Ident_seq[1],
		Reqts_seq[1],
		HLD_seq[1],
		Design_seq[1],
		"Test Devel",
		Code_seq[1],
		Test_seq[1],
		"IT", "Product Life")

phases_before_code=c(Ident_seq,
                Reqts_seq,
                HLD_seq,
                Design_seq,
		"Before Development")

# How many fault are made before coding?
# bc=subset(df, injected_phase_name %in% phases_before_code)
# 100*nrow(bc)/nrow(df)

# The largest project, also the one with the most defects
d615=subset(df, project_key == 615)

def_615=subset(d615, (injected_phase_name %in% all_phase_order) &
			(removed_phase_name %in% all_phase_order))
def_615$injected_phase_num=as.integer(mapvalues(def_615$injected_phase_name,
				all_phase_order, 1:length(all_phase_order)))
def_615$removed_phase_num=as.integer(mapvalues(def_615$removed_phase_name,
				all_phase_order, 1:length(all_phase_order)))

mdef_615=merge_phases(merge_phases(
		merge_phases(merge_phases(
		merge_phases(merge_phases(def_615, Ident_seq), Reqts_seq),
						HLD_seq), Design_seq),
						Code_seq), Test_seq)
mdef_615$injected_phase_num=as.integer(mapvalues(mdef_615$injected_phase_name,
				main_phase_order, 1:length(main_phase_order)))
mdef_615$removed_phase_num=as.integer(mapvalues(mdef_615$removed_phase_name,
				main_phase_order, 1:length(main_phase_order)))

# phase_fix_time(def_615, all_phase_order)
# phase_fix_time(mdef_615, main_phase_order)


t=ddply(mdef_615, .(person_key), fix_order)
# Require that individuals make a minimum number of fixes
p615=ddply(t, .(person_key),
			function(df)
			if (max(df$fix_num) > 20) return(df)
					else return(NULL))

p615$phase_dist=phase_dist(p615$injected_phase_name, p615$removed_phase_name,
							main_phase_order)
plot(p615$phase_dist, p615$defect_fix_time_minutes, log="y", col=pal_col[2],
	ylim=c(1, 1000),
        xlab="Phase separation", ylab="Fix time (minutes)\n")

# lines(loess.smooth(p615$dist, p615$value, span=0.8), col=loess_col)


t=fit_line(p615, 1)
t=fit_line(p615, 5)
t=fit_line(p615, 10)
# summary(t)
# 
# df=subset(p615, defect_fix_time_minutes >= 5)
# 
# ct_mod=glm(log(defect_fix_time_minutes) ~ I(phase_dist^0.5)+log(fix_num)+factor(person_key), data=df)
# summary(ct_mod)


# def_615$phase_dist=phase_dist(def_615$injected_phase_name, def_615$removed_phase_name, phase_order)
# table(def_615$phase_dist)

