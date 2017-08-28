## Overview

"how many stars?" is a movie review site built in Ruby on Rails from scratch, utilizing [TMDB](https://developers.themoviedb.org)'s API to generate information about movies. In addition to featuring popular movies on the front page, "how many stars?" allows users to discover movies through sorting by title and release date and filtering by genres. There is also a search function for additional ease of use.

## Prerequisites

The following are necessary for "how many stars?" to run:
* Ruby 2.4.0 and Bundler
* PostgreSQL 9.6

In addition, for running the browser-based tests:
* PhantomJS

## Dependencies

Dependencies are managed by Bundler.

To install the dependencies, run:

    bundle install
    
## Configuration

Development configuration is set by default. Production configuration is largely loaded from the environment.

## Database

To create a set of databases for development and testing:

    rake db:create

To migrate to the latest version of the schema for development:

    rake db:migrate

And for tests:

    RAILS_ENV=test rake db:migrate

## Testing

There are primarily three types of tests:

  * Unit tests
  * Integration tests
  * Acceptance tests

Unit tests are the lowest level, generally testing one piece of code,
with most external interactions stubbed.

Integration tests exercise many layers of the stack, and are generally
written at the controller level, exercising one or more HTTP requests.

Acceptance tests run in a headless browser, emulating the user's
perspective of the app.

Test data is loaded via Rails' built-in fixtures feature.

The application uses a handful of helper libraries in testing:

  * Capybara, a DSL for writing acceptance tests
  * VCR, for recording external HTTP requests

To run the usual test suite:

    rails test
    
To run the system tests:

    rails test:system

To run a single test:

    rails test test/models/review_test.rb

To run a test at a particular line:

    rails test test/models/review_test.rb:22
    
## Deployment

The application is deployed on Heroku. There is currently one application:

* `how-many-stars` (production)
