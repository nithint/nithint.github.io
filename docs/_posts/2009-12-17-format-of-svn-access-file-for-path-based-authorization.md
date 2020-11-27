---
title: Format of SVN access file for Path Based Authorization
date: 2009-12-17 22:27:00.000000000 -08:00
categories:
- sysadmin
- svn
permalink: "/2009/12/17/format-of-svn-access-file-for-path-based-authorization/"
---

Fine grained permissions on SVN repositories can be provided by creating
an access file. Following is a sample access file explaining the basic
format of the file. More details can be found by reading the SVN
[book](http://svnbook.red-bean.com/).

~~~bash
#groups are defined here. simply list the names of members of the group delimited by comma
[groups]
admin = rudy, batman, admin

# to create access control for a repo, start with the directory that you are
# defining the permissions for
# to define permissions for all directories within a repo, use /
# for example, to define permissions for all directories in the gui project
# i've used the following [gui:/]
# the syntax is [reponame:directorypath]
# to define permission for a specific directory within the repo, specify the path
# example: [gui:/branches/2.0/bug/140] defines the permissions for the
# /gui/branches/2.0/bug/140 directory
# the syntax to define the permission itself is
# username = access
# where username is the username of the user you are writing permission for
# and access is one of r or rw, r meaning read permission and rw meaning read and
# write permission
# username could also be the name of a group. in that case, the group name is written
# as @groupname
# for example, to give the admin group rw permission on all directories in gui
# use,
# [gui:/]
# @admin = rw
# if you need to give all users permission on a directory, use the special
# character '*' to denote all users
# NOTE: The longest matching directory path permission is always applied first
# so if you have two permission rules like so,
# [gui: /]
# rudy = rw
#
# and
#
# [gui:/branches/2.0]
# nithin = r
#
# then, nithin will only have read permission on the /gui/branches/2.0 directory
# because that is the longest matching path
# More examles below:

[/]
* = r

[gui:/]
@admin = rw
nithin = rw
#
[moregui:/]
@admin = rw
matt = rw
john = r
chuck = rw
#
[hardcore:/branches/2.1/broke]
@admin = rw
#
[test:/]
@admin = rw
* = rw[/code]
~~~