#!/bin/bash
#
# Laradoc remote install script
#

zipball=/tmp/laradoc.zip

# Check that curl is installed, exit if not present
if [ ! command -v curl ]
then
    echo "This install script needs curl to be installed. Exiting."
    exit 1
fi

# Check there is a .env file
if [ ! -f .env  ]
then
    echo "There is no .env file.\nPlease provide one, for instance using the sample file:\ncp .env.example .env"
    exit 1
fi

# Download latest respository archive
curl -L -o ${zipball} https://github.com/yannoff/laradoc/archive/refs/heads/main.zip && \
# Extract the files to the current dir
unzip ${zipball} && \
# Cleanup
rm ${zipball}

# Source the current project .env file
source .env

# If the DB_CONNECTION env var is not set, fallback to "mysql" as db server
if [ -z "${DB_CONNECTION}" ]
then
    echo "Could not guess database driver from the DB_CONNECTION env var."
    echo "Using the docker-compose.mysql.yaml file for db server config."
    DB_CONNECTION=mysql
fi

# Symlink the database service docker-compose config file as override
ln -s docker-compose.${DB_CONNECTION}.yaml docker-compose.override.yaml
