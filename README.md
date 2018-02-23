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
* Xdebug enabled by default, set PHPStorm or any other IDE to listen for connection and
your'e done
* Adminer at `127.0.0.1:8080/adminer.php` for database inspection (user: root, 
password: root, server: localhost:3306)
* database accessible externally by root at `127.0.0.1:3307` (note the non-standard port)
* some sample data, which right now is only 4 users and that's it
(user: `asd`, password: `asd`, all users have password `asd`)

If port gets changed from 8080 to anything else by Vagrant, no manual adjustments should
be necessary but it hasn't been tested.

The only thing that I couldn't get to work was `grunt watch`, which has to be started
manually inside `tarallo-frontend` (outside guest VM) or `/var/www/html/tarallo-frontend`
(via `vagrant ssh`).

## Building stuff

Run `build.sh` outside Vagrant: it will create a new directory named `build` and place 
there all the files that need to be deployed. It will also run Composer and Grunt, so 
have them installed.

The only manual step required after that is to edit `server/db.php`. And create/update/import
the database, if needed.

## Misc utility scripts

These are PHP scripts which can be run directly or by using `php script-name`.

### Feature list generation

`generate-features` reads the feature list from `tarallo-backend/database-data.sql`,
converts it to JS code and places it into `tarallo-frontend/js/feratures.js` and
`tarallo-backend/src/Database/Feature.php` which should be manually reviewed and
commited afterward.

### Inserting initial data

`converter/convert` takes some predefined csv files as input, builds an Item tree in memory
and stores it in the database.

Since csv structure is quite complex and chaotic and full of
exceptions and, most importantly, depends on the structure of our current inventory (an ods
spreadsheet with 13 distinct pages and hundreds of rows in each) which is not public, this is
practically useless to anyone. However it should give you an idea on how to use the addContent, 
addFeature and addItems methods to import data directly into the database rather than by
JSON API or manual input.

## License

See other repos linked above.
