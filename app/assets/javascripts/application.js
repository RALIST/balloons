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
//= require jquery
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
//= require common
//= require counters
//= requirer pagination
//= require social-share-button
//= require business
//= require pagination

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
  search();
  $('[data-toggle="tooltip"]').tooltip();
  $('body').attr('data-loaded', 'T')
}


var search = function() {
  $('input[name="search"]').on('keyup', function(event){
    var search = $(this).val();
    var key = event.which || event.keyCode || event.charCode;
    if(search == ''){
      $('.modal div').show();
    }else{
      $('.modal').find('.as_btn:not(:containsi("'+search+'"))').closest('div').hide();
      $('.modal').find('.as_btn:containsi("'+search+'")').closest('div').show();
    }
  });
};


var fixedMenu = function(){
  if ($('#menu').length){
    var top = $('#menu').offset().top;
    $(window).scroll(function(){
      var currentScroll = $(window).scrollTop();
      if (currentScroll >= top){
        $('#menu').addClass('fixed-top');
      }else{
        $('#menu').removeClass('fixed-top');
      }
    });
  }
}

var respMenu = function(){
  $('#icon-wrapper').click(function(){
    $('#resp-menu').toggle('slide',300);
    $(this).find('[data-fa-i2svg]').toggleClass('fa-bars fa-times', 300);
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
document.addEventListener('ready', ready);

