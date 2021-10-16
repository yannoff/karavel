#!/bin/bash
#
# Laradoc remote install script
#

tarball=/tmp/laradoc.tbz2

_grey(){
    echo -ne "\033[01;30m"
}

_clr(){
    echo -ne "\033[00m"
}

_err(){
    echo "An error occurred. Exiting"
    exit 2
}

_exe(){
    _grey
    "$@"
    ret=$?
    _clr
    if [ "$ret" -ne "0" ]; then _err; fi
}

# Check that curl is installed, exit if not present
if ! command -v curl 2>/dev/null 1>&2
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
echo "Downloading laradoc latest tarball..."
_exe curl -L -o ${tarball} https://github.com/yannoff/laradoc/releases/latest/download/laradoc.tbz2

# Extract the files to the current dir
echo "Extracting laradoc assets from tarball..."
_exe tar -xvjf ${tarball}

# Cleanup
echo "Removing tarball..."
_exe rm -v ${tarball}

# Source the current project .env file
echo "Sourcing project's dotenv file..."
source .env

# If the DB_CONNECTION env var is not set, fallback to "mysql" as db server
_grey
if [ -z "${DB_CONNECTION}" ]
then
    echo "Could not guess database driver from the DB_CONNECTION env var."
    echo "Using the docker-compose.mysql.yaml file for db server config."
    DB_CONNECTION=mysql
else
    echo "DB_CONNECTION=${DB_CONNECTION}"
fi
_clr

# Symlink the database service docker-compose config file as override
echo "Symlinking: ln -s docker-compose.${DB_CONNECTION}.yaml docker-compose.override.yaml"
_grey
ln -s docker-compose.${DB_CONNECTION}.yaml docker-compose.override.yaml
_clr

echo "Laradoc assets install completed."
