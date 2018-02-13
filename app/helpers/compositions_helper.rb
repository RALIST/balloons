module CompositionsHelper

  def custom_url_path(obj)
    case controller.controller_name
    when 'receivers'
      receiver_composition_path(params[:id], obj)
    when'tags'
      tag_composition_path(params[:id], obj)
    when 'main','compositions'
      composition_path(obj)
    end
  end
end
