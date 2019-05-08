FROM ruby:2.6.1
MAINTAINER Luis Arantes <luis.arantes.sp@gmail.com>

RUN gem install bundler

ENV APP_HOME /multiplayer
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME