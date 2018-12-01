# Getting Started

To get the Rails server running locally:

* Clone this repo
* `bundle install` to install the dependencies
* `rails db:migrate` to make all database migrations
* `rails db:seed` to fill the database with seed data (note that this can take quite long)
* `rails server` to start the local server

# Ruby version

The application has been tested with ruby 2.5.1

# Dependencies

The code uses a local gem, has_unique_identifier, that can be found
under lib/has_unique_identifier.  The gem has its own testsuite.

# Tests

To run tests:

```
rspec
```

If you don't have a test database yet, create it like you did the dev database:

```
rails db:migrate RAILS_ENV=test
```
