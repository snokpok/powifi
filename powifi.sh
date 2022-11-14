#!/usr/bin/env bash

set -xe

# not a git dir
if [[ ! -d "$(pwd)/.git" ]]; then
  echo "This folder $pwd is not a Git repository. Please initialize this as a git repository and add a remote upstream."
  exit
elif [[ ! $(git remote -v) ]]; then
  # no remotes
  echo "This Git repository has no remote upstream. Please add a remote upstream."
  exit
fi

# TODO: get repo current branch
branch="main"
default_schedule="*/5 * * * *" # every 5 minutes

# TODO: make sure git-push.sh is found at root dir or in PATH


# schedule a crontab to ping google.com, and until successful ping then push it
# to current branch. If there's no job then create it
if [[ ! $(crontab -u $USER -l | grep "~/git-push.sh $(pwd) $branch") ]]; then
  crontab -u $USER -l | echo "$default_schedule bash ~/git-push.sh $(pwd) $branch" | crontab -u $USER -
fi

filename=$1
while read line; do
  echo "$line"
done < $filename
