# T.A.R.A.L.L.O.

This repo contains [tarallo-backend](https://github.com/WEEE-Open/tarallo-backend)
and [tarallo-frontend](https://github.com/WEEE-Open/tarallo-frontend) as submodules,
and a Vagrant configuration for testing.

Refer to those repos for documentation.

## Running stuff

Everything is already configured in Vagrantfile and install.sh, just run `vagrant up`
and you will get:
* a client instance running at `127.0.0.1:8080/tarallo`
* a server one instance at `127.0.0.1:8080/server`
* Xdebug enabled by default with IDE key `vagrant` (or use 
`?XDEBUG_SESSION_START=whatever` to set another IDE key)
* Adminer at `127.0.0.1:8080/adminer.php` for database inspection (user: root, 
password: root)
* database accessible externally by root at `127.0.0.1:3306`
* some sample data (user: asd, password: asd, all users have password asd)

If port gets changed from 8080 to anything else by Vagrant, no manual adjustments should
be necessary but it hasn't been tested.

The only thing that I couldn't get to work was `grunt watch`, which has to be started
manually inside `tarallo-frontend` (outside guest VM) or `/var/www/html/tarallo-frontend`
(via `vagrant ssh`).

## Building stuff

Run `build.sh` outside Vagrant: it will create a new directory named `build` and place 
there all the files that need to be deployed. Will also run Composer and Grunt, so 
have them installed.

The only manual step required after that is to edit `server/dp.php`. And create/update 
the database, if needed.

## License

See other repos linked above.
