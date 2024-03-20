#!/bin/bash

sudo mv geoOdooHelper.sh /usr/local/bin || exit

sudo chmod 777 /usr/local/bin/geoOdooHelper.sh || exit

cd ../ || exit

sudo rm -rf geoOdooHelper || exit

cd ../
