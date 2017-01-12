# Description: Server configuration for the project (excluding database)
#              It runs on Ubuntu, so do what you like below.
#
# NOTE: YOU PROBABLY DON'T HAVE TO MODIFY THIS FILE MUCH
#
# Company: Speko Technologies
# Author: Spencer kotowick

FROM ruby:2.3.1

# Install dependencies
RUN apt-get update
RUN apt-get install libqt4-dev libqtwebkit-dev -y
RUN gem install bundler

# Install npm
RUN apt-get install npm -y && npm install bower -g && ln -s /usr/bin/nodejs /usr/bin/node

# Install bower
RUN npm install bower -g

# Cache Gemfile
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install

# Create the directory where the application data will live
RUN mkdir -p /webapp

# Change to project location
WORKDIR /webapp

# Set the instruction that runs the application
CMD ["rails", "server", "puma", "--binding", "0.0.0.0"]
