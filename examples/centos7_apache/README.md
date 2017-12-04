# How To

First, `git` clond this repository.
```
$ git clone https://github.com/picatz/skynet.git
```

Change into the `skynet/examples/centos7_apache` directory.
```
$ cd skynet
```

Ensure you have your AWS enviroment variables set. Also fill out the `variables.tf` file with required information that isn't defaulted for you.
```
$ export AWS_ACCESS_KEY_ID=""
$ export AWS_SECRET_ACCESS_KEY="
$ export AWS_DEFAULT_REGION="us-east-1"
```

Run the `init` command with `terraform` command.
```
$ terraform init
```

You can sheck what will happen with the `plan` command that is specified in `centos7_apache.tf`.
```
$ terraform plan
```

You can now `apply` the `terraform` plan `centos7_apache.tf`:
```
$ terraform apply
```

To show all of the infromation for what happend, like the public IP address of the instance that's been deployed:
```
$ terraform show
```

You can easily do something like `grep` for specific infromation:
```
$ terraform show | grep "public_dns"
public_dns = ec2-3-4-5-6.compute-1.amazonaws.com
```

You could also pipe the `grep` output into `awk`:
```
$ terraform show | grep "public_dns" | awk -F " = " '{print $2}'
ec2-3-4-5-6.compute-1.amazonaws.com
```

To `ssh` into our instance:
```
$ ssh centos@ec2-3-4-5-6.compute-1.amazonaws.com
Last login: Mon Dec  4 01:47:12 2017 from 12.34.56.678
[centos@ip-172-31-26-142 ~]$ 
```

> 🎉  **That's it!**

Now, you may want to destroy it to freely test out other instances without worrying, right? Sure! When we `exit` out of your CentOS instance, we can use the `destroy` command with `terraform` to destroy everything we made.

```
$ terraform destroy
```

Don't worry though. If you want it back up, just `terraform apply` again!

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

## Changing Default Page

If we were to use `curl` to check out our `localhost`, we could wee the default Apache web page.

```
$ curl localhost
```

To add our own custom default web page, we can add a basic `index.html` file to the `/var/www/html/` directory.

```
$ sudo bash -c "sudo echo 'Hello World' > /var/www/html/index.html"
```

> ⚡️  The reason I am using the `sudo bash -c` syntax is so that the following command in `"` is run with `sudo`.

Now when we `curl` our localhost, we are able to see "`Hello World`"!

```
$ curl localhost
Hello World
```

# MariaDB

> 🔧  **Want to go further?** How about we try installing MariaDB, a MySQL drop-in replacement!

MariaDB is a community-developed fork of the MySQL created by the original creator of MySQL!

## Install MariaDB

Much like with `httpd`, we'll use `yum install` with `sudo` to install both `mariadb-server` and `mariadb`.

```
$ sudo yum install mariadb-server mariadb -y
```

## Start MariaDB

Again, much like with `httpd`, we can `start` it.

```
$ sudo systemctl start mariadb
```

## Quick'n Dirty MariaDB Security

> ⚡️  This tip also works for your normal `mysql` server!

We can use the sudo `mysql_secure_installation` command which is a script that will interactively run us through doing a basic security upgrade to our SQL server.

```
$ sudo mysql_secure_installation
```

# Opt In Required
> In order to use this AWS Marketplace product you need to accept terms and subscribe. To do so go [`here`](http://aws.amazon.com/marketplace/pp?sku=aw0evgkw8e5c1q413zgy5pjce)

To accept the terms to use the official CentOS 7 image costs no money. But, it's required. When you visit their official page, you will see something like this going on at the top of he page:
![centos1](https://i.imgur.com/ZbZRgiU.png)

You see that big yellow button on the right? We're going to click on it.

![centos2](https://i.imgur.com/nENRPEs.png)

The next page it takes you to will have this button on the right. We're going to click on it as well.

![centos3](https://i.imgur.com/no0v5w4.png)

This will take you to one more page will should show you a success like this one:

![centos4](https://i.imgur.com/2yDdhST.png)

> If you do not take this step for the AWI for this specific example, you will see the following error for `terraform`.

```
Error: Error applying plan:

1 error(s) occurred:

* aws_instance.ec2_instance: 1 error(s) occurred:

* aws_instance.ec2_instance: Error launching source instance: OptInRequired: In order to use this AWS Marketplace product you need to accept terms and subscribe. To do so please visit http://aws.amazon.com/marketplace/pp?sku=aw0evgkw8e5c1q413zgy5pjce
```

#### More Official CentOS AWS Documentation
You can find more official CentOS AWS documentation [`here`](https://wiki.centos.org/Cloud/AWS).

#### Find CentOS AMI IDs
Using the `aws` CLI, we can search for AMIs:
```
$ aws --region us-east-1 ec2 describe-images --owners aws-marketplace --filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce
```
##### Command Breakdown
* `--region us-east-1` defines the specific [region](https://docs.aws.amazon.com/general/latest/gr/rande.html) to be `us-east-1`.
* `ec2 describe-images` is the main command we're running essentially to find images for [`ec2`](https://docs.aws.amazon.com/cli/latest/reference/ec2/).
* `--owners aws-marketplace` specifies to use the main [`aws-marketplace`](https://aws.amazon.com/marketplace) to search.
* `--filters Name=product-code,Values=aw0evgkw8e5c1q413zgy5pjce` specifies two `filters` the `Name` and `Values` to search for.

