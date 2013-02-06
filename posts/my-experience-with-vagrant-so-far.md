---
title: My Experience With Vagrant So Far
date: '2013-01-11'
description:
categories:
tags: []

type: draft
---

I've written a couple posts on [Vagrant] [here] and [here too].  Vagrant is
a way of managing [Virtualbox] vms from the command-line.

While virtualbox already has a command-line to manage vms, Vagrant goes
further, providing a method for prepackaging vms called vagrant boxes.
A vm which is packaged as a vagrant box is configured to allow vagrant
to configure it with [Chef] or [Puppet], so you can specify a box that
gets preloaded with either specified or the latest versions of software.
You can also keep sensitive information out of the vm until it is time
to bring it up, such as user information and ssh keys.

Primarily I use vagrant to do Rails development.  You might wonder why
you'd need vms to do development if you have a perfectly good
development environment on your machine.  Not everyone needs it, but I
can think of a few good reasons:

- __You're on Windows, like me:__  Windows is, let's say, less than
  ideal for Rails development.  Using the interpreter is fine, but as
  soon as you have a lot of files like any rails project, you hit some
  major performance issues.  In addition, there aren't always compatible
  versions of gems that require compilation, and occasionally there are
  bugs with Ruby itself on Windows which go unnoticed or undiagnosed.
  I've experienced all of these issues.  Vagrant provides a manageable
  way to develop on Linux, which solves most of these problems.
- __You know how to deal with vms and don't want to learn rvm:__ Ok, you
  probably still need to know a little rvm, just enough to install the
  latest ruby build.  Experienced rails devs swear it's better than the
  Ubuntu system builds, even if I can't tell you why.  But you don't
  have to learn about gemsets or .rvmrcs if you just fire up a new vm
  when you work on a different project, and that's one less methodology
  to worry about keeping straight.  Of course, you're replacing with
  Vagrant's methodology, but trust me, it's simpler to get going than
  rvm.
- __You just want it to work:__ Seriously, gems, rvm and even bundler
  have issues.  They don't work perfectly, and if you've ever
  encountered the `gem --pristine` command, forgotten to switch gemsets
  or had to forcefully delete a cache from bundler, you know what I
  mean.  Even if you play by the rules, cruft accumulates, causing
  hard-to-trace issues.  Why not just start with a clean environment on
  every new project, popped fresh out of its hermetically-sealed can?
- __You don't want to keep your eggs in one basket:__ If all of your
  projects depend on one ruby run-time environment, if that one breaks,
  then you're wh
