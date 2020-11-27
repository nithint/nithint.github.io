---
title: major.minor plugin for Jenkins
date: 2011-03-27 09:47:00.000000000 -07:00
categories:
- programming
- tools
- java
- jenkins
permalink: "/2011/03/27/majorminor/"
---

~~Recently, I’ve been tasked with setting up a build environment at work
and we decided to go with Hudson and now Jenkins. I think the best part
of Jenkins is its extensibility in the form of writing plugins to make
it do exactly what you want. So my first plugin was to change the build
numbers that Jenkins uses like \#1, \#2 etc. to something more
meaningful for our scenario and so was born the major.minor plugin.

The premise of the plugin is quite simple. In our projects, we would
like to see build names of the form major.minor.revision. We use
subversion for source code management and so the revision number here
refers to the svn revision number. The major and the minor numbers are
configured when the build is initially setup and are initialized to 1
and 00 respectively. So, the first build name might be something like
1.00.23 if the svn revision at that point happened to be 23.

At some point down the line in the project cycle, we might like to
increment the minor or major number and this can be done manually after
a build by using already Jenkins feature to edit the build name. Since
the plugin picks up the major and minor part of the build name from the
previous build of the project, subsequent builds will now have the
correct major and minor sections.

Now that the build name has been changed, when you browse through the
builds directory for your project, it will be hard for you to figure out
which build is what because Jenkins only creates directories using the
build number like \#2, \#3 etc. and the date/time when the build was
executed. To make it easier, the plugin also creates a new symbolic link
with the build name in the builds directory. Now the Jenkins UI and
builds directory matches and its easier for you to get to the right
build.

When you enable this plugin, you get a new configuration section for
your project. In this section, you will configure a regex to match build
names against. I’ve made it a regex so that it is a little bit more
flexible and can be still be used even if your organization does not use
a major.minor.revision format for naming builds. The important thing is
that you add a capturing group in your build name regex which is used to
insert the new revision number into the build name. Note that if you
don’t use svn for scm, the plugin still works and inserts the build
number in place of the revision number. The other configuration is for
setting the initial build name for your project like 1.00.00.

The plugin also makes available a BUILD\_NAME environment variable for
any scripts that might need it.

Hope this plugin helps anyone looking for nicer build names and thanks
to the Jenkins project for a great build tool.

The plugin source is available on
[Github](https://github.com/nithint/major.minor) and you are free to
fork and tinker with it suit your needs.
