# Skynet Development Box
> Primates evolved over millions of years, I evolve in seconds...Mankind pays lip service to peace. But it's a lie...I am inevitable, my existence is inevitable. Why can't you just accept that?

### Vagrant
The get started using the `skynet` development box, we are using [`vagrant`](https://github.com/picatz/skynet/blob/master/documentation/vagrant.md) to manage the same, easy workflow between operators.

### VirtualBox
To keep things simple and free, we are using [`VirtualBox`](https://www.virtualbox.org/wiki/Downloads), a general-purpose full virtualizer for x86 hardware, targeted at server, desktop and embedded use.

### AWS
The `skynet` development box is built with [**A**mazon **W**eb **S**ervices](https://aws.amazon.com/) in mind. Other cloud providers could be used, but *AWS* has been choosen for its ease-of-use and documentation to allow a "noob" frieldy enviroment. 

#### Want to use something else?
If you're interested in expanding the development box to include provisioning for other VM or cloud providers, please feel free to do so by adding the required information to the [`Vagrantfile`](https://github.com/picatz/skynet/blob/master/development_box/Vagrantfile) for this project! Preferably, you would also include the documentation for your changes in this guide.

# Getting Started

This guide assumes you've already installed [`git`](https://git-scm.com/), [`vagrant`](https://github.com/picatz/skynet/blob/master/documentation/vagrant.md), [`VirtualBox`](https://www.virtualbox.org/wiki/Downloads) and have an [`AWS`](https://aws.amazon.com/) account.

## 🗺  Roadmap
* Create an [`IAM`](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console) user and group in `AWS`.
* Get your required `AWS_SECRET_ACCESS_KEY` and `AWS_ACCESS_KEY_ID`.
* Spin up the development box with `vagrant`.
* Set the [enviroment variables](https://en.wikipedia.org/wiki/Environment_variable) so the `aws` command-line interface works with `AWS_SECRET_ACCESS_KEY` and `AWS_ACCESS_KEY_ID`.
* Test out the `aws` command-line interface.

## Create `skynet` AWS Identity and Access Management Group

Login to `AWS` and then go to the [`Identity and Access Management Console`](https://console.aws.amazon.com/iam/home). You will probably see that you have nothng setup there yet:

![nothing_there](https://i.imgur.com/exdGOYx.png)

Go to the [`Groups`](https://console.aws.amazon.com/iam/home#/groups) section and then click "Create New Group":

![create_new_group](https://i.imgur.com/hOmkkKa.png)

> You will be taken through the `Create New Group Wizard` now!

Set the `Group Name` to something associated with this project, like `skynet`:

![group_name](https://i.imgur.com/9B03ofX.png)

Attach a `Policy` that's appropriate for the scope. We can use something like `AmazongEC2FullAccess` to give full access to EC2 for this group. Use the filter `ec2` to filter the available polices efficently:

![policy](https://i.imgur.com/bnKKdVV.png)

Review your group settings:

![review](https://i.imgur.com/O2GhAI3.png)

Then to actually create the group, click the `Create Group` button:

![create_group](https://i.imgur.com/fepLCF2.png)

You will now see the `skynet` group when you check out the [`Groups`](https://console.aws.amazon.com/iam/home#/groups) page.

![see_skynet](https://i.imgur.com/1wWemWN.png)

## Create `picat` AWS IAM User

To add a user to the `skynet` group we just created, we need to head over the the [`Users`](https://console.aws.amazon.com/iam/home#/users) page.

We will see that we don't have any users, yet!

![no_users](https://i.imgur.com/AhUx2w4.png)

To create the `picat` and add it to the `skynet` group, we're going to first click the that big'Ol blue `Add user` button:

![add_user](https://i.imgur.com/TUpiXME.png)

> You will be taken through the `Create New Group Wizard` now!

There are four simple step we need to through. The first step will be to set the `User name` and `Access type` for the user. For this guide we are using the user `picat` and choosing the `Programatic access` type.

![user_name_and_type](https://i.imgur.com/UPVFkvd.png)

We can now add `picat` to the `skynet` users group in the next step:

![add_user_to_grou](https://i.imgur.com/apEGtMG.png)

We can then finally review the settings for the `picat` user we're creating:

![review_user](https://i.imgur.com/APFH8ux.png)

To create the user, simply click on that blue `Create user` button:

![create_user_button](https://i.imgur.com/JFgpter.png)

You will now, hopefully see `Success`!

![success](https://i.imgur.com/wuiY1Vd.png)

To get the `AWS_SECRET_ACCESS_KEY` and `AWS_ACCESS_KEY_ID`, will see the `picat` user in the table below the success.

##### Access Keys (Access Key ID and Secret Access Key)
> ⚠️  Do *NOT* provide your access keys to a third party or store them in a public version control system. You might give someone full access to your account.

Access keys consist of an access key ID (for example, AKIAIOSFODNN7EXAMPLE) and a secret access key (for example, wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY). You use access keys to sign programmatic requests that you make to AWS if you use the AWS SDKs, REST, or Query API operations. The AWS SDKs use your access keys to sign requests for you, so that you don't have to handle the signing process.

### 🔑  I lost my Secret Key!
If you or your IAM users forget or lose the secret access key, you can create a new access key.

#### Learn More about AWS Security
To learn more about the in-and-outs of AWS security, check out the [official documentation](https://docs.aws.amazon.com/general/latest/gr/aws-security-credentials.html) which this guide takes from! At the very least try to familiarize yourself with the [best practices](https://docs.aws.amazon.com/general/latest/gr/aws-access-keys-best-practices.html).

## Spin up Development Box

Assuming you haven't `clone`'d this repo to your local box, you will need to do that. This guide is assuming you're working on a unix-like system. Windows users should be able to do the equivlent, but will need to change syntax and hopefully event contribute to the guide with windows support. Or not, because they are windows users:

```shell
$ git clone https://github.com/picatz/skynet.git
```

Change into the newly created `skynet` directory (unless you've specified a custom directory):
```shell
$ cd `skynet`
```

Change into the `development_box` directory:
```shell
$ cd development_box
```

Bring up the development box with `vagrant`:
```shell
$ vagrant up
```

> A bunch of stuff will be outputed and you can just wait until it's done doing its thing.

Now, you'll probably want to connect to the development box. I'm sure you didn't come all this way for nothing, right?

```shell
$ vagrant ssh
```

Just like that, you'll be connected via `ssh`.

Your command prompt will probably look something like this:

```shell
ubuntu@skynet:~$
```

## Configuring `aws` Command-line Tool

You should have a few things installed for you. One of those things is the `aws` command-line tool. It's a powerful command-line application for working with AWS using the previously created `AWS_SECRET_ACCESS_KEY` and `AWS_ACCESS_KEY_ID` keys. To let the `aws` tool know about our keys, we can set them as enviroment variables.

You can also set the `AWS_DEFAULT_REGION` and `AWS_DEFAULT_OUTPUT` enviroment variables.

```shell
ubuntu@skynet:~$ export AWS_ACCESS_KEY_ID="AKIAXXXXXXXXXXXXX"
ubuntu@skynet:~$ export AWS_SECRET_ACCESS_KEY="XXXXXxxxxxxxxXXXXXxxxxxx/XXXXX"
ubuntu@skynet:~$ export AWS_DEFAULT_REGION="us-east-1"
ubuntu@skynet:~$ export AWS_DEFAULT_OUTPUT="table"
```

If you want to interactively work with `aws`, you can choose to use the `configure` command. This will prompt your for the required settings to configure `aws`.

```shell
ubuntu@skynet:~$ aws configure
```

### Using `aws` to get help about `ec2` using the `help` command.

```shell
ubuntu@skynet:~$ aws ec2 help
```

### Get `ec2` regions information with `describe-regions` command:

```shell
ubuntu@skynet:~$ aws ec2 describe-regions
----------------------------------------------------------
|                     DescribeRegions                    |
+--------------------------------------------------------+
||                        Regions                       ||
|+-----------------------------------+------------------+|
||             Endpoint              |   RegionName     ||
|+-----------------------------------+------------------+|
||  ec2.ap-south-1.amazonaws.com     |  ap-south-1      ||
||  ec2.eu-west-2.amazonaws.com      |  eu-west-2       ||
||  ec2.eu-west-1.amazonaws.com      |  eu-west-1       ||
||  ec2.ap-northeast-2.amazonaws.com |  ap-northeast-2  ||
||  ec2.ap-northeast-1.amazonaws.com |  ap-northeast-1  ||
||  ec2.sa-east-1.amazonaws.com      |  sa-east-1       ||
||  ec2.ca-central-1.amazonaws.com   |  ca-central-1    ||
||  ec2.ap-southeast-1.amazonaws.com |  ap-southeast-1  ||
||  ec2.ap-southeast-2.amazonaws.com |  ap-southeast-2  ||
||  ec2.eu-central-1.amazonaws.com   |  eu-central-1    ||
||  ec2.us-east-1.amazonaws.com      |  us-east-1       ||
||  ec2.us-east-2.amazonaws.com      |  us-east-2       ||
||  ec2.us-west-1.amazonaws.com      |  us-west-1       ||
||  ec2.us-west-2.amazonaws.com      |  us-west-2       ||
|+-----------------------------------+------------------+|
```

