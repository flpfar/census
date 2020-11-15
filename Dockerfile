FROM ruby:2.7.1

ENV INSTALL_PATH /census

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install
ADD . $INSTALL_PATH
RUN bin/setup
