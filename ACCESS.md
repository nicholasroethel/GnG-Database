# PostgreSQL service access: info


## Student-specific details

* Name:    Roethel, Nicholas
* Number:  V00868351
* Netlink: nicholasroethel 
* Database username: benue
* Database password: e2=EA*mI8e


## How to connect

You have been provided an account on ```studsql.csc.uvic.ca``` for
which you must use the provided database username and password.

Given the configuration of the Faculty of Engineering firewall, you
will need to be logged into a Computer-Science server (such as
```linux.csc.uvic.ca```, or any of the Linux workstations in ECS labs)
in order to connect to the Postgres server.  You may, of course, 
be connected via your own laptop to ```linux.csc``` via the use of
```ssh```.
r
Assuming you are currently logged into ```linux.csc```, you must enter
the following ```psql``` command into an open shell:

```bash
psql --host=studsql.csc.uvic.ca --user=benue --password
```

IMPORTANT: You do _not_ specify your database password with the
command-line arguments shown above.  Once the server detects the
connection attempt, it will challenge you for that password. Enter the
_database_ password at the top of this document.  DO NOT PROVIDE YOUR
NETLINK PASSWORD!

Direct access from your own laptop which is connected to UVic's wifi
may or may not work; that is, using ```psql``` on your own laptop's
installation of PostgreSQL 10 will probably not work.  The most
dependable access is via a Computer Science server, and you use
```ssh``` from your laptop to connect to such a server.

