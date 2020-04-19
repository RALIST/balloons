crumb :root do
  link content_tag(:i,'', class: 'fas fa-home text-info fa-lg'), root_path
end
crumb :business do
  link 'Воздушные шары для бизнеса', business_index_path
end

crumb :new_order do
  link 'Новый заказ', new_order_path
  parent :cart
end

crumb :signup do
  link 'Регистрация', new_user_path
end

crumb :signin do
  link 'Войдите', new_session_path
end

crumb :composition do |c|
  if params[:tag_id]
    link "Композиция №#{c.id}", tag_composition_path(c)
    parent :tag, Tag.friendly.find(params[:tag_id])
  elsif params[:receiver_id]
    link "Композиция №#{c.id}", receiver_composition_path(c)
    parent :receiver, Receiver.friendly.find(params[:receiver_id])
  else
    link "Композиция №#{c.id}", composition_path(c)
    parent :root
  end
end

crumb :compositions do
  link 'Все композиции', compositions_path
  parent :root
end

crumb :tags do
  link 'Праздники', tags_path
end

crumb :tag do |tag|
  link tag.name.capitalize, tag_path(tag)
  parent :tags
end

crumb :receivers do
  link 'Кому', receivers_path
end

crumb :receiver do |p|
  link p.title.capitalize, receiver_path(p)
  parent :receivers
end

crumb :products do
  link 'Гелиевые шары', products_path
end

crumb :colors do
  link 'Цвета', colors_path
  parent :products
end
crumb :color do |color|
  link color.name.capitalize, color_path(color)
  parent :colors
end

crumb :categories do
  link 'По тематике', categories_path
  parent :products
end

crumb :category do |category|
  link category.name.capitalize, category_path(category)
  parent :categories
end

crumb :forms do
  link 'Формы', forms_path
  parent :products
end

crumb :form do |form|
  link form.name.capitalize, form_path(form)
  parent :forms
end

crumb :prices do
  link 'Цены на шары', prices_path
  parent :root
end

crumb :garant do
  link 'Гарантии', garant_path
  parent :root
end

crumb :info do
  link 'Доставка и оплата', info_path
  parent :root
end

crumb :faq do
  link 'FAQ', faq_path
end

crumb :about do
  link 'О нас', about_path
  parent :root
end

crumb :contacts do
  link 'Контакты', contacts_path
  parent :root
end

crumb :feedbacks do
  link 'Отзывы', feedbacks_path
  parent :root
end

crumb :kg do
  link 'Выпускной из садика', kg_tags_path
  parent :tags
end

crumb :school do
  link 'Выпускной из школы', school_tags_path
  parent :tags
end

crumb :cart do
  link 'Корзина', my_cart_path
  parent :root
end
