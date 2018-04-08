# generate-osm-contours
Docker image to generate elevation contours pbf files

## What for?
I've always wondered how mapbox vector tiles are created, why elevation contours are so difficult to find to build my own maps...

So I modified OpenMapTiles toolchain to build my own elevation vector tiles. 

## How to use it
It is already integrated into my Contour branch of OpenMapTiles toolchain.
Check it here: https://github.com/RomainQuidet/openmaptiles

## Standalone usage

You'll need to register to https://ers.cr.usgs.gov/register/ in order to allow phyghtmap to download elevation data. It's free.

Once you have your user and login, create a file named .earthexplorerCredentials in the root directory of the repo with the content:

```
USER=your_user_name
PASSWORD=your_password
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

It is configured to generate 10m steps lines.
