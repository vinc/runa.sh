# Runa

Runa makes it easy to run heavy scripts on your servers and check the result from anywhere.

## Setup

### Web server

    $ sudo systemctl start redis
    $ sudo systemctl start postgresql
    $ curl -sSL https://get.runa.sh > runa.sh
    $ bash runa.sh service-init web
    $ bash runa.sh service-exec web

### Job server

    $ curl -sSL https://get.runa.sh > runa.sh
    $ bash runa.sh service-init job
    $ bash runa.sh service-exec job

## Usage

### From a web browser

Go to http://localhost:3000

### From a terminal (TODO)

    $ curl -sSL https://get.runa.sh > runa.sh

    $ bash runa.sh get --tasks
    $ bash runa.sh get --tasks --query "Awesome Task"
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526 --runs
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526 --run 42
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526 --run 42 --assets
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526 --run 42 --asset result.csv

    $ bash runa.sh set --task "My First Awesome Task" --script task.sh
    $ bash runa.sh run --task "My First Awesome Task"

    $ bash runa.sh get --task "My First Awesome Task"
    $ bash runa.sh get --task "My First Awesome Task" --run 1
