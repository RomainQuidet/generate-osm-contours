# Use latest Debian
FROM debian:latest
MAINTAINER "Romain Quidet <http://www.xdappfactory.com>"

# Update & install wget
RUN apt-get update -y \
 && apt-get install -y wget

# Download & install latest phyghtmap
RUN cd /tmp \
 && wget http://katze.tfiu.de/projects/phyghtmap/phyghtmap_2.10-1_all.deb \
 && ( dpkg -i phyghtmap_2.10-1_all.deb || true ) \
 && apt-get install -f -y

# Clean up APT when done
RUN apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Shared directory
VOLUME /import
ENV IMPORT_DIR=/import

# Set working directory to /app
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
ADD ./generate_osm.sh /usr/src/app

# Launch the bash script
CMD ["./generate_osm.sh"]