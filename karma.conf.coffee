module.exports = (config) ->
  config.set
    autoWatch: true
    frameworks: ['jasmine']
    browsers: ['PhantomJS']
    preprocessors: {
      '**/*.coffee': ['coffee'],
    }
    coffeePreprocessor: {
      options: {
        bare: true,
        sourceMap: false
      }
      transformPath: (path) -> path.replace(/\.js$/, '.coffee')
    }
    files: [
      "vendor/bower/jquery/jquery.js"
      "vendor/bower/lodash/dist/lodash.js"
      "vendor/bower/angular/angular.js"
      "vendor/bower/angular-mocks/angular-mocks.js"
      "vendor/bower/angular-ui-router/release/angular-ui-router.js"
      "vendor/bower/angular-bootstrap/ui-bootstrap.js"
      "vendor/bower/angular-bootstrap/ui-bootstrap-tpls.js"
      "app/js/app.coffee"
      "app/js/**/*.coffee"
      "spec/**/*.coffee"
    ]
