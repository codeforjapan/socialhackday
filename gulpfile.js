var gulp           = require('gulp'), // Gulp
    sass           = require('gulp-sass'), // SASS,
    changed        = require('gulp-changed'),
    autoprefixer   = require('gulp-autoprefixer'); // Add the desired vendor prefixes and remove unnecessary in SASS-files


//
// SASS
//

// Unify Main
gulp.task('sass', function() {
  return gulp.src('./assets/include/scss/**/*.scss')
    .pipe(changed('./assets/css/'))
    .pipe(sass({outputStyle:'expanded'}))
    .pipe(autoprefixer(['last 3 versions', '> 1%'], { cascade: true }))
    .pipe(gulp.dest('./assets/css/'))
});

gulp.task('watch', function() {
  gulp.watch('./html/assets/include/scss/**/*.scss', ['sass']);
});


//
// Default
//

gulp.task('default', ['watch', 'sass']);
