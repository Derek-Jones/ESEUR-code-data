#
# mk-surv-list.R, 22 Dec 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("survival")


pal_col=rainbow(2)

API=read.csv(paste0(ESEUR_dir, "survival/ETP/Survival-ETP-API.csv.xz"),
		header=FALSE, as.is=TRUE)
nonAPI=read.csv(paste0(ESEUR_dir, "survival/ETP/Survival-ETP-nonAPI.csv.xz"),
		header=FALSE, as.is=TRUE)


gen_dead_list=function(cohort, API_status, start_year, end_year)
{
dead_list=NULL

for (y in 1:7)
   {
   new_row=data.frame(start_year, end_year[y], API_status, 0)
#print(new_row)
   names(new_row)=c("year_start", "year_end", "API", "survived")
#print(c(y, cohort[y]))
   dead_list=rbind(dead_list, new_row[rep(1, cohort[y]), ])
#print(c(str(dead_list), cohort))
   }

new_row=data.frame(start_year, 2010, API_status, 1)
names(new_row)=c("year_start", "year_end", "API", "survived")
dead_list=rbind(dead_list, new_row[rep(1, cohort[8]), ])

return(dead_list)
}


gen_surv_list=function(app_info, API_status)
{
end_year=app_info[1, ]
app_status=NULL

for (y in 2:9)
   app_status=rbind(app_status, gen_dead_list(app_info[y, ], API_status,
					      app_info[1, y-1]-1, end_year))

return(app_status)
}


app_API=gen_surv_list(API, 1)
app_nonAPI=gen_surv_list(nonAPI, 0)

all_api=rbind(app_API, app_nonAPI)

write.csv(all_api, paste0(ESEUR_dir, "survival/ETP/ETP-all-rel.csv.xz"),
		row.names=FALSE)
write.csv(all_api, paste0(ESEUR_dir, "survival/ETP/ETP-all-bld.csv.xz"),
		row.names=FALSE)

api_surv=Surv(app_API$year_end-app_API$year_start,
		 event=app_API$survived == 0, type="right")
api_mod=survfit(api_surv ~ 1)

nonapi_surv=Surv(app_nonAPI$year_end-app_nonAPI$year_start,
		 event=app_nonAPI$survived == 0, type="right")
nonapi_mod=survfit(nonapi_surv ~ 1)

plot(api_mod, xlim=c(0,7), xlab="Years", col=pal_col[1])

lines(nonapi_mod, col=pal_col[2])

api_diff=survdiff(Surv(year_end-year_start,
			event=survived == 0, type="right") ~ API, data=all_api)


