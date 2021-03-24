### Install Legend.mu database for Linux hosts

@ Source: http://forum.ragezone.com/f197/release-legend-mu-client-server-1195391/

#### Prerequisites:

- [Installed mysql CLi](https://dev.mysql.com/doc/refman/8.0/en/mysql.html)
- [Installed git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)


#### Clone repo

```shell
$ git clone https://github.com/sergey-gr/legend.mu-db.git
```

#### Set up variables in [configuration file](config/run.conf)

```ini
host='<db_ip_or_hostname>'
user='<privileged_db_user>'
pass='<db_user_password>'
```

#### Run script

```shell
$ ./run.sh
```