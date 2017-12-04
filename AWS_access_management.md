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
