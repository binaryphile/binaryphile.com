---
title: Cloning my Spree instance and getting it running under Vagrant
date: '2013-01-25'
description:
categories:
  - spree
  - vagrant
tags: []
---

- Make a new folder with the instance name
- Go to command line in the folder and `vagrant init`
- Copy `.vagrant` as a backup
- Edit the `Vagrantfile`
    - use `precise32spree` as the base
    - map port 3000 to 3000 on localhost
    - vm already has all the prereqs installed and a copy of the db
- Make sure other vagrant vms aren't running and `vagrant up`
- Log onto the new vm and copy ssh key in
- Run my sync alias `sin` to copy `/vagrant` to `~/vagrant` for
  performance reasons
- `cd vagrant`
- `git clone git@github.com:lilleyt/spree_dibs_[major].[minor]`
- `git clone git@github.com:lilleyt/spree_flexi_variants`
- `git clone git@github.com:lilleyt/spree_dibs_referral`
- `git clone git@github.com:lilleyt/spree_email_to_friend`
- `git clone git@github.com:lilleyt/spree_print_invoice`
- Visit each directory, check out the current commit listed in
  `spree_dibs_[major].[minor]/Gemfile.lock`
    - If the revision isn't in the repo, add the upstream, `fetch --all`
    and try again
- `bundle install`
- `bundle exec rake assets:precompile:nondigest`
- Copy the `public/spree` folder from another instance or production

Test with `bundle exec rails s`
