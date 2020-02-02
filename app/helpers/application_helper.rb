module ApplicationHelper
  def show_errors(object, field_name)
    if object.errors.any?
      if object.errors.messages[field_name].present?
        object.errors.messages[field_name].join(', ')
      end
    end
  end

  def show_svg(path)
    File.open("app/assets/images/#{path}", "rb") do |file|
      raw file.read
    end
  end

end
