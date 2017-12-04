## Install Apache

Now to install the [Apache](https://httpd.apache.org/) HTTP Server! Apache is a free, open-source, cross-platform web server software, released under the terms of Apache License 2.0. The Apache web server is currently the most popular web server in the world, which makes it a very popular choice for information security compeitions.

We can install Apache using CentOS's package manager, `yum`. 

> ⚡️  Package managers allow us to install software from a [repository](https://www.digitalocean.com/community/tutorials/how-to-set-up-and-use-yum-repositories-on-a-centos-6-vps).

To install Apache, we need to install the `httpd` package. We can first search for the package with `yum`.

```
$ yum search httpd
```

To more display information about a certain package you can use the command `yum info`:

```
$ yum info httpd
Name        : httpd
Arch        : x86_64
Version     : 2.4.6
Release     : 67.el7.centos.6
Size        : 2.7 M
Repo        : updates/7/x86_64
Summary     : Apache HTTP Server
URL         : http://httpd.apache.org/
License     : ASL 2.0
Description : The Apache HTTP Server is a powerful, efficient, and extensible
            : web server.
```

Now, let's just `install` it using `sudo`:

```
$ sudo yum install httpd -y
```

> ⚡️  `sudo` is a program for Unix-like computer operating systems that allows users to run programs with the security privileges of another user, by default the superuser.

## Checking Apache

We can check the the `status` of our Apache server now using `systemctl`:

```
$ sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
  Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
  Active: inactive (dead)
    Docs: man:httpd(8)
          man:apachectl(8)
```

Looking at the output of the `systemctl status` command, we can see that two `Docs` are avaiable as [`man`](https://en.wikipedia.org/wiki/Man_page) pages. To access the man pages:

```
$ man httpd
```
or
```
$ man apachectl
```

> ⚡️  The man pages provide plenty of useful information, but they are generally **not** perfect!

## Starting Apache

To `start` Apache, if you've been paying attention, it should be pretty easy to guess what you would need to do:

```
$ sudo systemctl start httpd
```

We can verify that `httpd` is running with the `systemctl status` command, the same as before:

```
$ sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2017-12-04 02:42:38 UTC; 27s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 8547 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/httpd.service
           ├─8547 /usr/sbin/httpd -DFOREGROUND
           ├─8548 /usr/sbin/httpd -DFOREGROUND
           ├─8549 /usr/sbin/httpd -DFOREGROUND
           ├─8550 /usr/sbin/httpd -DFOREGROUND
           ├─8551 /usr/sbin/httpd -DFOREGROUND
           └─8552 /usr/sbin/httpd -DFOREGROUND

Dec 04 02:42:37 ip-172-31-26-142.ec2.internal systemd[1]: Starting The Apache HTTP Server...
Dec 04 02:42:38 ip-172-31-26-142.ec2.internal systemd[1]: Started The Apache HTTP Server. 
```

The output shows plenty of useful infromation. We can see the the main [`PID`](https://en.wikipedia.org/wiki/Process_identifier) for the `httpd` service, some basic traffic status, and we can see that the service is in fact `Active`.

## Stopping Apache

We've started `httpd`, but now we're done with it. Or maybe we see that it's on, and we want to turn it off in order to secure it before bring it back up. Much like starting the service, we can `stop` the service.

```
$ sudo systemctl stop httpd
```
