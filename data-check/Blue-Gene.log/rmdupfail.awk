#
# rmdupfail.awk, 14 Jun 11

function add_pat(pat_str)
{
num_pat++
msg_pat[num_pat]=pat_str
}

BEGIN {
        num_pat=0
# List of "Failure Suggesting Message Patterns"
# patterns taken from file: patterns.tgz may available by
# the authors on the web site: ...
add_pat("rts panic! - stopping execution")
add_pat("rts internal error")
add_pat("rts: kernel terminated") 
add_pat("Power deactivated:") 
add_pat("Error: unable to mount filesystem")
add_pat("Lustre mount FAILED")
add_pat("Temperature Over Limit on link card")
add_pat("Link PGOOD error latched on link card")
add_pat("Power Good signal deactivated:")
add_pat("MONITOR FAILURE While reading FanModule .*: Broken pipe")
add_pat("MONITOR FAILURE While setting fan speed .*: Broken pipe")
add_pat("MONITOR FAILURE monitor caught .*: Broken pipe and is stopping")
add_pat("FATAL kernel panic")
add_pat("power module status fault detected on node card")
add_pat("Local PGOOD error latched on link card")
add_pat("no ethernet link")
add_pat("MidplaneSwitchController::.* pap failed:")
add_pat("mmcs_server exited abnormally due to signal: Aborted") 
add_pat("monitor caught .*: power module .* not present and is stopping")
add_pat("MidplaneSwitchController::.* iap failed:")
add_pat("ciodb exited abnormally due to signal: Aborted")
add_pat("rts assertion failed:")
add_pat("L3 major internal error")
add_pat("No power module .* found found on link card")
        }


function get_loc()
{
split($2, full_loc, ":")
# loc_str assigned on the when awk is invoked
if (loc_str == "any")
   return "any"
if (loc_str == "full")
   return $2
if (loc_str == "1st")
   return full_loc[1]
#return full_loc[2]
}


function new_msg()
{
print $0
# Save pattern because it may be less unique than the message matched
location[cur_loc]=cur_msg_pat
msg_time[cur_loc]=cur_time_str
}

	{
	cur_msg=$3
	for (i=4; i <= NF; i++)
	   cur_msg=cur_msg " " $i
	cur_msg_pat=""
# Is this one of the Fail messages of interest?
        for (p in msg_pat)
           if (match(cur_msg, msg_pat[p]))
              {
              cur_msg_pat=msg_pat[p]
              break
              }
	if (cur_msg_pat == "")
	   next
# Yes, get failure location and failure time
	cur_loc=get_loc()
	# Ignore fractions of second
	cur_time_str=substr($1, 1, 4) " " substr($1, 6, 2) " " substr($1, 9, 2) \
		  " " substr($1,12, 2) " " substr($1, 15, 2) " " substr($1, 18, 2)
	}

# Have we seen this message pattern at this location before?
location[cur_loc] == cur_msg_pat {
	cur_secs=mktime(cur_time_str)
	last_secs=mktime(msg_time[cur_loc])
#print $1 "  " cur_loc "  " msg_time[cur_loc]
#print "> " cur_secs-last_secs
	if (last_secs+time_int < cur_secs)
	   new_msg()
	else
	   msg_time[cur_loc]=cur_time_str
	next
	}

# Not seen before
	{
	new_msg()
	next
	}

