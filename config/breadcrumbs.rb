crumb :root do
  link "\u0413\u043B\u0430\u0432\u043D\u0430\u044F", root_path
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

crumb :tag do |tag|
  link tag.name.capitalize, tag_path(tag)
end

crumb :receiver do |p|
  link p.title.capitalize, receiver_path(p)
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
  link 'Выпускной из садика', kg_path
  parent :root
end

crumb :school do
  link 'Выпускной из школы', school_path
  parent :root
end

crumb :cart do
  link 'Корзина', my_cart_path
  parent :root
end
