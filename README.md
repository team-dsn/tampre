# tampre

:gift: *tampre* project :gift:

Give gifts easily to your family and friends!

## API docs
[Swagger UI](https://team-dsn.github.io/tampre/dist/index.html)

## Getting started
1. clone this project.

1. build docker image

```console
$ cd tampre/backend/containers
$ docker-compose build
$ docker-compose up -d
```

1. migrate django

```console
$ docker container exec -it django_rest_api python tampre_app/manage.py makemigrations
$ docker container exec -it django_rest_api python tampre_app/manage.py migrate
```
