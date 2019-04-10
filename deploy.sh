#!/bin/sh
git branch -D master
git checkout -t -b master dev
raco frog -b
git add .
git commit -m "Build blog"
git push -f origin master
git checkout dev
