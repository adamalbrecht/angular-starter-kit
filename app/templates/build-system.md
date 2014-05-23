# Build System & Pre-Processors

The code compilation is driven by [Gulp.js](http://gulpjs.com/), a streaming build server. The build process is configured in `Gulpfile.coffee` and outputted code is placed into the `generated` folder.

## Code Pre-Processors

Besides supporting vanilla html, js, and css, it supports the following pre-processors:

* [Coffeescript](http://coffeescript.org/)
* [SASS](http://sass-lang.com/) (SCSS, more specifically)
* [Jade](http://jade-lang.com) for pages, templates
* [Markdown](http://jade-lang.com) for pages, templates

## Angular-Specific Processing

* [ngmin](https://github.com/btford/ngmin) - Makes your Angular code's dependency injection compatible with jS minifiers.
* [angular-htmlify](https://github.com/pgilad/gulp-angular-htmlify) - Prepends angular attributes in your html with `data-` to make them valid HTML5.
* [Angular Template Cache](https://github.com/miickel/gulp-angular-templatecache) - Converts your templates to Javascript strings and pre-caches them so that your app doesn't need to make additional http requests.

## Image Optimization

[ImageMin](https://github.com/sindresorhus/gulp-imagemin) is used to minify images without sacrificing quality in order to reduce the payload size of your app.
