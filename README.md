# Phabricator Docker

This is a dockerfile for running Phabricator on a lighttpd, mysql and php7.2-fpm stack.

It is meant to be a lightweight and easy to setup container as well as to backup and keep up to date. Advanced functionalities like extensions/repos are not supported directly. You probably wouldn't want to use this for a big company.

## Setting up

**Step 1**: Clone this repo

    git clone https://github.com/DomJob/phabricator.git

**Step 2**: Build the image

    docker build -t phabricator .

**Step 3**: Run the container

    docker-compose up -d

**Step 4**: Run upgrade script to initialize storage

    docker-compose exec phabricator upgrade

## Additional info

## Upgrading

To upgrade to the latest phabricator version:

    docker-compose exec phabricator upgrade

## Backing up

Simply copy/zip the data directory, it contains all your phabricator data and config.

## Run phabricator commands

To run a phabricator command given on their documentation, simply add `docker-compose exec phabricator` in front

For exemple, to run the command `./bin/auth recover <username>`, you would run:

    docker-compose exec phabricator ./bin/auth recover <username>

## Reloading

The following commmand will reload lighttpd and PHP:

    docker-compose exec phabricator reload
