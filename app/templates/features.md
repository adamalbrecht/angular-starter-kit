# Features

## Package Management with Bower and NPM

The app uses [NPM](https://www.npmjs.org/) to manage developer tools and libraries. Most of these are used for compilation of the various project assets. [Bower](http://bower.io) is used to manage 3rd party, client-side libraries.

## Lodash, Angular UI-Router, Bootstrap, FontAwesome

Besides the almost standard [jQuery](), I've also included [lodash](), a nice utility library, [UI-Router](), a much better routing library for angular, [Bootstrap]() for a nice set of default styles, and the [FontAwesome]() font library. Bootstrap is supplmented by UI-Bootstrap, which is a set of directives written in pure angular.

## Project Structure

The folder structure is very simple, with several self-explanatory folders inside `app`: `css`, `js`, `templates`, `pages`, `img`, and `static`. The css folder may contain either `scss` or `css` files. Likewise, the js folder may contain either `coffee` or `js` files. The pages and templates folders may contain html, jade, or markdown files. The difference between the two folders is that files in *pages* will be simply converted to html and placed in the root directory while files in *templates* are expected to be used by your angular app and will be placed into the [template cache](https://docs.angularjs.org/api/ng/service/$templateCache). The `static` folder should contain any other type of static content, such as your favicon, other media files, etc.

Within the `app/js` folder, the best way to structure your angular app is highly debatable (organize by feature versus type of object), but for a small app, folders for controllers, services, and directives probably makes the most sense. A sample controller, directive, and service have been provided.

Within the `app/css` folder, there are [SMACSS](http://smacss.com/)-esque folders named `base`, `layout`, and `modules`. Scss partials should be placed here and imported into `main.scss`.

Third-party libraries should be placed in the `vendor` folder. Those managed by Bower are in `vendor/bower`.

## Sample Angular Code

There is sample code to demonstrate routing with UI-Router, as well as simple examples an Angular controller, service, and directive, along with unit tests for each. There is also a basic e2e test using Protractor.

## Asset Compilation & Concatenation

[Gulp.js](http://gulpjs.com/), along with an array of plugins, are used to compile and concatenate all of the assets before placing them into the `generated` folder. All of this logic can be found in `gulpfile.coffee`. All JS, including vendor libraries, are compiled into a single `app.js` file while all CSS is compiled into `app.css`.

## Dev Server

A lightweight dev server is provided that allows you to run your app. If you install the [LiveReload](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei?hl=en) browser extension, it will reload your app automatically when changes are detected. Also, if you need to connect to a an API hosted by another project, there is an API proxying feature to connect to it.

## Testing
