$(document).on('submit', '#new_call', function(){
  ym(37371855, 'reachGoal', 'order_call');
});

$(document).on('click', 'chat-link', function(){
  ym(37371855, 'reachGoal', 'chat_link');
});

$(document).on('turbolinks:before-visit', function () {
  window.turbolinks_referer = location.href;
});

$(document).on('turbolinks:load', function () {
  if (window.turbolinks_referer) {
    ym(37371855, 'hit', location.href, {
      title: $('title').html(),
      referrer: window.turbolinks_referer
    });
    ym(37371855, 'notBounce');
  };
});