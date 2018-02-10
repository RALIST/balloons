module ApplicationHelper
  def show_errors(object, field_name)
    if object.errors.any?
      if object.errors.messages[field_name].present?
        object.errors.messages[field_name].join(', ')
      end
    end
  end
end
