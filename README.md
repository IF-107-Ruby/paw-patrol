# Room Passport

[![Build Status](https://travis-ci.com/IF-107-Ruby/paw-patrol.svg?branch=master)](https://travis-ci.com/github/IF-107-Ruby/paw-patrol)

__Room passport__ is a project for monitoring and reporting problems that arise in the office. 
Since we live in a digital world, we need to digitalize these processes so that we can track 
trends and improve the comfort of office work.

## Prerequisites

To run the project you need:

* Ruby `v.2.7.1`
* Node.js
* Yarn
* PostgreSQL 
* Redis server

## Installation

To installation the project you need to run following commands:

* Run `bundle`
* Run `rails db:migrate`
* Run `rails db:seed`
* Start `redis-server`
* In project folder run `bundle exec sidekiq`
* Run `gem install mailcatcher` then `mailcatcher` to get started
* Run `rails s`

Running server should appear at `localhost:3000`

To run tests use `bundle exec rspec`