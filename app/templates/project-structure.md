# Project Structure

```
app/
  css/               --> .css and .scss files. It is recommended to import each scss file into main.scss.
  img/               --> image assets
  js/
    controllers/
    directives/
    services/
    app.coffee       --> Initialize your angular app and inject dependencies
    routes.coffee    --> Setup your app's routes
  pages/             --> .html, .jade, and .md files that are intended to be standalone html files
  static/            --> Any other static content that doesn't make sense in the other folders
  templates/         --> .html, .jade, and .md files that are templates for your angular app. Will be saved into the template cache.
  generated/         --> Compiled assets. Don't make changes here because they will be overwritten
  node_modules/      --> NPM packages are stored here
  spec/
    unit/            --> Unit tests using jasmine
    e2e/             --> E2E tests using jasmine and protractor
  vendor/            --> 3rd party libraries
    bower/           --> libraries managed by bower will be placed here
    css/
    img/
    js/
  bower.json         --> Bower packages specified in here
  Gemfile            --> Version of SASS is specified here
  gulpfile.coffee    --> Manages asset compilation, dev server, etc
  karma.conf.coffee  --> Karama test runner config (for unit tests)
  package.json       --> NPM packages specified in here
  protractor-conf.js --> Karama test runner config (for unit tests)
```
