# Phabricator Docker

This is a dockerfile for running Phabricator on a lighttpd, mysql and php7.2-fpm stack.

## Setting up

**Step 1**: Clone this repo

    git clone https://github.com/DomJob/phabricator.git

**Step 2**: Build the image

    docker build -t phabricator .

**Step 3**: Run the container

    docker-compose up -d

You may need to change the permission of /path/to/repos to allow phabricator to read/write.

**Step 4**: Run initialize and upgrade scripts

    docker-compose exec phabricator upgrade

## Other stuff

To upgrade to the latest phabricator version:

    docker-compose exec phabricator upgrade

To backup, copy/zip the data directory

To run a phabricator command given on their documentation, simply add `docker-compose exec phabricator` in front

For exemple, to run the command `./bin/auth recover <username>`, you would run:

    docker-compose exec phabricator ./bin/auth recover <username>

If you want to reload the phabricator daemon, lighttpd as well as PHP:

    docker-compose exec phabricator reload
