---
title: WikiPublisher plugin for jenkins
date: 2011-03-27 10:56:48.000000000 -07:00
categories:
- programming
- tools
- java
- jenkins
permalink: "/2011/03/27/wikipublisher-plugin-for-jenkins/"
---

Sometimes, folks other than the developers are interested in the finding
out about the different builds and the components (upstream projects)
that are in a build. These other folks might be managers or
non-programming types that don’t have access to Jenkins or are not
interested in looking up things on Jenkins. They prefer to just see a
website with all builds listed. This plugin attempts to satisfy that
need.

We have an internal wiki site for sharing useful information and that
seems as good a place as any to share information about current builds
of projects. So, I’ve written the wiki publisher plugin that publishes
your build name along with the names of all of its upstream builds to a
wiki page you’ve configured. The names are also linked back to their
corresponding build on Jenkins so that you can go from wiki to Jenkins
to download artifacts or lookup changes.

This plugin is modeled after the [Confluence Publisher
plugin](http://wiki.jenkins-ci.org/display/JENKINS/Confluence+Publisher+Plugin)
that is available for Jenkins. There are two separate configuration
pages. In the global configuration page, you need to setup your list of
wiki sites that you would like to publish to. I expect most will only
have one site setup here but its nice to know you can add more. If your
wiki site uses authentication, then you need to setup your username,
password, domain for the user that Jenkins will use to publish to the
wiki site. Make sure that this user has edit permission on the wiki
pages. Also, I’ve only tested it against a wiki that authenticates
against LDAP server. So there’s the possibility that it won’t work on
other setups. One additional note of caution. Your wiki site may be
using https but only use a self signed certificate. In that’s the case,
then do not check the “use https” link or it won’t work.

Now that you have your wiki site setup, its time to configure your
project to publish to the wiki site. Open up your project configuration
page and you will see a new section to publish build results to a wiki.
Here, select the wiki site your setup previously and enter the name of
the page where the results are to be published. The plugin won’t create
the page itself and you must go to your wiki and setup an empty page
before running any builds.

This plugin uses the [jwbf](http://jwbf.sourceforge.net/) library for
publishing to the wiki and that library has a dependency on log4j 1.2.14
or above. Unfortunately, Jenkins uses an older version and so on your
Jenkins machine, you must setup the “java.endorsed.dirs” environment
variable to point to a directory that contains log4j 1.2.14 or above.

Let me know if this plugin has been useful to you and thanks to the
excellent Jenkins build tool.

[WikiPublisher on Github](https://github.com/nithint/wikipublisher)
