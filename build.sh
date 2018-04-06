#!/bin/bash
set -e
BUILD="build"
BACKEND="tarallo-backend"

if [[ ! -d "$BACKEND" ]]; then
	echo "No backend directory ($BACKEND)"
	exit 1
fi

if [[ ! $(ls -A "$BACKEND") ]]; then
	echo "Empty backend directory ($BACKEND). Have you cloned submodules?"
	exit 1
fi

if [[ -d "$BUILD" ]]; then
	echo "Clearing target directory ($BUILD)"
	rm -rf "$BUILD"
fi
mkdir "$BUILD"

echo "Building server..."
FILES=( "$BACKEND/index.php" "$BACKEND/composer.*" )
cp ${FILES[@]} "$BUILD"
cp -r "$BACKEND/src" "$BUILD"
cp -r "$BACKEND/APIv1" "$BUILD"
cp -r "$BACKEND/SSRv1" "$BUILD"
pushd "$BUILD" >/dev/null
	composer install --no-dev -n --no-suggest --classmap-authoritative --optimize-autoloader
popd >/dev/null
rm -f "$BUILD/composer.json" "$BUILD/composer.lock"

echo "Done! Edit '$BUILD/db.php' if necessary, and upload '$BUILD'"
