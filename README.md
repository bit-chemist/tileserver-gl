![tileserver-gl](https://cloud.githubusercontent.com/assets/59284/18173467/fa3aa2ca-7069-11e6-86b1-0f1266befeb6.jpeg)


# TileServer GL
[![Build Status](https://travis-ci.org/klokantech/tileserver-gl.svg?branch=master)](https://travis-ci.org/klokantech/tileserver-gl)
[![Docker Hub](https://img.shields.io/badge/docker-hub-blue.svg)](https://hub.docker.com/r/klokantech/tileserver-gl/)

Vector and raster maps with GL styles. Server side rendering by Mapbox GL Native. Map tile server for Mapbox GL JS, Android, iOS, Leaflet, OpenLayers, GIS via WMTS, etc.

## Using Docker

An alternative to npm to start the packed software easier is to install [Docker](http://www.docker.com/) on your computer and then run in the directory with the downloaded MBTiles the command:

Clone the repository:
```
git clone git@github.com:Rapid-Imaging-Tech/tileserver-gl.git
```
or
```
git clone https://github.com/Rapid-Imaging-Tech/tileserver-gl.git
```

Build the tileserver-gl docker image with the following command:
```
docker build -t tileserver-gl .
```

To run the docker image, you will need to change into the data directory where the MBTiles files live (or the directory where the Switzerland test file will download)
```
cd your-data-directory-path
```

Run the docker image locally with the following command in a terminal. 

```bash
docker run --rm -it -v $(pwd):/data -p 8080:8080 tileserver-gl
```

This will run the image with the following options:  
`--rm` (removes the container upon exit)  
`-it` (allocates a psudo TTY)  
`-v $(pwd):/data`  (mounts a host directory to a container directory pattern: host-dir:container-dir)  
`-p 8080:8080` (binds a host port to a container port - pattern: host-port:container-port)  
`tileserver-gl` (this is the name of the container you built in the previous step)  
  
You will find the server at `http://localhost:8080/`  
Logging will be output to the terminal
  
To exit the server issue CTRL-C in the terminal

## Local Install

Make sure you have Node.js version **6** installed (running `node -v` it should output something like `v6.11.3`).

Install `tileserver-gl` with server-side raster rendering of vector tiles with npm

```bash
npm install -g tileserver-gl
```

Now download vector tiles from [OpenMapTiles](https://openmaptiles.org/downloads/).

```bash
curl -o zurich_switzerland.mbtiles https://[GET-YOUR-LINK]/extracts/zurich_switzerland.mbtiles
```

Start `tileserver-gl` with the downloaded vector tiles.

```bash
tileserver-gl zurich_switzerland.mbtiles
```

Alternatively, you can use the `tileserver-gl-light` package instead, which is pure javascript (does not have any native dependencies) and can run anywhere, but does not contain rasterization on the server side made with MapBox GL Native.

## Documentation

You can read full documentation of this project at http://tileserver.readthedocs.io/.
