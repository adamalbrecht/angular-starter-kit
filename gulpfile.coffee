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
config =
  devServerPort: 9000 # If you change this, you must also change it in protractor-conf.js

paths =
  app:
    scripts: ["app/js/app.{coffee,js}", "app/js/**/*.{coffee,js}"] # All .js and .coffee files, starting with app.coffee or app.js
    styles: "app/css/**/*.{scss,css}" # css and scss files
    pages: "app/pages/*.{html,jade,md,markdown}" # All html, jade,and markdown files that can be reached directly
    templates: "app/templates/**/*.{html,jade,md,markdown}" # All html, jade, and markdown files used as templates within the app
    images: "app/img/*.{png,jpg,jpeg,gif}" # All image files
    static: "app/static/*.*" # Any other static content such as the favicon

  vendor:
    scripts: [
      "vendor/bower/jquery/dist/jquery.js"
      "vendor/bower/lodash/dist/lodash.js"
      "vendor/bower/angular/angular.js"
      "vendor/bower/angular-ui-router/release/angular-ui-router.js"
      "vendor/bower/angular-bootstrap/ui-bootstrap.js"
      "vendor/bower/angular-bootstrap/ui-bootstrap-tpls.js"
    ]
    styles: [] # Bootstrap and Font-Awesome are included using @import in main.scss
    fonts: "vendor/bower/font-awesome/fonts/*.*"


# SCRIPT-RELATED TASKS
# =================================================
# Compile, concatenate, and (optionally) minify scripts
# Also pulls in 3rd party libraries and convertes
# angular templates to javascript
# =================================================
# Gather 3rd party javascripts
compileVendorScripts = -> gulp.src(paths.vendor.scripts)

# Gather and compile App Scripts from coffeescript to JS
compileAppScripts = ->
  coffeestream = coffee({bare:true})
  coffeestream.on('error', gutil.log)
  appscripts = gulp.src(paths.app.scripts)
    .pipe(gulpif(/[.]coffee$/, coffeestream))
    .pipe(ngmin())

# Templates are compiled into JS and placed into Angular's
# template caching system
compileTemplates = ->
  templates = gulp.src(paths.app.templates)
    .pipe(gulpif(/[.]jade$/, jade()))
    .pipe(gulpif(/[.]md|markdown$/, markdown()))
    .pipe(htmlify())
    .pipe(templateCache({
        root: "/templates/"
        standalone: false
        module: "starter-app"
      }))

# Concatenate all JS into a single file
# Streamqueue lets us merge these 3 JS sources while maintaining order
concatenateAllScripts = ->
  streamqueue({objectMode: true}, compileVendorScripts(), compileAppScripts(), compileTemplates())
    .pipe(concat("app.js"))

# Compile and concatenate all scripts and write to disk
buildScripts = (buildPath="generated", minify=false) ->
  scripts = concatenateAllScripts()

  if minify
    scripts = scripts
      .pipe(uglify())

  scripts
    .pipe(gulp.dest("#{buildPath}/js/"))
    .pipe(connect.reload()) # Reload via LiveReload on change

gulp.task "scripts", -> buildScripts()
gulp.task "deploy_scripts", -> buildScripts("deploy", true)
# =================================================



# STYLSHEETS
# =================================================
# Compile, concatenate, and (optionally) minify stylesheets
# =================================================
# Gather CSS files and convert scss to css
compileCss = ->
  gulp.src(paths.app.styles)
    .pipe(gulpif(/[.]scss$/,
      sass({
        sourcemap: false,
        unixNewlines: true,
        style: 'nested',
        debugInfo: false,
        quiet: false,
        lineNumbers: true,
        bundleExec: true,
        loadPath: ["vendor/bower/twbs-bootstrap-sass/assets/stylesheets/"]
      })
      .on('error', gutil.log)
    ))

# Compile and concatenate css and then write to disk
buildStyles = (buildPath="generated", minify=false) ->
  styles = compileCss()
    .pipe(concat("app.css"))

  if minify
    styles = styles
      .pipe(minifyCSS())

  styles
    .pipe(gulp.dest("#{buildPath}/css/"))
    .pipe(connect.reload()) # Reload via LiveReload on change

gulp.task "styles", -> buildStyles()
gulp.task "deploy_styles", -> buildStyles("deploy", true)
# =================================================


# HTML PAGES
# =================================================
# Html pages are root level pages. They can be either
# html, jade, or markdown
# =================================================
# Gather jade, html, and markdown files
# and convert to html. Then make them html5 valid.
compilePages = ->
  gulp.src(paths.app.pages)
    .pipe(gulpif(/[.]jade$/, jade()))
    .pipe(gulpif(/[.]md|markdown$/, markdown()))
    .pipe(htmlify())

# Moves html pages to generated folder
buildPages = (buildPath="generated", minify=false) ->
  pages = compilePages()

  if minify
    pages = pages
      .pipe(minifyHTML())

  pages
    .pipe(gulp.dest(buildPath))
    .pipe(connect.reload()) # Reload via LiveReload on change

gulp.task "pages", -> buildPages()
gulp.task "deploy_pages", -> buildPages("deploy", true)
# =================================================



# IMAGES
# =================================================
# Gather and compress images
compressImages = ->
  gulp.src(paths.app.images)
    .pipe(imagemin({
      progressive: true,
      svgoPlugins: [{removeViewBox: false}],
      use: [pngcrush()]
    }))
# Optimize and move images
buildImages = (buildPath="generated") ->
  compressImages()
    .pipe(gulp.dest("#{buildPath}/img/"))
    .pipe(connect.reload()) # Reload via LiveReload on change

gulp.task "images", -> buildImages()
gulp.task "deploy_images", -> buildImages("deploy")
# =================================================

# FONTS
# =================================================
# Move 3rd party fonts into the build folder
# =================================================
buildFonts = (buildPath="generated") ->
  gulp.src(paths.vendor.fonts)
    .pipe(gulp.dest("#{buildPath}/fonts/"))

gulp.task "fonts", -> buildFonts()
gulp.task "deploy_fonts", -> buildFonts("deploy")
# =================================================

# STATIC CONTENT TASKS
# =================================================
# Move content in the static folder
buildStatic = (buildPath="generated") ->
  gulp.src(paths.app.static)
    .pipe(gulp.dest("#{buildPath}/static/"))
    .pipe(connect.reload()) # Reload via LiveReload on change

gulp.task "static", -> buildStatic()
gulp.task "deploy_static", -> buildStatic("deploy")
# =================================================

# CLEAN
# =================================================
# Delete contents of the build folder
# =================================================
gulp.task "clean_deploy", ->
  return gulp.src(["deploy"], {read: false})
    .pipe(clean({force: true}))
gulp.task "clean", ->
  return gulp.src(["generated"], {read: false})
    .pipe(clean({force: true}))
# =================================================


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
gulp.task 'server', ->
  connect.server({
    root: ['generated'],
    port: config.devServerPort,
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

gulp.task 'deploy', ['clean_deploy'], ->
  gulp.start("deploy_scripts", "deploy_styles", "deploy_pages", "deploy_images", "deploy_fonts", "deploy_static")

gulp.task "default", ["clean"], ->
  gulp.start("scripts", "styles", "pages", "images", "fonts", "static", "server", "watch")
