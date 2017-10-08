# T.A.R.A.L.L.O.

This repo contains [tarallo-backend](https://github.com/WEEE-Open/tarallo-backend)
and [tarallo-frontend](https://github.com/WEEE-Open/tarallo-frontend) as submodules,
and a Vagrant configuration for testing.

Refer to those repos for documentation.

## Running stuff

Everything is already configured in Vagrantfile and install.sh, just run `vagrant up`
and you will get a client instance running at `127.0.0.1:8080/tarallo`, a server one
at `127.0.0.1:8080/server`, Adminer at `127.0.0.1:8080/adminer.php` for database
inspection (user: root, password: root) and some sample data (user: asd, password: asd,
all users have password asd).

If port gets changed from 8080 to anything else by Vagrant, no manual adjustments should
be necessary but it hasn't been tested.

The only thing that I couldn't get to work was `grunt watch`, which has to be started
manually inside `tarallo-frontend` (outside guest VM) or `/tarallo-frontend`
(via `vagrant ssh`).

## License

See other repos linked above.
