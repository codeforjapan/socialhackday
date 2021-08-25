// gulpfile.js - https://jsua.co/mm-gulp

'use strict'; // http://www.w3schools.com/js/js_strict.asp

// 1. LOAD PLUGINS

const gulp = require('gulp');
const bourbon = require('bourbon').includePaths;
const neat = require('bourbon-neat').includePaths;
const sass = require('gulp-sass')(require('node-sass'));

var p = require('gulp-load-plugins')({ // This loads all the other plugins.
  DEBUG: false,
  pattern: ['gulp-*', 'gulp.*', 'del', 'run-*', 'browser*', 'vinyl-*'],
  rename: {
    'vinyl-source-stream': 'source',
    'vinyl-buffer': 'buffer',
    'gulp-util': 'gutil'
  },
});

// 2. CONFIGURATION

var
  src  = 'source/', // The Middleman source folder
  dest = '.tmp/',   // The "hot" build folder used by Middleman's external pipeline

  development = p.environments.development,
  production = p.environments.production,

  css = {
    in: src + 'assets/stylesheets/**/*.{css,scss,sass}',
    out: dest + 'assets/stylesheets/',
  },

  sassOpts = {
    imagePath: '../assets/images',
    includePaths: [bourbon, neat],
    errLogToConsole: true
  },

  autoprefixerOpts = {
  },

  js = {
    in: src + 'assets/javascripts/*.{js,coffee}',
    out: dest + 'assets/javascripts/'
  },

  uglifyOpts = {
    output: {
      comments: 'uglify-save-license'
    }
  },

  images = {
    in: src + 'assets/images/*',
    out: dest + 'assets/images/'
  },

  serverOpts = {
    proxy: 'localhost:4567',
    open: true,
    reloadDelay: 700,
    files: [dest + '**/*.{js,css}', src + '**/*.{html,haml,markdown}']
  };

// 3. WORKER TASKS

// CSS Preprocessing
gulp.task('css', (cb) => {
  gulp.src(css.in)
    .pipe(development(p.sourcemaps.init()))
    .pipe(sass(sassOpts).on('error', sass.logError))
    .pipe(p.autoprefixer(autoprefixerOpts)).on('error', handleError)
    .pipe(production(p.cleanCss()))
    .pipe(development(p.sourcemaps.write()))
    .pipe(gulp.dest(css.out));
  cb();
});

// Javascript Bundling
gulp.task('js', (cb) => {
  var b = p.browserify({
    entries: src + 'assets/javascripts/all.js',
    debug: true
  });

  b.bundle().on('error', handleError)
    .pipe(p.source('bundle.js'))
    .pipe(production() ? p.buffer() : p.gutil.noop())
    .pipe(production(p.stripDebug()))
    .pipe(production() ? p.uglify(uglifyOpts) : p.gutil.noop())
    .pipe(gulp.dest(js.out));
  cb();
});

// Image Optimization
gulp.task('images', (cb) => {
  console.log('images');
  gulp.src(images.in)
    .pipe(p.changed(images.out))
    .pipe(p.imagemin())
    .pipe(gulp.dest(images.out));
  cb();
});

// Clean .tmp/
gulp.task('clean', function(done) {
  p.del([
    dest + '*'
  ]);
  done();
});

// Asset Size Report
gulp.task('sizereport', (cb) => {
  gulp.src(dest + '**/*')
    .pipe(p.sizereport({
      gzip: true
    }));
  cb();
});

// 4. SUPER TASKS

// Development Task
gulp.task('development', gulp.series(
  'clean', 'images', 'css', 'js'
));

// Production Task
gulp.task('production', gulp.series('clean', 'images', 'css', 'js', 'sizereport'));

// Default Task
// This is the task that will be invoked by Middleman's exteranal pipeline when
// running 'middleman server'
gulp.task('default', gulp.series('development', () => {

  p.browserSync.init(serverOpts);

  gulp.watch(images.in, gulp.task('images'));
  gulp.watch(css.in, gulp.task('css'));
  gulp.watch(js.in, gulp.task('js'));
}));

function handleError(err) {
  console.log(err.toString());
  this.emit('end');
}
