module CompositionsHelper

  def custom_url_path(obj)
    case controller.controller_name
      when 'receivers'
        if controller.action_name == 'show'
          receiver_composition_path(params[:id], obj)
        else
          composition_path(obj)
        end
    when'tags'
      if controller.action_name == 'show'
        tag_composition_path(params[:id], obj)
      else
        composition_path(obj)
      end
    else
      composition_path(obj)
    end
  end


  def cart_button(c)
    content = capture do
      link_to  add_to_cart_path(c), class: "btn btn-info btn-block add-to-cart#{c.id}", id: 'ga-add-to-cart', data: {disable_with: "<i class='fa fa-spinner fa-spin'></i>", turbolinks: false}, remote: true, method: :post, title: 'Добавить в корзину' do
        content_tag :i, '', class: 'fas fa-cart-arrow-down'
      end
    end
    content.html_safe
  end

  def added
    content = capture do
      link_to  my_cart_path, class: 'btn btn-success btn-block', title: 'В корзине' do
        content_tag :i, '', class: 'fas fa-check'
      end
    end
    content.html_safe
  end
end
