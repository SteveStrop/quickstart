FROM python:3.7-alpine
MAINTAINER Orella

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# permenant dependencies
RUN apk add --update --no-cache postgresql-client
# temp dependencies to install postgres
RUN apk add --update --no-cache --virtual .tmp-build-deps gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev
RUN pip install -r /requirements.txt
# remove the temp dependencies to keep container as small as possible
RUN apk del .tmp-build-deps

# the name of the django project
RUN mkdir /django-rest-framework-quickstart
WORKDIR /django-rest-framework-quickstart
COPY django-rest-framework-quickstart /django-rest-framework-quickstart

RUN adduser -D user
USER user
