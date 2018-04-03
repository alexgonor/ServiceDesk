FROM ruby:2.4.2

RUN apt-get update && apt-get -y install curl git nano

RUN mkdir /service_desk
WORKDIR /service_desk

ADD Gemfile /service_desk/
ADD Gemfile.lock /service_desk/

RUN cd /service_desk && bundle install

RUN apt-get -y install nodejs

ADD . /service_desk/
