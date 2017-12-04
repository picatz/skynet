# How To

First, `git` clone this repository.
```
$ git clone https://github.com/picatz/skynet.git
```

Change into the `skynet/examples/centos7_apache` directory.
```
$ cd skynet
```

Ensure you have your [AWS](https://aws.amazon.com/) enviroment variables set. Also fill out the `variables.tf` file with required information that isn't defaulted for you. If you haven't set up your keys yet, please follow my [other guide](https://github.com/picatz/skynet/blob/master/AWS_access_management.md)
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

## Start Apache on Boot

Configure `httpd` to start on boot with `systemctl`:

```
$ sudo systemctl enable httpd
```

## Configuring Apache

To configure the Apache HTTP Server, we can edit the `/etc/httpd/conf/httpd.conf` configuration file. We will also need to `restart` Apache whenever we make a configuration change in order to actually apply it.

> ⚡️  Most services and applications have a [configuration file](https://en.wikipedia.org/wiki/Configuration_file) that you can edit to customize how it works.

In order to actually edit files, you're probably going to want to know how to use a command-line text editor such as [`vi`](https://en.wikipedia.org/wiki/Vi), [`vim`](https://en.wikipedia.org/wiki/Vim_(text_editor)), [`emacs`](https://en.wikipedia.org/wiki/Emacs), or even [`nano`](https://en.wikipedia.org/wiki/GNU_nano) if you really want to do that.

> ⚡️  To help automate the process of editing text files in a [shell script](https://en.wikipedia.org/wiki/Shell_script), you may want to look at command-line tools like [`awk`](https://en.wikipedia.org/wiki/AWK) and [`sed`](https://en.wikipedia.org/wiki/Sed).

##### Listen on all network interfaces for a port

To listen on all network interfaces for a given port `80`, we want to sthe `Listen` directive 

We can change this to `Listen` directive to a specific IP addresses and port to prevent Apache from glomming onto all bound IP addresses. 
```
Listen 192.0.2.1:80
```

##### Listen for IPv4

If you want Apache to handle IPv4 connections only, specify an IPv4 address on all Listen directives:

```
Listen 0.0.0.0:80
```

##### Disable Trace HTTP Request

TraceEnable, when on, allows for Cross Site Tracing Issue and potentially giving the option to a hacker to steal your cookie information.

```
TraceEnable off
```

##### Run as separate User & Group

It is good to run Apache in its own non-root account. Modify User & Group Directive in `httpd.conf`:

```
User apache
Group apache
```

##### Disable Server Signature

It’s good to disable Signature, as you may not wish to as easily reveal which specific Apache Version you are running.

```
ServerSignature Off
```

##### Disable Banner

This directive controls whether Server response header field, which is sent back to clients, includes a description of the generic OS-type of the server as well as information about compiled-in modules.

```
ServerTokens Prod
```

##### Restrict Access to a Specific Network or IP

If you wish your site to be viewed only by specific IP address or network, you can modify your site Directory in `httpd.conf`:

```
<Directory /yourwebsite>    
  Options None    
  AllowOverride None    
  Order deny,allow    
  Deny from all    
  Allow from 10.20.0.0/24  
</Directory>
```

##### Disable Directory Listing

If you don’t have `index.html` under your WebSite Directory, the client will see all files and sub-directories listed in the browser. To disable directory browsing, you can either set the value of Option directive to `None` or `-Indexes`.

```
<Directory />
  Options None
  Order allow,deny
  Allow from all
</Directory>
```

##### Protecting System Settings

To run a really tight ship, you'll want to stop users from setting up .htaccess files which can override security features you've configured. Here's one way to do it. This prevents the use of .htaccess files in all directories apart from those specifically enabled.

```
<Directory />
  AllowOverride None
</Directory>
```

##### Protect Server Files by Default

One aspect of Apache which is occasionally misunderstood is the feature of default access. That is, unless you take steps to change it, if the server can find its way to a file through normal URL mapping rules, it can serve it to clients. This would allow clients to walk through the entire filesystem. So, we're going to need to fix that. 

```
<Directory "/">
  Require all denied
</Directory>
```

This will forbid default access to filesystem locations. Add appropriate Directory blocks to allow access only in those areas you wish. For example:

```
<Directory "/usr/users/*/public_html">
    Require all granted
</Directory>
<Directory "/usr/local/httpd">
    Require all granted
</Directory>
```

##### Protect Against DoS and DDoS with `mod_evasive`

The mod_evasive Apache module, formerly known as mod_dosevasive, helps protect against DoS, DDoS (Distributed Denial of Service), and brute force attacks on the Apache web server. It can provide evasive action during attacks and report abuses via email and syslog facilities. 

This will help protect against:
* Requesting the same page more than a few times per second
* Making more than 50 concurrent requests on the same child per second
* Making any requests while temporarily blacklisted

First, we need to install the EPEL (Extra Packages for Enterprise Linux) yum repository on the server. 

```
$ sudo rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
```

Now, let us protect the base packages from EPEL using the yum plugin protectbase.

```
$ sudo yum install yum-plugin-protectbase.noarch -y
```

> ⚡️  The purpose of the protectbase plugin is to protect certain yum repositories from updates from other repositories. Packages in the protected repositories will not be updated or overridden by packages in non-protected repositories even if the non-protected repo has a later version.

Run the following command to install the `mod_evasive` module:

```
$ sudo yum install mod_evasive -y
```

To configure `mod_evasive`, we can edit the `/etc/httpd/conf.d/mod_evasive.conf` file. 

```
DOSWhitelist         111.111.111.111
DOSWhitelist         222.222.222.222
DOSPageCount         20
DOSSiteCount         100
DOSBlockingPeriod    300
DOSLogDir           "/var/log/mod_evasive"
```

To ensure the `DOSLogDir` works, we're going to need to set it up:

```
$ sudo mkdir /var/log/mod_evasive
$ sudo chown -R apache:apache /var/log/mod_evasive

```

##### Name-Based Virtual Hosts

Apache breaks down its functionality and components into individual units that can be customized and configured independently. The basic unit that describes an individual site or domain is called a virtual host. Virtual hosts allow one server to host multiple domains or interfaces by using a matching system. 

With [name-based virtual hosting](https://httpd.apache.org/docs/2.4/vhosts/name-based.html), the server relies on the client to report the hostname as part of the HTTP headers. Using this technique, many different hosts can share the same IP address.

Before moving forward, we can make two examples in the `/var/www/` directory using the `mkdir` command:

```
$ sudo mkdir -p /var/www/example.com/public_html
$ sudo mkdir -p /var/www/example2.com/public_html
```

Then we can set the permissions we want. We now have the directory structure for our files, but they are owned by our root user. If we want our regular user to be able to modify files in our web directories, we can change the ownership with chown:

```
$ sudo chown -R $USER:$USER /var/www/example.com/public_html
$ sudo chown -R $USER:$USER /var/www/example2.com/public_html
```

> ⚡️  The $USER variable will take the value of the user you are currently logged in as when you submit the command. By doing this, our regular user now owns the public_html subdirectories where we will be storing our content.

We should also modify our permissions a little bit to ensure that read access is permitted to the general web directory, and all of the files and folders inside, so that pages can be served correctly:

```
sudo chmod -R 755 /var/www
```

Your web server should now have the permissions it needs to serve content, and your user should be able to create content within the appropriate folders. Now that we have our directory structure in place, let's create some content to serve.

```
$ echo "Hello from example.com" >> /var/www/example.com/public_html/index.html
$ echo "Hello from example2.com" >> /var/www/example2.com/public_html/index.html
```

To begin, we will need to set up the directory that our virtual hosts will be stored in, as well as the directory that tells Apache that a virtual host is ready to serve to visitors. The `sites-available` directory will keep all of our virtual host files, while the `sites-enabled` directory will hold symbolic links to virtual hosts that we want to publish.

We'll want to specify we will being using `sites-enabled` in our `/etc/httpd/conf/httpd.conf`.

```
$ sudo bash -c "echo 'IncludeOptional sites-enabled/*.conf' >> /etc/httpd/conf/httpd.conf"
```

Now, we can actually create the Virtual Host files for `example.com` and `example2.com`.

> ⚡️  Creating virtual host configurations on your Apache server **does not** magically cause DNS entries to be created for those host names. You must have the names in DNS, resolving to your IP address, or nobody else will be able to see your web site. You can put entries in your hosts file for local testing, but that will work only from the machine with those hosts entries.

For the `/etc/httpd/sites-available/example.com.conf` file:

```
# /etc/httpd/sites-available/example.com.conf
<VirtualHost *:80>
    ServerName www.example.com
    ServerAlias example.com
    DocumentRoot /var/www/example.com/public_html
    ErrorLog /var/www/example.com/error.log
    CustomLog /var/www/example.com/requests.log combined
</VirtualHost>
```
For the `/etc/httpd/sites-available/example2.com.conf` file:

```
<VirtualHost *:80>
    ServerName www.example2.com
    DocumentRoot /var/www/example2.com/public_html
    ServerAlias example2.com
    ErrorLog /var/www/example2.com/error.log
    CustomLog /var/www/example2.com/requests.log combined
</VirtualHost>
```
> ⚡️  The use of `VirtualHost` does not affect what addresses Apache httpd listens on. You may need to ensure that `httpd` is listening on the correct addresses using `Listen` Consult the [official documentation](https://httpd.apache.org/docs/2.4/vhosts/) for more information.

Now that we have created our virtual host files, we need to enable them so that Apache knows to serve them to visitors. To do this, we can create a symbolic link for each virtual host in the sites-enabled directory.

When you are finished, `restart` Apache to make these changes take effect with `systemctl`

```
$ sudo systemctl restart httpd
```
If you have been using example domains instead of actual domains to test this procedure, you can still test the functionality of your virtual hosts by temporarily modifying the hosts file on your local computer. This will intercept any requests for the domains that you configured and point them to your VPS server, just as the DNS system would do if you were using registered domains. This will only work from your computer, though, and is simply useful for testing purposes.

The details that you need to add are the public IP address of your VPS followed by the domain that you want to use to reach that VPS in your `/etc/hosts` file on your local computer:
```
127.0.0.1   localhost
server_ip_address example.com
server_ip_address example2.com
```
This will direct any requests for `example.com` and `example2.com` on our local computer and send them to our server at `server_ip_address`.



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

# More Resouces

This was easy to put together thanks to wonderful resources found online which I could base this off of.
* [How To Install Linux, Apache, MySQL, PHP (LAMP) stack On CentOS 7](https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-centos-7)
* [How To Protect Against DoS and DDoS with mod_evasive for Apache on CentOS 7](https://www.digitalocean.com/community/tutorials/how-to-protect-against-dos-and-ddos-with-mod_evasive-for-apache-on-centos-7#step-3-—-configuring-mod_evasive) 
* [How to Install Apache on CentOS 7](https://www.linode.com/docs/web-servers/apache/install-and-configure-apache-on-centos-7)
* [Name-based Virtual Host Support](https://httpd.apache.org/docs/2.2/vhosts/name-based.html)
* [How To Set Up Apache Virtual Hosts on CentOS 7](https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-centos-7)
* [Apache Main Configuration Files](https://httpd.apache.org/docs/2.4/configuring.html)
* [Apache Security Tips](https://httpd.apache.org/docs/2.4/misc/security_tips.html)
* [CentOS AWS](https://wiki.centos.org/Cloud/AWS)
* [How to Harden the Apache Web Server on CentOS 7](https://devops.profitbricks.com/tutorials/how-to-harden-the-apache-web-server-on-centos-7/)
* [13 Apache Web Server Security and Hardening Tips](https://www.tecmint.com/apache-security-tips/)
* [7 basic tips to improve Apache security](https://www.rosehosting.com/blog/7-basic-tips-to-improve-apache-security/)
* [How to Install Apache on CentOS 7](https://www.liquidweb.com/kb/how-to-install-apache-on-centos-7/)
* [Apache Web Server Hardening & Security Guide](https://geekflare.com/apache-web-server-hardening-security/)
