# How To

> This how to assumes you're already working in the context of this directory.

#### Run Setup Script

You'll only ever need to run this once.

> This checks your AWS enviroment variables and puts your public facing IP address in the `variables.tf` file.

```
$ bash setup.sh
```

## Plan Changes

We want to see what will roughly happen when we `apply` our changes later.

> Yes, if you wanted to, you could actually skip this step. But, I guess... don't?

```
$ terraform plan
```

## Apply Changes

Now that we see our `plan` is what we want, we can `apply` those changes.

```
$ terraform apply
```

## Destroy Changes

If we no longer want the changes we've applied, we can simply `destroy` the resource.

```
$ terraform destroy
```
