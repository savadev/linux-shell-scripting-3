#!/bin/bash

# NAME
# 	run-everywhere.sh - execute arguments on multiple machines using SSH
#
# SYNOPSIS
# 	run-everywhere.sh [OPTIONS] COMMAND
#
# DESCRIPTION
# 	Execute arguments as a single command on each machine posted in the /vagrant/servers
#	file using SSH. It is recommended that this command NOT be run with superuser privileges.
#
#	-f	override default machine name file with file specified 
#
#	-n	performs trial run of command by printing instead of executing
#
#	-s	run command with superuser privileges on remote machines
#
#	-v	enable verbose mode: displays name of machine currently executing command

usage()
{
  echo 'Print usage stuff here' >&2
  exit 1
}

