<% if params[:page] %>
  $('.compositions').append('<%= j(render partial: "thumb_composition", collection: @compositions, as: :c) %>');
  <% if @compositions.next_page %>
    $('.pagination').replaceWith('<%= j(will_paginate @compositions) %>');
  <% else %>
    $(window).off('scroll');
    $('.pagination').remove();
  <% end %>
<% end %>
