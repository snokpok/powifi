#!/usr/bin/env bash

set -xe

wd=$1
branch=$2

# get current branch so we can checkout back
cd $wd
currbranch=$(git branch)

# some default params
w=5
c=3
if [[ ! $(ping -w $w -c $c google.com) ]]; then
  echo "Wifi still out. Skipping push"
  exit
fi

echo "Wifi up! Current branch: $currbranch. Pushing Git repo at $wd on branch '$branch'"

git checkout $branch
git push
git checkout $currbranch

# delete this cron job when done
crontab -u $USER -l | grep -v "~/git-push.sh $wd $branch" | crontab -u $USER -
