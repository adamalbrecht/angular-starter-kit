# Utilities
gulp = require("gulp")
streamqueue = require("streamqueue")
gutil = require("gulp-util")
clean = require("gulp-clean")
concat = require("gulp-concat")
gulpif = require('gulp-if')
templateCache = require('gulp-angular-templatecache')

# Pre-Processors
coffee = require("gulp-coffee")
sass = require("gulp-ruby-sass")
jade = require('gulp-jade')
markdown = require('gulp-markdown')

# Minification
uglify = require("gulp-uglify")
minifyHTML = require("gulp-minify-html")
minifyCSS = require("gulp-minify-css")
imagemin = require('gulp-imagemin')
pngcrush = require('imagemin-pngcrush')

# Angular Helpers
ngmin = require("gulp-ngmin")
htmlify = require('gulp-angular-htmlify')

# Dev Server
connect = require('gulp-connect')


# PATH VARIABLES
# =================================================
paths =
  app:
    scripts: ["app/js/app.{coffee,js}", "app/js/**/*.{coffee,js}"] # All .js and .coffee files, starting with app.coffee or app.js
    styles: "app/css/**/*.{scss,css}" # css and scss files
    pages: "app/pages/*.{html,jade,md,markdown}" # All html, jade,and markdown files that can be reached directly
    templates: "app/templates/*.{html,jade,md,markdown}" # All html, jade, and markdown files used as templates within the app
    images: "app/img/*.{png,jpg,jpeg,gif}" # All image files
    static: "app/static/*.*" # Any other static content such as the favicon

  vendor:
    scripts: [
      "vendor/bower/jquery/jquery.js"
      "vendor/bower/lodash/dist/lodash.js"
      "vendor/bower/angular/angular.js"
      "vendor/bower/angular-ui-router/release/angular-ui-router.js"
      "vendor/bower/angular-bootstrap/ui-bootstrap.js"
      "vendor/bower/angular-bootstrap/ui-bootstrap-tpls.js"
    ]
    styles: [] # Bootstrap and Font-Awesome are included using @import in main.scss
    fonts: "vendor/bower/font-awesome/fonts/*.*"

  build:
    scripts: "generated/js/"
    styles: "generated/css/"
    pages: "generated"
    images: "generated/img/"
    static: "generated/static/"
    fonts: "generated/fonts/"


# SCRIPT COMPILATION
# =================================================
# Combines coffeescript files from the app with
# vendor js files into css/app.js and inserts
# html templates into angular template cache
# =================================================
gulp.task "scripts", ->
  # 3rd party javascripts
  vendorscripts = gulp.src(paths.vendor.scripts)

  # App Coffeescripts
  coffeestream = coffee({bare:true})
  coffeestream.on('error', gutil.log)
  appscripts = gulp.src(paths.app.scripts)
    .pipe(gulpif(/[.]coffee$/, coffeestream))
    .pipe(ngmin())

  # Templates are compiled and placed into Angular's
  # template caching system
  templates = gulp.src(paths.app.templates)
    .pipe(gulpif(/[.]jade$/, jade()))
    .pipe(gulpif(/[.]md|markdown$/, markdown()))
    .pipe(htmlify())
    .pipe(templateCache({
        root: "/templates/"
        standalone: false
        module: "starter-app"
      }))

  # Streamqueue lets us merge these 3 JS sources while maintaining order
  # and then we concatenate them into app.js
  streamqueue({objectMode: true}, vendorscripts, appscripts, templates)
    .pipe(concat("app.js"))
    .pipe(gulp.dest(paths.build.scripts))
    .pipe(connect.reload()) # Reload via LiveReload on change


# STYLES
# =================================================
# Compiles SCSS, CSS files into css/app.css
# =================================================
gulp.task "styles", ->
  gulp.src(paths.app.styles)
    .pipe(gulpif(/[.]scss$/, sass({
      sourcemap: false,
      unixNewlines: true,
      style: 'nested',
      debugInfo: false,
      quiet: false,
      lineNumbers: true,
      bundleExec: true
    })))
    .pipe(concat("app.css"))
    .pipe(gulp.dest(paths.build.styles))
    .pipe(connect.reload()) # Reload via LiveReload on change

# MOVE HTML PAGES
# =================================================
# Moves html pages to generated folder
# =================================================
gulp.task 'pages', ->
  gulp.src(paths.app.pages)
    .pipe(gulpif(/[.]jade$/, jade()))
    .pipe(gulpif(/[.]md|markdown$/, markdown()))
    .pipe(htmlify())
    .pipe(gulp.dest(paths.build.pages))
    .pipe(connect.reload()) # Reload via LiveReload on change

# Images
# =================================================
# Optimize and move images
# =================================================
gulp.task 'images', ->
  gulp.src(paths.app.images)
    .pipe(imagemin({
      progressive: true,
      svgoPlugins: [{removeViewBox: false}],
      use: [pngcrush()]
    }))
    .pipe(gulp.dest(paths.build.images))
    .pipe(connect.reload()) # Reload via LiveReload on change

# FONTS
# =================================================
# Moves 3rd party fonts into the build folder
# =================================================
gulp.task 'fonts', ->
  gulp.src(paths.vendor.fonts)
    .pipe(gulp.dest(paths.build.fonts))

# Static
# =================================================
# Move content in the static folder
# =================================================
gulp.task 'static', ->
  gulp.src(paths.app.static)
    .pipe(gulp.dest(paths.build.static))
    .pipe(connect.reload()) # Reload via LiveReload on change

# MINFIY
# =================================================
# Minify css and js
# =================================================
# gulp.task('minify', ['js', 'css'], function() {
# return gulp.src(['generated/app.js'])
#   .pipe(uglify())
#   .pipe(concat("app.min.js"))
#   .pipe(gulp.dest('generated/js/'))
# });

gulp.task 'deploy', ['clean'], ->
  # minifiy
  gulp.start("js", "css", "pages", "images", "fonts", "static")

# CLEAN
# =================================================
# Delete contents of the build folder
# =================================================
gulp.task "clean", ->
  return gulp.src(["generated"], {read: false})
    .pipe(clean({force: true}))


# CLEAN
# =================================================
# Watch for file changes and recompile as needed
# =================================================
gulp.task 'watch', ->
  gulp.watch [paths.app.scripts, paths.app.templates, paths.vendor.scripts], ['scripts']
  gulp.watch [paths.app.styles, paths.vendor.styles], ['styles']
  gulp.watch [paths.app.pages], ['pages']
  gulp.watch [paths.app.images], ['images']
  gulp.watch [paths.vendor.fonts], ['fonts']
  gulp.watch [paths.app.static], ['static']

# LOCAL SERVER
# =================================================
# Run a local server, including LiveReload and
# API proxying
# =================================================
gulp.task 'connect', ->
  connect.server({
    root: ['generated'],
    port: 9000,
    livereload: true
    middleware: (connect, o) ->
      [
        (->
          url = require('url')
          proxy = require('proxy-middleware')
          options = url.parse('http://localhost:3000/')
          options.route = '/api' # requests to /api/* will be sent to the proxy
          proxy(options)
        )()
      ]
  })

gulp.task "compile", ["clean"], ->
  gulp.start("scripts", "styles", "pages", "images", "fonts", "static")

gulp.task "default", ["clean"], ->
  gulp.start("scripts", "styles", "pages", "images", "fonts", "static", "connect", "watch")
