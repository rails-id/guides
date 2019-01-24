#!/bin/bash

# Deployment script Rails Indonesia
#
# @author Cahyadi Triyansyah <sundi3yansyah@gmail.com>
#
# Usage:
#   $ chmod u+x ./deloy.sh # set chmod for executable
#   $ ./deploy.sh argument1 argument2 # argument1 as branch, argument2 for stable or not
#
# Example:
#   $ ./deploy.sh master
#   $ ./deploy.sh v6.0.0 stable

if [[ -z $1  ]]; then
  # if argument not exists
	echo "Option not set!";
else
  # match branche, whether it's a master / edge or a stable version
	if [[ $1 == "master" ]]; then
	  # this condition for master, just generate for master / edge version
	  # guide rails html version, branch master / edge does not have a kindle version
		rake guides:generate:html ALL=1

		# clone repository from server, then copy all content from `output/edge/*` to repository
		git clone $REMOTE_FOR_DEPLOY repository && cp output/edge/* repository -R

		# move to repository, and then commit all changes
		cd repository && git add --all && git commit -m "Deploy!"

		# booooooom... if return from travis is build exited with 0, it's deployed!
		git push origin master
	else
	  # else for stable version
	  # why install `kindlerb` like this? because kindlerb version 1.2.0 there is bug for kindlegen executable,
	  # and the latest version has not been released 1.2.1, reference: https://github.com/danchoi/kindlerb
	  # first clone dependencies this guides requre for kindlegen
	  git clone https://github.com/danchoi/kindlerb.git ~/kindlerb &&

	  # build and install gem `kindlerb`
	  gem build ~/kindlerb/kindlerb.gemspec && gem install ~/kindlerb/kindlerb-*.gem &&

	  # run kindlegen package
	  setupkindlerb

	  # copy kindlegen executable
	  cp ~/.rvm/gems/ruby-$TRAVIS_RUBY_VERSION/gems/kindlerb-*/bin/kindlegen ~/.rvm/bin

	  # if there is argument stable version
		if [[ $2 == "stable" ]]; then
		  # guide rails html version
		  rake guides:generate:html ALL=1 RAILS_VERSION=$1 STABLE=1
		  # guide rails kindle version
		  rake guides:generate:kindle ALL=1 RAILS_VERSION=$1 STABLE=1
		fi

		# guide rails for two argument is RAILS_VERSION
		# guide rails html version
		rake guides:generate:html ALL=1 RAILS_VERSION=$1
		# guide rails html version
		rake guides:generate:kindle ALL=1 RAILS_VERSION=$1

		# clone repository from server, then copy all content from `output/guides/*` to repository
		git clone $REMOTE_FOR_DEPLOY repository && cp output/guides/* repository -R

		# move to repository, and then commit all changes
		cd repository && git add --all && git commit -m "Deploy!"

		# booooooom... if return from travis is build exited with 0, it's deployed!
		git push origin master
	fi
fi
