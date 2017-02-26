var gulp = require('gulp');
var concat = require('gulp-concat');
var rename = require('gulp-rename');
var uglify = require('gulp-uglify');

gulp.task('default', function() {
  gulp.src([
    './node_modules/core-js/client/shim.min.js',
    './node_modules/zone.js/dist/zone.js',
    './node_modules/systemjs/dist/system.src.js',
    './src/systemjs.config.js',
      // './src/*.js','./src/app/*.js'
    ])
    // .pipe(uglify())
    .pipe(concat('all.js'))
    .pipe(rename('all.min.js'))
    .pipe(gulp.dest('./src/'));

});
