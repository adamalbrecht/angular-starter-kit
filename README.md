# Angular Starter Kit

This is an opinionated starter template for crafting single-page web applications using Angular.js, Coffeescript, SCSS, Jade, Bootstrap, UI-Router, Font-Awesome and a few other carefully picked tools that help kick-start web app development. To compile your app, it uses [Gulp.js](http://gulpjs.com) and a number of pre-processors, plugins, and utilities.

## Getting Started

1. I highly recommend that you read through `gulpfile.coffee`. It's relatively simple and will help you understand how the assets are being compiled in case you run into any issues.
2. Install dependencies: [NPM](http://npmjs.org), [Ruby](https://www.ruby-lang.org/en/), [Bundler](http://bundler.io/), [PhantomJS](http://phantomjs.org/download.html)
3. Clone the repository
4. Run `bundle install`. This will install the version of [SASS](http://sass-lang.com/) specified in the Gemfile.
5. Run `npm install`
6. Run `bower install`
7. Run `gulp` in one shell. This will watch your files, auto-compile them, and start a local server.
8. Run `npm run test` in another shell. This will automatically run your unit tests.
9. Install [LiveReload](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=en) (optional)
10. Open your browser to [http://localhost:9000](http://localhost:9000).
11. This site is the default code and the documentation. I suggest checking out the sample code page, but then you just need to remove what you don't want and replace this content with your own. Have fun!

## Deploying for Production

If you run `gulp deploy`, it will compile all the assets and also minify them and then place them into the `deploy` directory.

## Running E2E Tests

1. `npm install -g protractor` - Install Protractor globally
2. `webdriver-manager update` - Installs the Selenium web driver required to run protractor tests. It may ask you to install the Java Development Kit, which is required.
3. `npm run e2e` - This will run the e2e tests. Because these tests are fairly slow, they are not setup to auto-run on file changes.

## Demo

You can see what the initial template looks like here: [Demo](http://adamalbrecht.github.io/angular-starter-kit/)

## To-Do

1. Task to compile for production that minifies all the code and places in a "deploy" directory
2. Use cache-busting filenames for production mode
