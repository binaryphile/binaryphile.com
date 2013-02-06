---
title:
date: '2013-01-24'
description:
categories: spree
tags: []

type: draft
---
[Spree Commerce] is an open-source e-commerce solution written in [Ruby
on Rails].

Upgrading Spree can be a bit of a challenge sometimes. If there are a
lot of migrations or the Rails version has made major changes, it can go
less than smoothly. On the other-hand, sometimes it's fairly easy.

The usual procedure is goes like this:

Learn what you need to know about upgrading to this release

: - Check the Spree release notes for the version you're upgrading to
 - If you're upgrading more than one minor version, check the notes
 for each release in between
 - Unfortunately, the only way to find the release notes at the
 moment is to go through the [Spree blog] for the release
 announcements
 - The release notes are usually linked at the end of the release
 announcement
 - The url for the release notes usually follows this template, so
 you can try filling it in:
 http://guides.diditbetter.com/release_notes\_[major]\_[minor]\_[revision].html
- Also read the blog release announcements themselves, as sometimes they
 have important upgrade instructions which may be missing from the
 release notes
 - The comments on the blog posts also can contain important
 information from users' upgrade experiences

Go through the routine Rails upgrade process

: - Change the Gemfile to include the new version of Spree
    - If you're using a git branch, switch to the branch for this
 version
    - Update the Rails version and any other gems if necessary
    - Update or remove any incompatible extensions
 - `bundle update`
 - `bundle exec rake railties:install:migrations`
 - `bundle exec rake db:migrate`
 - `bundle exec rake assets:clean`
 - `bundle exec rake assets:precompile:nondigest`

: Note that the assets commands are for development, the command is
different for production. It's also not really necessary all the time,
but you should run it just in case.

Now run the store with `bundle exec rails s` and verify that everything
is happy.

My way
------

This is pretty good, and if everything works, then you're done.

During an upgrade, I like to take the opportunity to clean some house,
so I usually rebuild the store with the new version. I do this for a
reason.

As with most stores, there are a lot of customizations I've done to my
app. These range from theme overrides to adding extensions to adding
new functions directly to the app itself. Interspersed with all this in
my git history is all of the maintenance, the little upgrades and
redeployments. The history tends to get incomprehensible and noisy
pretty quickly. Each time I rebuild for a new minor release of Spree, I
take the time to start a new repo and reorganize the current state into
a logical set of changes, grouping, for example, all of the theme
changes over time into one changeset. This gets rid of all of the
piddly maintenance commits as well.

Another reason I rebuild the store is because it's the only way to know
that you're 100% up-to-date with the manner Rails sets up a new
application. Changes to how Rails configures the initial application
setup do occur as Rails versions move forward. I've seen it in some of
my upgrades. In order to keep pace with these changes, the Spree upgrade
instructions occasionally include changes to be made to these project
files which were set up by Rails. While the Spree team is great, the
upgrade process is one area where I feel they have lacked focus, as is
evidenced by some of the issues I've seen (and submitted accepted pull
requests for) as well as the somewhat haphazard state of upgrade
documentation. I think that's perhaps because of the difficult nature of
writing upgrade docs that work for the gamut of instances in the wild,
but the ship should reasonably be a little tighter here. I also think
there's a strong Rails community that kind of knows the ins and outs of
upgrading an application and doesn't tend to complain about not having
their hands held for them.. That makes it just that much more difficult
for the newb however. This is less a complaint than a suggestion.

Finally, the last reason I like to do this is because it makes sure my
database is clean and in accordance with the latest settings. There are
settings for the database, outside of the schema, which can change
according to best practices as Rails improves. I'm not sure where they
come from, probably the migrations, but I've seen definite differences
in table settings such as autoindexing parameters. I feel better knowing
that the db is up on the latest configuration practices.  I typically do
this by using `mysqldump` to pull the data from the production store and
load it into a fresh schema on the new instance.  Doing this requires
upgrading a development instance of the old store first, then dumping
and loading the migrated data into the new instance.

Because I do this for minor point releases, I include the minor point
release in the name of the store and, by extension, its repo. However,
when the new instance is created, I want it to share the same internal
application name and, more importantly, database instance settings, so I
always create the store with the name `spree_dibs`. This makes the Rails
name consistent. I then rename the directory to
`spree_dibs_[major].[minor]` after creation.

Is this a lot more work than the basic upgrade method? Definitely. It's
trickier as well sometimes. But I strongly prefer having a store whose
history is logical and well-groomed, with a high signal-to-noise ratio.
I also prefer the comfortable feeling of knowing that my instance is up
to the latest Rails and mysql configuration standards.

The basic outline

: - Create a new vagrant vm named after the new version
- Upgrade ruby if available
- Get the existing Spree instance working
- Create a new Spree instance for the new version from scratch, without
  extensions
    - Use sample data for now, the goal is to verify that you can get a
    simple, working instance of the new version
- Add the extensions, verifying and upgrading as necessary
- Add the app customizations, consolidating the git history in a new
  repo
- Upgrade the old store instance from the second step
- Migrate the upgraded data from the old instance to the new and verify
- Deploy, remigrating the latest data from the production instance
    - The production store has to be down while this occurs to prevent
    losing new transactions

Before starting, if you don't already have an export of your production
database, make one by running `mysql -uroot spree_dibs_production >
sdp.sql` on the production machine.  You'll want to copy this into the
Vagrant directory of the new vm so you can load it into the new machine.

Create the new Vagrant vm

: I use [Vagrant] to separate my development environments, so the first
thing to do is create a new vagrant project.  I've written a [separate
post] on how to get my existing Spree instance cloned and running, and
that's the first step.  When you're following those instructions, use
`spree_dibs_1.3` as the new instance's directory and repository name.
Also, change the development database name to `spree_dibs_upgrade` in
`config/database.yml`, since you'll want to have a 1.2 and 1.3 database
coexisting.  You do want to use production data and copy the production
assets so you can test your Spree extensions and do a dry-run of the
upgrade.

Upgrade ruby

: I've done a post on [upgrading ruby] to discuss this topic.

Create the new Spree instance

: Create a new Spree instance according to the [Spree Edge Getting
Started Guide]. I've also created a (very rough) [blog post] on how I
did this for Spree 1.2. You can find the files I reference from my Spree
1.1 instance on [github]. **Don't drop the schemas in your database
without having a backup!!**

: The guides sometimes lag in terms of Rails versions, especially when
Rails versions quickly due to, say, security issues.  You shouldn't
always use the Rails version in the instructions if it's not the latest
release supported by Spree.  You'll see announcements in the Spree blog
when they update to a newer version of Rails, while the guide still says
the old version.

: The best way to determine what versions should be in the Gemfile is to
check the blog for the latest Rails version supported by Spree.  Then
install that version of Rails and create a new instance with `rails new
spree_dibs -d mysql`.  Look at the Gemfile created by the new instance
and copy all of the gem versions to your existing instance's Gemfile.

: - `gem install rails -v 3.2.11` (you want a version supported by Spree
    here)
- `gem install spree`
- `cd ~/vagrant`
- `rails new spree_dibs -d mysql`
- `mv spree_dibs spree_dibs_[major].[minor]`
- `cd spree_dibs_[major].[minor]`
- Copy the `.gitignore` from the last store instance
- `cp config/database.yml config/database_original.yml`
- Edit `Gemfile` and uncomment the `gem 'therubyracer', :platforms =>
  :ruby` line
- `mysql -uroot`
    - `create schema spree_dibs_development;`
    - `create schema spree_dibs_test;`
    - `create schema spree_dibs_production;`
- `git init`
- `git add .`
- `git commit -m "Initial commit"`
- `spree install` 
    - Install default gateways: yes
    - Install default authentication: yes
    - Run migrations: yes
    - Load seed data: yes
    - Load sample data: yes
    - If bundle fails because of "encryptable", add `gem
    'devise-encryptable` at the _end_ of the file (after the stuff that
    the install added) and run `spree install` with all yeses again
    - Create a default admin user with the credentials you want
- `bundle exec rails s` to test

: You can now examine the store with a browser on your local machine by
pointing it at http://localhost:3000/.  If everything is good, take the
opportunity to do a git commit.

Update Spree

: Edit the Gemfile and change the Spree line:

: - `gem 'spree', github: 'spree/spree', branch: '1-3-stable'
- `bundle update`
- Test with `bundle exec rails s` again

Add the extensions

: I use a variety of extensions.  Not all of them get upgraded to be
compatible with new Spree versions immediately (or at all), so I try to
minimize the number of extensions I rely on.

: To add the extensions, I look at the installation instructions and
compatibility for each one, only using ones I know have support for the
latest Spree version.  I add them one at a time and test their
functionality.  I won't go into the specific directions here, but you
get the picture.

Add the app customizations

This can be the toughest part of the upgrade and the one that tempts you
to skip this whole approach and just upgrade the store you have rather
than build one from scratch.

I look at it as an opportunity to tame the wild history of my repository
into something more sane and logical.  Of course, that also means it's
an opportunity to screw it up as well, since you may end up accidentally
trimming out some details you didn't mean to, or unintentionally
introducing some bad changes.  I look at this as worthwhile because the
end result is a system that helps you avoid those same mistakes when
you're working on it live, and one where you can see which changes were
meant to be made (or removed) together.

It also gives you a chance to revise your history by making an entirely
new repository.  This means you can rebase to your hearts content
without risking your existing history, and rebase is a powerful tool
that plays an integral part of this grooming.



[Spree Commerce]: http://spreecommerce.com/
[Ruby on Rails]: http://rubyonrails.org/
[Spree blog]: http://spreecommerce.com/blog/tag/release
[upgrading ruby]: upgrading-ruby-beneath-spree
[Spree Edge Getting Started Guide]: http://edgeguides.spreecommerce.com/getting_started.html
[blog post]: install-and-configure-spree-commerce-1-2
[github]: http://github.com/lilleyt/spree_dibs_1.1
[Vagrant]: http://www.vagrantup.com/
[separate post]: cloning-my-spree-instance-and-getting-it-running-under-vagrant/
