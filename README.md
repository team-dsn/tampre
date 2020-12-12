# tampre

this is tampre.

## API docs
[Swagger UI](https://team-dsn.github.io/tampre/dist/index.html)

## start the server at local
use `docker-compose up -d` at the `/backend/container/` directory

## migrate django (Use these commands after docker-compose if this is first time)
`docker container exec -it django_rest_api python tampre_app/manage.py makemigrations`
`docker container exec -it django_rest_api python tampre_app/manage.py migrate`
`docker container exec -it django_rest_api python tampre_app/manage.py createsuperuser`
