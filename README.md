<!-- @format -->

# irfancoder/generate-osm-contours

Docker image to generate elevation contours pbf files.

This fork contains the following changes:

-   Package update: phyght ~~2.10~~ -> 2.23
-   Install `python3-setuptools`; a prerequisite to the updated package version
-   Added CONTOUR_STEP variable to allow for different contour heights (vertical distance between contour lines)

Credits to [Romain Quidet](https://github.com/RomainQuidet) for creating this tool.

## What does this do?

This is a tool to help generate elevation contours for a map! The resulting output would later be used to create map tiles.

## Usage

You'll need to register to https://ers.cr.usgs.gov/register/ in order to allow phyghtmap to download elevation data. It's free.

Once you have your user and login, create a file named .earthexplorerCredentials in the root directory of the repo with the content:

```
USER=your_user_name
PASSWORD=your_password
CONTOUR_STEP=20         // in feet
```

and pass it to the docker run as environment file.

You'll need to pass to the image a volume where stands your .poly file defining the area you need to create.

```
--mount source=my_directory,target=/import
```

In my_directory directory, download from http://download.geofabrik.de/ a poly file the image will use.

And just run the image

```
docker run --rm --env-file=.earthexplorerCredentials --mount source=my_directory,target=/import generate-osm-contours:1.0
```

### Output

The image will generate a pbf of contours data in OSM format, thanks to http://katze.tfiu.de/projects/phyghtmap/
