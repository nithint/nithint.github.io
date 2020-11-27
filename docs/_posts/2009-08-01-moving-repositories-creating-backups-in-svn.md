---
title: Moving repositories/Creating backups in SVN
date: 2009-08-01 21:20:00.000000000  -08:00
classes: wide
categories:
- bash
- programming
- sysadmin
- svn
permalink: "/2009/08/01/moving-repositories-creating-backups-in-svn/"
---
Recently, I needed to move some projects around in my SVN and it turned out to be very easy, although it took a bit of googling. This also gives you a way to take file backups of your repositories. Basically, what I needed to do was move one repository into a subfolder inside another repository. To do this, you just need two commands and you also need to do this on the SVN server. You can’t do it from an SVN client. Here are the two commands:  

~~~bash
svnadmin dump /path/to/repository > filename.dmp
svnadmin load –-parent-dir path/to/subfolder repository-name < filename.dmp
~~~

So basically, the first command dumps your current repository including its previous revisions, branches and tags all to the standard output and you can redirect that into a file. You can use this command to take periodic backups of your repository which is really neat. I was actually searching for this feature as well and there might be other ways to take backups as well.  
The second command then loads up the repository from the dump file into the subfolder. If you don’t specify the –-parent-dir, it will just load up the file into the new repository. The parent-dir path is relative to the root of your new repository.  
Here are the links that helped me find this:  
- [svnbook.red-bean.com/nightly/en/svn.ref.svnadmin.c.load.html](http://svnbook.red-bean.com/nightly/en/svn.ref.svnadmin.c.load.html)
- [www.digitalmediaminute.com/article/2251/how-to-move-a-subversion-repository](http://www.digitalmediaminute.com/article/2251/how-to-move-a-subversion-repository)
