#
# timediff.sh, 25 Jun 11

awk -f timediff.awk -v read_write=read < ukpew-disk-activity | ./timediff > read.diff
awk -f timediff.awk -v read_write=write < ukpew-disk-activity | ./timediff > write.diff

