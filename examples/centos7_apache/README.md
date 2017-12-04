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

## Opt In Required
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

