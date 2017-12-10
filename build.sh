#!/bin/bash
set -e
BUILD="build"
SERVERPATH="server"
TFRONT="tarallo-frontend"
TBACK="tarallo-backend"

if [[ ! -d "$TFRONT" ]]; then
	echo "No frontend directory ($TFRONT)"
	exit 1
fi

if [[ ! $(ls -A "$TFRONT") ]]; then
	echo "Empty frontend directory ($TFRONT). Have you cloned submodules?"
	exit 1
fi

if [[ ! -d "$TBACK" ]]; then
	echo "No backend directory ($TBACK)"
	exit 1
fi

if [[ ! $(ls -A "$TBACK") ]]; then
	echo "Empty frontend directory ($TBACK). Have you cloned submodules?"
	exit 1
fi

if [[ -d "$BUILD" ]]; then
	echo "Clearing target directory ($BUILD)"
	rm -rf "$BUILD"
fi
mkdir "$BUILD"

echo "Building server..."
mkdir "$BUILD/$SERVERPATH"
FILES=( "$TBACK/*.php" "$TBACK/composer.*" )
cp ${FILES[@]} "$BUILD/$SERVERPATH"
cp -r "$TBACK/src" "$BUILD/$SERVERPATH"
pushd "$BUILD/$SERVERPATH" >/dev/null
	composer install --no-dev -n --no-suggest --classmap-authoritative --optimize-autoloader
popd >/dev/null
rm -f "$BUILD/composer.json" "$BUILD/composer.lock"

echo "Building client..."
pushd "$TFRONT" >/dev/null
	grunt
popd >/dev/null
mkdir "$BUILD/dist"
cp "$TFRONT/dist/all.js" "$BUILD/dist"
cp "$TFRONT/index.html" "$TFRONT/main.css" "$BUILD"

echo "Done! Edit '$BUILD/server/db.php' if necessary, and upload '$BUILD'"
