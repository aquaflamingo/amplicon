FROM ruby:2.7.2-alpine

# Update the installer
RUN apk update -qq && apk upgrade

# Install Deps
RUN apk add --no-cache \
	 # Necesssary
	 build-base \
	 postgresql-dev \
   postgresql-client \
	 nodejs yarn tzdata \
	 vim bash

RUN gem install bundler --version '~> 2.1.0'

# Create that directory in the base image
WORKDIR /usr/src/app

# Copy gemfile before 
COPY Gemfile* ./
RUN bundle install

# Copy all files then yarn 
COPY . .
RUN yarn install --check-files

# App
EXPOSE 3000
