#!/bin/bash

if [[ -z $1  ]]; then
	echo "Option not set!";
else
	if [[ $1 != "master" ]]; then
		if [[ $1 != "stable" ]]; then
			rake guides:generate:html ALL=1 RAILS_VERSION=$1
		else
			rake guides:generate:html ALL=1 RAILS_VERSION=$1 LATEST=$2
		fi
		git clone $REMOTE_FOR_DEPLOY repository && cp output/guides/$1/* repository -R
		cd repository && git add --all && git commit -m "Deploy!"
		git push origin master
	else
		rake guides:generate:html ALL=1
		git clone $REMOTE_FOR_DEPLOY repository && cp output/edge/* repository -R
		cd repository && git add --all && git commit -m "Deploy!"
		git push origin master
	fi
fi
