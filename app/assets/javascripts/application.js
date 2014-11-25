// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap.min
//= require coverflow
//= require angular
//= require ui-bootstrap-tpls-0.11.2
//= require moment
//= require bootstrap-datetimepicker
//= require scrollReveal
//= require isInViewport
//= require countUp
//= require math
//= require auto_compute
//= require_self
//= require gmaps
//= require_tree .

window.has_google_map = function () {
  return typeof window.google === 'object' && window.google.maps
}

window.do_scroll = function (target) {
  if(target == undefined)
    target = $('html')
  scroll = target.offset().top - 100
  $('html, body').animate({scrollTop: scroll}, "fast")
}