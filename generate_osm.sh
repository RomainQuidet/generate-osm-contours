#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function generate_pbf() {
    local poly_file="$1"

    phyghtmap --version
	phyghtmap --max-nodes-per-tile=0 \
			-s $CONTOUR_STEP \
			-0 \
			--pbf \
			--polygon="$poly_file" \
			--source=view1,view3,srtm3 \
			--earthexplorer-user="$USER" \
			--earthexplorer-password="$PASSWORD"
	mv *.pbf "$IMPORT_DIR"/
}

function generate_osm_with_first_poly() {
	if [ -z "$USER" ]; then
		echo "no USER found, please add one in env file .earthexplorerCredentials"
		echo "USER=xxxx"
		echo "If you do not yet have an earthexplorer login, visit https://ers.cr.usgs.gov/register/ and create one"
		exit 404
	fi

	if [ -z "$PASSWORD" ]; then
		echo "no PASSWORD found, please add one in env file .earthexplorerCredentials"
		echo "PASSWORD=xxxx"
		echo "If you do not yet have an earthexplorer login, visit https://ers.cr.usgs.gov/register/ and create one"
		exit 404
	fi

    if [ "$(ls -A $IMPORT_DIR/*.poly 2> /dev/null)" ]; then
        local poly_file
        for poly_file in "$IMPORT_DIR"/*.poly; do
			generate_pbf "$poly_file"
            break
        done
    else
        echo "No poly file for import found."
        echo "Please mount the $IMPORT_DIR volume to a folder containing poly files."
        exit 404
    fi
}

generate_osm_with_first_poly
