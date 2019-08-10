# Phabricator Docker

This is a dockerfile for running Phabricator on a `lighttpd, mysql, php7.2-fpm` stack.

## Setting up

Step 1.

Clone this repo

Step 2.

Build the image

    docker build -t phabricator .
    
Step 3.

Run the container
    
    docker run -d --name=phabricator
               -p 8080:80
               -v /path/to/data:/var/lib/mysql 
               -v /path/to/repo:/var/repo
               phabricator

You may need to change the permission of /path/to/repos to allow phabricator to read/write.
    
Step 4.

Run upgrade script at least once to initialize the database

    docker exec phabricator upgrade
    
## More info

To upgrade, simply do step 4.

To backup, simply copy/zip the directories /path/to/data and /path/to/repo

To run a phabricator command given on their documentation, for exemple `./bin/auth recover <username>`, you simply run:

    docker exec phabrictor ./bin/auth recover <username>
