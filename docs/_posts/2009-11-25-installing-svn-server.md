---
title: Installing SVN server
date: 2009-11-25 22:57:00.000000000  -08:00
classes: wide
categories:
- apache
- svn
- sysadmin
permalink: "/2009/11/25/installing-svn-server/"
---

1.  Install latest Apache [http server](http://httpd.apache.org/)
2.  Install SVN

    1.  Make sure to install mod_dav_svn and mod_authz_svn.
        mod_authz_svn is only needed if you plan on doing fine-grained
        directory permissions on your SVN repositories
    2.  Load the mod_dav_svn and mod_authz_svn modules in
        httpd.conf. You may also need to load the mod_dav module if you
        don’t have it yet:

        ~~~bash
        LoadModule dav_module modules/mod_dav.so
        LoadModule dav_svn_module modules/mod_dav_svn.so
        LoadModule authz_svn_module modules/mod_authz_svn.so
        ~~~

3. Modify apache httpd.conf to add the following:

    ~~~bash
    <Location svn>
    DAV svn
    SVNParentPath D:/svn
    SVNListParentPath on
    AuthType Basic
    AuthName &quot;Subversion Repository&quot;
    AuthUserFile passwd.txt
    Require valid-user
    </Location>
    ~~~

4. You should now be able to browse to your SVN repos at
    [www.yourdomain.com/svn](http://www.yourdomain.com/svn)

5. If you would like to enable anonymous checkouts, replace the Require valid-user above with the following. Check-ins will still require authentication.

    ~~~bash
    # For any operations other than these, require an authenticated user.
    <LimitExcept GET PROPFIND OPTIONS REPORT>
    Require valid-user
    </LimitExcept>
    ~~~

6. If you are not going to be using per-directory access control, you might as well turn off path authorization (it’s on by default). This improves performance of your server, since its not checking every single path requested to see if the user is authorized to access it. Add this line to turn it off:

    ~~~bash
    SVNPathAuthz off
    ~~~

7. Install PHP

8. Install an SVN browser, [WebSVN](http://websvn.tigris.org/) is the best I’ve seen. It’s built on PHP and works well.

9. [Subclipse](http://subclipse.tigris.org/) is the best SVN client for use with Eclipse IDE

10. [TortoiseSVN](http://tortoisesvn.tigris.org/) is a good SVN windows explorer client


