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
//= require turbolinks
//= require_tree .

setTimeout(function(){
  if(!Cookies.get('popup')){
    $('#call-modal').modal('show');
    Cookies.set('popup', 'true')
  }
}, 70000)


var ready = function(){
  if($('body').attr('data-loaded') == 'T'){
    return;
  }
  fixedMenu();
  slickGallery();
  paginate();
  toTop();
  respMenu();
  fullPage();
  share();
  FontAwesome.dom.i2svg();
  $('body').attr('data-loaded', 'T')
  }



var fixedMenu = function(){
  if ($('#menu').length){
    var top = $('#menu').offset().top;
    $(window).scroll(function(){
      var currentScroll = $(window).scrollTop();
      if (currentScroll >= top){
        $('#menu-fixed').addClass('d-lg-block');
      }else{
        $('#menu-fixed').removeClass('d-lg-block');
      }
    });
  }
}

var respMenu = function(){
  $('#icon-wrapper').click(function(){
    $('#resp-menu').toggle('slide',300);
    $(this).find('[data-fa-i2svg]').toggleClass('fa-bars fa-times', 300);
    // $('.resp-menu-bar').toggleClass('bg-teal', 150);
    FontAwesome.dom.i2svg();
  });
}

var fullPage = function(){
  if ($('#fullpage').length){
    $('#fullpage').fullpage({
      menu: '#business-menu',
      anchors: ['main', 'out', 'in', 'print', 'contact-us'],
      navigation: true,
      scrollOverflow: true,
      responsiveWidth: 600
    });
  }

};

var destroyFullpage = function(){
  $.fn.fullpage.destroy('all')
}

var share = function(){
  $('#vk_share').html(VK.Share.button(false,{
    type: 'custom',
    text: '<i class="fab fa-vk mr-2"></i>Поделиться'
  }))
}

document.addEventListener('turbolinks:load', ready);
document.addEventListener('ready', ready)
