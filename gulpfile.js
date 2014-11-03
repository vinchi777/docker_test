var gulp = require('gulp');
var less = require('gulp-less');
var path = require('path');
var rename = require('gulp-rename');
var changed = require('gulp-changed');
var tap = require('gulp-tap');
var gutil = require('gulp-util')

var less_files = 'app/assets/stylesheets/less/*.less*'
var dest = 'app/assets/stylesheets'

function do_less(f_path){
   return gulp.src(f_path)
        .pipe(less())
        .on('error',gutil.log)

}

gulp.task('less', function () {
  gulp.src(less_files)
      .pipe(changed(dest))
      .pipe(tap(function (file, t) {
        f_path = file.path
        if (path.extname(f_path) === '.erb')
          return do_less(f_path)
              .pipe(rename(path.basename(f_path, '.less.erb') + '.css.erb'))
              .pipe(gulp.dest(dest));
        else
          return do_less(f_path)
              .pipe(gulp.dest(dest));
      }))
});


gulp.task('watch', function () {
  gulp.watch(less_files, ['less']);
});

gulp.task('default', ['less', 'watch']);