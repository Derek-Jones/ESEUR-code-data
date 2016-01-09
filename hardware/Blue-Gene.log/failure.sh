#
# failure.sh, 14 Jun 11


function cnt_msg()
{
echo -n "$1  "
grep -c "$2" "$infile"
echo $2
}

infile=$1 						; export infile

cnt_msg 3394 "rts panic! - stopping execution"
cnt_msg 2175 "rts internal error"
cnt_msg 12629 "rts: kernel terminated"
cnt_msg 96 "Power deactivated:"
cnt_msg 406 "Error: unable to mount filesystem"
cnt_msg 2048 "Lustre mount FAILED"
cnt_msg 512 "Temperature Over Limit on link card"
cnt_msg 256 "Link PGOOD error latched on link card"
cnt_msg 47 "Power Good signal deactivated:"
cnt_msg 39 "MONITOR FAILURE While reading FanModule .*: Broken pipe"
cnt_msg 31 "MONITOR FAILURE While setting fan speed .*: Broken pipe"
cnt_msg 73 "MONITOR FAILURE monitor caught .*: Broken pipe and is stopping"
cnt_msg 18 "FATAL kernel panic"
cnt_msg 4 "power module status fault detected on node card"
cnt_msg 4 "Local PGOOD error latched on link card"
cnt_msg 5 "no ethernet link"
cnt_msg 7 "MidplaneSwitchController::.* pap failed:"
cnt_msg 1 "mmcs_server exited abnormally due to signal: Aborted"
cnt_msg 2 "monitor caught .*: power module .* not present and is stopping"
cnt_msg 2 "MidplaneSwitchController::.* iap failed:"
cnt_msg 1 "ciodb exited abnormally due to signal: Aborted"
cnt_msg 2 "rts assertion failed:"
cnt_msg 2 "L3 major internal error"
cnt_msg 1 "No power module .* found found on link card"
