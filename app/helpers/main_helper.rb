module MainHelper

  def tag_name_with_icon(tag)
    case tag.name
      when 'день рождения'
        capture do
          concat(content_tag :i,'', class: 'fas fa-birthday-cake mr-2 fa-2x')
          concat(content_tag :span, tag.name.capitalize, class: 'lead')
        end
      when  "юбилей"
      when 'свадьба'
      when 'девичник'
      when 'рождение малыша'
      when '8 марта'
      when 'вечеринка'
      when 'предложение'
      when 'сюрприз'
      when '14 февраля'
      when 'день святого валентина'
      when '23 февраля'
    end

  end
end
