# T.A.R.A.L.L.O.

This repo contains [tarallo-backend](https://github.com/WEEE-Open/tarallo-backend)
as submodule and a Vagrant configuration for testing.

Refer to that repo for documentation.

## Running stuff

Everything is already configured in Vagrantfile and install.sh, just run `vagrant up`
and you will get:

* T.A.R.A.L.L.O. instance accessible at `127.0.0.1:8080`
* APIs at `127.0.0.1:8080/v1/` (also used internally by the HTML interface)
* Xdebug enabled by default, set PHPStorm or any other IDE to listen for connection and
you're done
* Adminer at `127.0.0.1:8081/adminer.php` for database inspection (user: root, 
password: root, server: localhost:3306)
* database accessible externally by root at `127.0.0.1:3307` (note the non-standard port)
* some sample data, which right now is only 4 users and that's it
(user: `asd`, password: `asd`, all users have password `asd`)

If port gets changed from 8080 to anything else by Vagrant, no manual adjustments should
be necessary but it hasn't been tested.

There are two databases: `tarallo`, which is the one used by the interface and the APIs,
and `tarallo_test`, which is populated and used only when running PHPUnit tests.

Some Vagrant provision scripts are made to be runnable on their own, the most important ones are:

* `vagrant provision --provision-with db-procedures` to reimport procedures in both
in `tarallo` and `tarallo_test` database
* `vagrant provision --provision-with db-procedures` to recreate databases and import
`database-data.sql`, only in `tarallo` database

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
converts it to JS code and places it into `tarallo-backend/src/Database/Feature.php`
and some other files (`generate-features` tells you which ones when it's finished).

Modified files should be manually reviewed and committed.

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

See other repo linked above.
