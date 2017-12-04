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
