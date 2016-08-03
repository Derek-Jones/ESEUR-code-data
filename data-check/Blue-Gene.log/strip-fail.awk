#
# strip-fail.awk, 13 Jun 11

function add_pat(pat_str)
{
num_pat++
msg_pat[num_pat]=pat_str
}

BEGIN {
	num_pat=0
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

	{
	# strip off any characters appearing after message template
	for (p in msg_pat)
	   if (match($0, msg_pat[p], new_msg))
	      {
	      print substr($0, 1, RSTART+RLENGTH-1)
	      next
	      }
#	print $0
	next
	}

