module CompositionsHelper

  def custom_url_path(obj)
    case controller.controller_name
    when 'receivers'
      receiver_composition_path(params[:id], obj)
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
end
