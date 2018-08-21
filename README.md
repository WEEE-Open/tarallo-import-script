# T.A.R.A.L.L.O. Import Script

The script served its purpose on 12 April 2018, when the old inventory system
was imported and T.A.R.A.L.L.O. was finally deployed to production.

The import script and the old spreadsheet-based inventory have been retired
permanently, so this repo has been archived.

This repo also contained some other utility scripts, which are still maintained
and have been moved to the [T.A.R.A.L.L.O. repo](https://github.com/weee-open/tarallo),
so you can grab the latest version there.

If you want to import some data into T.A.R.A.L.L.O. on your own, this should
still give you an idea on how to use the addContent, addFeature and addItems
methods to import data directly into the database rather than by JSON API or
manual input.

`convert` takes some predefined csv files as input, builds an Item tree in memory
and stores it in the database.

Since csv structure is quite complex and chaotic and full of exceptions and,
most importantly, depended on the structure of our old inventory (an ods
spreadsheet with 13 distinct pages and hundreds of rows in each) which is not
public, the file contains huge if-else and switch statements to normalize the
data: just search for `addFeature` and other functions to see how they're supposed
to work.

The part that begins around line 1863 is also pretty useful: it connects to the
database running in the developement instance (VM managed by Vagrant) and inserts
both items, which is done through a single `addItem`, and audit entries with
raw queries.

## License

MIT, because nobody really cares about this giant unmaintained ball of spaghetti.
