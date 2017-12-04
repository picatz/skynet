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

You can check what will happen with the `plan` command that is specified in `centos7_apache.tf`.
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

### What now?

* [Install Apache](https://github.com/picatz/skynet/blob/master/examples/centos7_apache/install_apache.md)
* [Configure Apache](https://github.com/picatz/skynet/blob/master/examples/centos7_apache/configure_apache.md)
* [Install MariaDB](https://github.com/picatz/skynet/blob/master/examples/centos7_apache/install_mariadb.md)

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
* [Security Harden CentOS 7](https://highon.coffee/blog/security-harden-centos-7/)
