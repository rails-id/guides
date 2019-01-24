#!/bin/bash

if [[ -z $1  ]]; then
	echo "Option not set!";
else
	if [[ $1 == "master" ]]; then
		rake guides:generate:html ALL=1
		git clone $REMOTE_FOR_DEPLOY repository && cp output/edge/* repository -R
		cd repository && git add --all && git commit -m "Deploy!"
		git push origin master
	else
	  git clone https://github.com/danchoi/kindlerb.git ~/kindlerb &&
	  gem build ~/kindlerb/kindlerb.gemspec && gem install ~/kindlerb/kindlerb-*.gem &&
	  setupkindlerb
	  cp ~/.rvm/gems/ruby-$TRAVIS_RUBY_VERSION/gems/kindlerb-*/bin/kindlegen ~/.rvm/bin

		if [[ $2 == "stable" ]]; then
		  rake guides:generate:html ALL=1 RAILS_VERSION=$1 STABLE=1
		  rake guides:generate:kindle ALL=1 RAILS_VERSION=$1 STABLE=1
		fi
		rake guides:generate:html ALL=1 RAILS_VERSION=$1
		rake guides:generate:kindle ALL=1 RAILS_VERSION=$1
		git clone $REMOTE_FOR_DEPLOY repository && cp output/guides/* repository -R
		cd repository && git add --all && git commit -m "Deploy!"
		git push origin master
	fi
fi
