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
  if(!($('body').attr('data-loaded') == 'T')) {
    slickGallery();
    paginate();
    toTop();
    respMenu();
    topOnLoaded();
    smoothScroll();
    vk();
    $('[data-toggle="tooltip"]').tooltip();
    $('body').attr('data-loaded', 'T');
  } else {
    FontAwesome.dom.i2svg();
    return;
  }
};

var topOnLoaded = function() {
  $('body, html').animate({
    scrollTop : 0                       // Scroll to top of body
  }, 'fast');
};

var vk = function(){
  VK.Widgets.Group("vk_groups",
    {mode: 3, no_cover: 1, width: 'auto', wide: 2},
    55641465);
};

var respMenu = function(){
  $('#icon-wrapper').click(function(){
    $('#resp-menu').slideToggle();
    $(this).find('[data-fa-i2svg]').toggleClass('fa-bars fa-times', 300);
    FontAwesome.dom.i2svg();
  });
};

var smoothScroll = function(){
  $(document).on("scroll", onScroll);
  //smoothscroll
  $('a[href^="#"]').on('click', function (e) {
    e.preventDefault();
    $(document).off("scroll");

    $('a').each(function () {
      $(this).removeClass('active');
    })
    $(this).addClass('active');

    var target = this.hash,
      menu = target;
    $target = $(target);
    if (target.length){
      $('html, body').stop().animate({
        scrollTop: $target.offset().top + 2
      }, 500, 'slide', function () {
        window.location.hash = target;
        $(document).on("scroll", onScroll);
      });
    }
  });

};


function onScroll(event){
  var scrollPos = $(document).scrollTop();
  $('#b-menu ul li a').each(function () {
    var currLink = $(this);
    var refElement = $(currLink.attr("href"));
    if (refElement.position().top < scrollPos && refElement.position().top + refElement.height() > scrollPos) {
      $('#business-menu ul li a').removeClass("active");
      currLink.addClass("active");
    }
    else{
      currLink.removeClass("active");
    }
  });
}

$(document).on('turbolinks:load', ready);

