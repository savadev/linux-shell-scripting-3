#!/bin/bash

# This script allows a local account to be locked, deleted, and/or archived
# Usage: disable-local-user.sh [-dra] USER_NAME [USER_NAME]...
# - Disables/locks accounts by default
# - Accounts will be deleted with -d
# - Home directories will be removed with -r
# - An archive of the home directory will be added to /archives with -a
