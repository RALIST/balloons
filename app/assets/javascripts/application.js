//= require jquery3
//= require popper
//= require jquery_ujs
//= require bootstrap/util
//= require bootstrap/modal
//= require bootstrap/dropdown
//= require bootstrap/tooltip
//= require bootstrap/popover
//= require bootstrap/collapse
//= require bootstrap/tab
//= require turbolinks
//= require jquery.maskedinput
//= require bootstrap-clockpicker.min
//= require cookies
//= require common
//= require pagination
//= require ym




var ready = function(){
  if(!($('body').attr('data-loaded') == 'T')) {
    paginate();
    toTop();
    search();
    tooltip_init();
    $('body').attr('data-loaded', 'T');
  } else {
    return;
  }
};


var search = function(){
  $("input[name='search']").on('keyup touchend', function(e){
    if( e.key == 8 || e.key == 46 ){
      return false;
    };
    var text = $("input[name='search']").val();
    console.log(text);
    if(text.length){
      $('.as_btn').not(":containsi('" + text + "')").closest('.col-6').hide();
      $(".as_btn:containsi('" + text + "')").closest('.col-6').show();
    }else{
      $('.as_btn').closest('.col-6').show();
    }

  });
};

var tooltip_init = function(){
  $('[data-toggle="tooltip"]').tooltip({
    html: true,
    animated: 'fade',
    placement: 'bottom'
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
    $(this).click(function(){
      $('#business-menu ul li a').removeClass("active");
      currLink.addClass("active");
    });
  });
}

$(document).on('turbolinks:load', ready);
$(document).ready(ready)

