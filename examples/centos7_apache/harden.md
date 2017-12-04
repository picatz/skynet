# CentOS 7 Hardening
> ⚡️  While attempting to harden a server, you may run into problems. Being able to revert back changes via backups or running initial commands in a text VM is always best practice.

## Regular Updates

I know this is sort of simple. But, you're going to want to remmber to update your system.

```
$ sudo yum update
```

You can also choose to just do security updates, which could be faster in a pinch.

```
$ sudo yum --security upgrade
```

## Automatically Update

To enable automatic security updates daily updates, we can install `yum-cron`:

```
$ sudo yum install yum-cron -y
```

To start `yum-cron`, we use `systemctl`.

```
$ sudo systemctl start yum-cron
```

To start `yum-cron` at boot.

```
$ sudo systemctl enable yum-cron
```

To apply updated automatically, we need to edit the `/etc/yum/yum-cron.conf` file and change `apply_updates = no` to `apply_updates = yes`. We can do this with [`sed`](https://en.wikipedia.org/wiki/Sed) very simply which could be useful for scripting this task.

```
$ sudo sed -i -e '/apply_updates =/ s/= .*/= yes/' /etc/yum/yum-cron.conf
```
We also want to change some other settings like the `update_cmd`.

```
$ sudo sed -i -e '/update_cmd =/ s/= .*/= security/' /etc/yum/yum-cron.conf
```

You might have a need to exclude certain packages from being included in the security updates. Say, for instance, you want to hold back kernel upgrades to run them manually. That makes perfect sense, as often a kernel upgrade requires a system reboot (in order for the changes to take effect).

```
$ sudo base -c "echo 'exclude = kernel*' >> /etc/yum/yum-cron.conf"
```

Then we want to apply our configurations, so we need to restart `yum-cron`.

```
$ sudo systemctl restart yum-cron
```

## Restricting Root

The default settings are close to this, but not quite paranoid enough.

```
$ echo "tty1" > /etc/securetty
$ chmod 700 /root
```

## Sysctl Networking

If these lines exist, modify them to match below. If they don't exist, simply add them in.

```
net.ipv4.ip_forward = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.tcp_max_syn_backlog = 1280
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.conf.all.accept_source_route = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.secure_redirects = 0
net.ipv4.conf.all.log_martians = 1
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.secure_redirects = 0
net.ipv4.icmp_echo_ignore_broadcasts = 1
net.ipv4.icmp_ignore_bogus_error_responses = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.tcp_timestamps = 0
```
