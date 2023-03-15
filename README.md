# Runa

Runa makes it easy to run heavy tasks on your servers from anywhere

## Setup

    $ sudo systemctl start redis
    $ sudo systemctl start postgresql
    $ curl -sSL https://get.runa.sh > runa.sh
    $ bash runa.sh server-init

    $ bash runa.sh server-exec web
    $ bash runa.sh server-exec job

## Usage

### From a web browser

Go to http://localhost:3000/tasks

### From a terminal (TODO)

    $ curl -sSL https://get.runa.sh > runa.sh

    $ bash runa.sh get --tasks
    $ bash runa.sh get --tasks --query "Awesome Task"
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526 --runs
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526 --run 42
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526 --run 42 --assets
    $ bash runa.sh get --task 7cfc2395-d6b2-468c-bb55-d61528a35526 --run 42 --asset result.csv

    $ bash runa.sh set --task "My First Awesome Task" --input task.sh
    $ bash runa.sh run --task "My First Awesome Task"

    $ bash runa.sh get --task "My First Awesome Task"
    $ bash runa.sh get --task "My First Awesome Task" --run 1
