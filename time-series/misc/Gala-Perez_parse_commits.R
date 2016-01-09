#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#!/usr/bin/Rscript --save
# R process for a project
projects<-c("httpd", "apr", "spamassassin", "turbine", "tomcat", "geronimo", "hadoop", "avro", "hbase", "hive", "pig", "lucene", "beehive", "felix", "jackrabbit", "portals", "sling") # TODO more?
f<-function(filename) {
    print(filename)
    proj=read.csv(file=filename) # created a data frame with info
    proj$start<-I(c(proj$year[proj$commits!=0][1], proj$month[proj$commits!=0][1]))
    proj$end  <-I(c( max(proj$year[proj$commits!=0]),
                     max(proj$month[proj$commits!=0 & proj$year==max(proj$year[proj$commits!=0])])))
    proj1<-data.frame(
                total   = window(x=ts(proj$total  ,frequency=12,start=c(proj$year[1],1)),start=proj$start[1:2],end=proj$end[1:2]),
                commits = window(x=ts(proj$commits,frequency=12,start=c(proj$year[1],1)),start=proj$start[1:2],end=proj$end[1:2]),
                devel   = window(x=ts(proj$devel  ,frequency=12,start=c(proj$year[1],1)),start=proj$start[1:2],end=proj$end[1:2]),
                issues  = window(x=ts(proj$issues ,frequency=12,start=c(proj$year[1],1)),start=proj$start[1:2],end=proj$end[1:2]),
                user   = window(x=ts(proj$user    ,frequency=12,start=c(proj$year[1],1)),start=proj$start[1:2],end=proj$end[1:2]),
                year   = window(x=ts(proj$year    ,frequency=12,start=c(proj$year[1],1)),start=proj$start[1:2],end=proj$end[1:2]),
                month   = window(x=ts(proj$month    ,frequency=12,start=c(proj$year[1],1)),start=proj$start[1:2],end=proj$end[1:2])
                )
    #print(proj1)
    proj1$start  = proj$start[1:nrow(proj1)]
    proj1$end    = proj$end[1:nrow(proj1)]

    #print(proj1$start)
    #print(proj1$end)
    # proj1$commits[proj1$commits==0]=NA
    # na.contiguous(httpd$total/httpd$commits)
    proj1$tc<-ts(proj1$total/proj1$commits, frequency=12,start=proj1$start,end=proj1$end)
    proj1$dc<-ts(proj1$devel/proj1$commits, frequency=12,start=proj1$start,end=proj1$end)
    proj1$tb<-ts(proj1$total/proj1$issues, frequency=12,start=proj1$start,end=proj1$end)
    proj1$db<-ts(proj1$devel/proj1$issues, frequency=12,start=proj1$start,end=proj1$end)
    proj1$bc<-ts(proj1$issues/proj1$commits, frequency=12,start=proj1$start,end=proj1$end)
    lc <- loess(commits ~ x, data.frame(commits=proj1$commits, x=1:length(proj1$commits) ), span=0.50)
    lt <- loess(total ~ x, data.frame(total=proj1$total, x=1:length(proj1$total) ), span=0.50)
    ld <- loess(devel ~ x, data.frame(devel=proj1$devel, x=1:length(proj1$devel) ), span=0.50)
    li <- loess(issues ~ x, data.frame(issues=proj1$issues, x=1:length(proj1$devel) ), span=0.50)
    proj1$ltc<-ts(lt$fitted/lc$fitted, frequency=12,start=proj1$start)
    proj1$ldc<-ts(ld$fitted/lc$fitted, frequency=12,start=proj1$start)
    proj1$lic<-ts(li$fitted/lc$fitted, frequency=12,start=proj1$start)
    proj1
}

for(p in projects) {
    #print(p)
    assign(p,f(paste('mails-',p,'.csv',sep='')))
}

#hadoop ecosystem
#avro$commits<-window(ts(avro$commits,frequency=12,start=avro$start),start=hadoop$start[1], extend=TRUE)

#pdf()
#ts.plot(httpd$ts,tomcat$ts,lucene$ts,beehive$ts,hadoop$ts,felix$ts,jackrabbit$ts,sling$ts, col=1:10, lty=1:10, ylim=20)
#legend(x="top",legend=projects,lty=1:length(projects),col=1:length(projects))
