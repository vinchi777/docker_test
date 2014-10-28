var gulp = require('gulp');
var less = require('gulp-less');
var path = require('path');
var rename = require('gulp-rename');
var changed = require('gulp-changed');
var tap = require('gulp-tap');

var less_files = 'app/assets/stylesheets/less/*.less*'
var dest = 'app/assets/stylesheets'

gulp.task('less', function () {
  gulp.src(less_files)
      .pipe(changed(dest))
      .pipe(tap(function (file, t) {
        if (path.extname(file.path) === '.erb') {
          return gulp.src(file.path)
              .pipe(less())
              .pipe(rename(path.basename(file.path, '.less.erb') + '.css.erb'))
              .pipe(gulp.dest(dest));
        } else {
          return gulp.src(file.path)
              .pipe(less())
              .pipe(gulp.dest(dest));
        }
      }))
});

gulp.task('watch', function () {
  gulp.watch(less_files, ['less']);
});

gulp.task('default', ['less', 'watch']);