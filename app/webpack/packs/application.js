import 'core-js/stable'
import 'regenerator-runtime/runtime'

import Rails from '@rails/ujs';
Rails.start();

import { Turbo, cable } from "@hotwired/turbo-rails"
global.Turbo = Turbo

import { YM, Goals } from '../src/js/ym.js.erb'
require('bootstrap');
require('popper.js');
import nav from '../src/js/bootstrap-better-nav';
require('../src/js/jquery.maskedinput');
require('clockpicker/dist/bootstrap-clockpicker.min');
require('../src/js/cookies.js');
require('../src/js/common.js');

const ready = function(){
  clockPicker();
  tooltip();
  dataMask();
  showMore();
  cartQuantity();
  search();
  nav();
  YM();
  Goals();
  console.log('Turbo loaded')
}

const tooltip = () => {
  $('[data-toggle="tooltip"]').tooltip()
}

const cartQuantity = () => {
  $(document).on('change','#subposition_quantity', function (e) {
    const input = this;
    if ($(input).val()){
      const form = $(input).closest('form');
      $(form).submit();
    }
  });
};

const showMore = () => {
  const more = $('#more');
  let i;
  more.hide();
  const rows = $('.item');

  if (rows.length > 4){
        more.show();
        $(rows[3]).addClass('grad-1');
        for (i = 4; i < rows.length; i++) {
          $(rows[i]).hide();
        }
        more.on('click', function(){
          for (i = 4; i < rows.length; i++) {
            $(rows[i]).toggle(100);
          }
          $(rows[3]).toggleClass('grad-1');
          $(this).find('i').toggleClass('fa-chevron-up').toggleClass('fa-chevron-down');
          $(this).toggleClass('with-grad');
          $(this).find('.small').text(function(){
            const text = $(this).text();
            return text === 'Спрятать' ? "Показать все" : "Спрятать"
          })
        });
      }
};

const clockPicker = () => {
    $('.clockpicker').clockpicker(
    {'default': 'now',
      autoclose: true,
      donetext: 'Готово!'}
    );
};

const dataMask = () => {
    $('[data-mask]').each(function(index, value){
      const element = $(value);
      element.mask($(value).data('mask'), {placeholder: '-'})
    });
};

const search = () => {
  $("input[name='search']").on('keyup touchend', function(e){
    if( e.key === 8 || e.key === 46 ){
      return false;
    }
    const text = $("input[name='search']").val();
    if(text.length){
      $('.as_btn').not(":containsi('" + text + "')").closest('.col-6').hide();
      $(".as_btn:containsi('" + text + "')").closest('.col-6').show();
    }else{
      $('.as_btn').closest('.col-6').show();
    }

  });
};

document.addEventListener("turbo:load", ready);
// document.addEventListener('ready', ready);
// document.addEventListener('load', YM())
