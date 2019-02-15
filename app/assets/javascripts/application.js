//= require jquery
//= require popper
//= require jquery_ujs
//= require bootstrap
//= require jquery.maskedinput
//= require clockpicker
//= require cookies
//= require jquery.slick
//= require social-share-button
//= require loadCSS
//= require cssrelpreload
//= require onloadCSS
//= require turbolinks
//= require common
//= require counters
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
  // fixedMenu();
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
};


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


var respMenu = function(){
  $('#icon-wrapper').click(function(){
    $('#resp-menu').slideToggle();
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

