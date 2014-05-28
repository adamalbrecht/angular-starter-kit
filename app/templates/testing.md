# Testing

## Unit Testing

Unit testing is supported using the [Jasmine](http://jasmine.github.io/) test library and [karma](karma-runner.github.io) test runner. Angular's dependency injection support makes code fairly easy to test, even though the setup code makes them look a bit unwieldy at first. There are 3 examples of tests (for a directive, a controller, and a service) included in the `spec` directory.

And by running `karma start` in your shell, tests will be run every time your code is refreshed. Please check out the `karma.conf.coffee` file to customize it further.

## E2E Testing

E2E Testing is supported using the [Protractor]() library and there is one example test included. See the [Getting Started](#/getting-started) page for information on setting up Protractor and running the tests.
