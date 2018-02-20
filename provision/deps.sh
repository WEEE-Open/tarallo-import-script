#!/bin/bash

set -e

DOCUMENT_ROOT="/var/www/html"

echo "Installing dependencies (composer)..."
pushd "$DOCUMENT_ROOT/server"
composer install
popd > /dev/null 2>&1

echo "Installing dependencies (npm)..."
npm i -g grunt
pushd "$DOCUMENT_ROOT/tarallo"
npm i
grunt
echo "Running grunt watch inside of screen... (which doesn't work BECAUSE REASONS so it's pointless)"
screen -dm bash -c "grunt watch; exec sh"
popd > /dev/null 2>&1
