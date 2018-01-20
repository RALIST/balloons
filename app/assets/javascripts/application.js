// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= reqiuire jquery
//= require jquery3
//= require popper
//= require jquery_ujs
//= require tether
//= require bootstrap
//= require jquery.maskedinput
//= require clockpicker
//= require jquery-ui/widgets/slider
//= require jquery-ui/effect.all
//= require jquery.ui.touch-punch
//= require cookies
//= require jquery.slick
//= require social-share-button
//= require loadCSS
//= require cssrelpreload
//= require onloadCSS
//= require_tree .

setTimeout(function(){
  if(!Cookies.get('popup')){
    $('#call-modal').modal('show');
    Cookies.set('popup', 'true')
  }
}, 70000)

$(document).ready(function(){
  $('body, html').scrollTop(0);
})
