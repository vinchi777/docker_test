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
//= require angular-resource
//= require ui-bootstrap-tpls-0.11.2
//= require moment
//= require bootstrap-datetimepicker
//= require scrollReveal
//= require isInViewport
//= require svg-injector
//= require_self
//= require gmaps
//= require site
//= require handlebars
//= require ember

window.has_google_map = function () {
  return typeof window.google === 'object' && window.google.maps
}

window.do_scroll = function (target) {
  if(target == undefined)
    target = $('html')
  scroll = target.offset().top - 100
  $('html, body').animate({scrollTop: scroll}, "fast")
}

window.do_scroll_x = function (container, target) {
  scroll = target.offset().left
  container.animate({scrollLeft: scroll}, "fast")
}