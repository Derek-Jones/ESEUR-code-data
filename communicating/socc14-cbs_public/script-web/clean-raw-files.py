#!/usr/bin/python

import os,sys,re
import operator

SYSTEMS = ["cassandra", "hbase", "hdfs", "flume", "mapreduce", 'zookeeper']
tagcode = ["kb-","ll-","dc-","sc-","dr-", "mc-"]
valid_tags = []
raw_path = "../../raw"
output_path = "../raw-web"
lines = []

def validtags():
	raw_tags = open('valid-tags.txt')
	for line in raw_tags:
		line = line.split('\n', 1)[0]
		if not line[:1] == "#" and not len(line.strip()) == 0:
			valid_tags.append(line)

def read(system):
	taglist = tuple(valid_tags)
	raw_file = open(raw_path+'/'+system+'.txt')
	for line in raw_file:
		if line.find('[') == 0:
			lines.append(line)
		if (not line.startswith(' ') and line.startswith(taglist)):
			lines.append(prefix_match(line, taglist))

def prefix_match(line, taglist):
	for element in taglist:
		if line.startswith(element):
			return element

def write(system):
	output = open(output_path+'/'+system+'.txt', 'w')
	for line in lines:
		if line.find('[') == 0:
			output.write('\n'+line)
		else:
			output.write(line+'\n')

def main():
	"""1. Read valid tags"""
	print "parse valid-tags.txt...."
	validtags()
	for system in SYSTEMS:
		print "Cleaning "+system+"...."
		"""2. parse system and filter"""
		read(system)
		"""3. create file"""
		write(system)
		lines[:] = []

	print "Done."
if __name__ == '__main__':
	main()