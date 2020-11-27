---
title: Create SVN repositories using a standard folder structure
date: 2009-12-10 22:08:00.000000000 -08:00
classes: wide
categories:
- bash
- programming
- shell scripting
- subversion
- svn
- sysadmin
permalink: "/2009/12/10/create-svn-repositories-using-a-standard-folder-structure/"
---

This is shell script that you can use to create all of your repositories
using the same standard folder structure. You need to replace the
following variables for it to run:

1.  Replace \[name\] with the correct username of a user who will have
    permissions on the repository.
2.  Replace \[password\] with the correct password of the user
3.  Replace yourdomain.com with the path to where your svn repositories
    are stored

call the script: ./scriptname reponame and it will create a new
repository with the name reponame.

Here’s what the script does:

1.  The script creates the new repository folder
2.  It gives apache permissions on the folder. If you are not using
    apache, uncomment the line.
3.  If you are using an access file to provide fine-tuned directory
    permissions, you may want to uncomment the two lines that refer to
    access.txt. Those two lines add the new repo to the access file and
    gives the admin group rw permissions on the repository.
4.  It then goes and creates the standard folder structure, ie, trunk, branches and tags folder.

~~~bash
#!/bin/bash
svnadmin create $1;
chgrp -R apache $1;
chmod -R g+rw $1;
#echo "[$1:/]" &gt;&gt; access.txt
#echo "@admin = rw" &gt;&gt; access.txt
svn –username [name] –password [pass] mkdir "http://yourdomain.com/svn/"$1"/trunk" -m "ADD: /trunk";
svn –username [name] –password [pass] mkdir "http://yourdomain.com/svn/"$1"/branches" -m "ADD: /branches";
svn –username [name]—password [pass] mkdir "http://yourdomain.com/svn/"$1"/tags" -m "ADD: /tags";

echo "------------------------------------------";
echo "Standard Repo Layout Created";
~~~
