    private static Date correctTimeZone(final Date date) {
       Date ret=date;
       if(java.util.TimeZone.getDefault().useDaylightTime()){
            if(java.util.TimeZone.getDefault().inDaylightTime(date))
                ret.setTime(date.getTime()+1*60*60*1000);
        }
        return ret;
