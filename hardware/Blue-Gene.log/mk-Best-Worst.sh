#
# mk-Best-Worst.sh, 14 Jun 11

# grep -E "FATAL|FAILURE" event_log-bgl | awk -f strip4.awk > all.FF

awk -f strip-fail.awk < all.FF > Best.all-fail
awk -f rmdupfail.awk -v time_int=600 -v loc_str=any < all.FF > Best.any-loc
awk -f rmdupfail.awk -v time_int=600 -v loc_str=full < all.FF > Best.full-loc
awk -f rmdupfail.awk -v time_int=600 -v loc_str=1st < all.FF > Best.1st-loc

awk -f rmdupundet.awk -v time_int=600 -v loc_str=any < all.FF > Undet.any-loc
awk -f rmdupundet.awk -v time_int=600 -v loc_str=full < all.FF > Undet.full-loc
awk -f rmdupundet.awk -v time_int=600 -v loc_str=1st < all.FF > Undet.1st-loc

