FROM python:3.7
ENV PYTHONUNBUFFERED 1
RUN mkdir /django_rest_api
WORKDIR /django_rest_api
ADD . /django_rest_api
RUN pip install -r django_rest_api/requirements.txt
