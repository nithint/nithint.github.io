---
title: Hard drive fail!
date: 2010-11-30 00:00:00.000000000 -08:00
categories:
- sysadmin
permalink: "/2010/11/30/windows-update-fail/"
---

**Update:**So it turns out that it wasn't a windows update problem after
all. My Samsung hard drive was faulting and had gone bad. Even though
the Hard Drive S.M.A.R.T monitor was telling it was bad, there was no
monitor on this machine and so I never saw it. Well, I got another WD
hard drive over Christmas on Amazon for cheap. Samsung hard drives are
no good, it seems. Lasted only as long as the warranty, 3 years.

So, about 1 month ago, I log into my server and see that I got about
fifty windows update waiting to be installed. I think, oh what’s the
harm and goes ahead and clicks update. And there began my month long
attempt to bring this site back up.

First, windows would not boot back up anymore. No safe modes and windows
repair couldn’t fix it either. And I think, this is as good a time as
any to upgrade to windows server 2008 r2. So I go ahead and install it.
I was doing periodic backups of data to another drive and so I didn’t I
would lose anything.

But of course, I had never thought to test any of my backups. So, I got
myself a brand new windows installation and my sql server database
backup is messed up. All of my personal data was safe though. So, what
happened was that sql server uses some sort striped multi-file backup
mechanism and I only had 1 of 2 files required to restore my blog
database. Great! You’ll get a nice little error message talking about
having only 1 file out of a media set. You can read a good explanation
[here](http://social.msdn.microsoft.com/forums/en-US/sqltools/thread/abf50e00-c9b0-4809-9e61-43ed8a53e968/). 
I’m not sure where the other file got backed up to.

Anyways, so I’ve scraping google and bing cache to get my blog posts
back. Lots of fun! Luckily, I didn’t have much posts to begin with, so
it isn’t too much work. It just took a month mainly because this has
been a pretty tough semester. Machine Learning is not an easy subject
and I’ve started interviewing for full-time jobs. Better start early
than late. Only 1 more semester to go! Hope to have everything backup in
order in 2 weeks. Until then, things are probably going to look a little
messy.
