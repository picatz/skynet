# [Vagrant](https://www.vagrantup.com/)
> Development Environments Made Easy

## What is it?
Vagrant provides the same, easy workflow regardless of your role as a developer, operator, or designer. It leverages a declarative configuration file which describes all your software requirements, packages, operating system configuration, users, and more.

The cost of fixing a bug exponentially increases the closer it gets to production. Vagrant aims to mirror production environments by providing the same operating system, packages, users, and configurations, all while giving users the flexibility to use their favorite editor, IDE, and browser. Vagrant also integrates with your existing configuration management tooling like Chef, Puppet, Ansible, or Salt, so you can use the same scripts to configure Vagrant as production.

#### Cross-Platform
Vagrant works on Mac, Linux, Windows, and more. Remote development environments force users to give up their favorite editors and programs. Vagrant works on your local system with the tools you're already familiar with. Easily code in your favorite text editor, edit images in your favorite manipulation program, and debug using your favorite tools, all from the comfort of your local laptop.

## Usage

Choose a VM to create from a [publicly available list](https://app.vagrantup.com/boxes/search) of free resources:
```shell
$ vagrant init hashicorp/precise64
```

Start up the box `hashicorp/precise64` we just pulled down:
``` 
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'hashicorp/precise64'...
==> default: Forwarding ports...
default: 22 (guest) => 2222 (host) (adapter 1)
==> default: Waiting for machine to boot...
```

Use the `vagrant ssh` command to use [SSH](https://en.wikipedia.org/wiki/Secure_Shell) to connect to the box and get work'n!
```
$ vagrant ssh
vagrant@precise64:~$ _
```

To exit the box, just exit:
```
vagrant@precise64:~$ exit
```

If you want to come back to this box later, we can use `vagrant halt` to pause the box:
```
$ vagrant halt
```

You can bring up the box again like you would normally:
```
$ vagrant up
```

Use `vagrant destroy` you're done with the box and want to tear it down completly:
```
$ vagrant destroy
```
