# Phabricator Docker

This is a dockerfile for running Phabricator on a `lighttpd, mysql, php7.2-fpm` stack.

## Setting up

**Step 1**: Clone this repo

**Step 2**: Build the image

    docker build -t phabricator .

**Step 3**: Run the container

    docker run -d --name=phabricator \
               -p 8080:80 \
               -v /path/to/data:/var/lib/mysql \
               phabricator

You may need to change the permission of /path/to/repos to allow phabricator to read/write.

Additionally, you may want to persist `/var/repo` if you plan on using that functionality.

**Step 4**: Run initialize and upgrade scripts

    docker exec phabricator initialize
    docker exec phabricator upgrade

## Other stuff

To upgrade to the latest phabricator version:

    docker exec phabricator upgrade

To backup, copy/zip the directories /path/to/data and /path/to/repo

To run a phabricator command given on their documentationm simply add `docker exec phabricator` in front

For exemple, to run the command `./bin/auth recover <username>`, you would run:

    docker exec phabricator ./bin/auth recover <username>

If you want to reload all services:

    docker exec phabricator reload
