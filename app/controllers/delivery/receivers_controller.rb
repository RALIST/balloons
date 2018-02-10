class Delivery::ReceiversController < Delivery::DeliveryController
  def show
    begin
      @person = Receiver.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      if params[:id].to_i == 0 || params[:id] == '8 марта' || params[:id] == '14 февраля'
        @person = Receiver.find_by!(title: params[:id])
        redirect_to receiver_path(@person), status: 301
      else
        @person = Receiver.find(params[:id])
        redirect_to receiver_path(@person), status: 301
      end
    end

    case @person.title
    when 'для него'
      set_meta_tags title: "\u0412\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u0434\u043B\u044F \u043C\u0443\u0436\u0447\u0438\u043D\u044B \u0441 \u043F\u043E\u0432\u043E\u0434\u043E\u043C \u0438 \u0431\u0435\u0437",
                    description: "\u041C\u0443\u0436\u0447\u0438\u043D\u044B \u0442\u043E\u0436\u0435 \u043B\u044E\u0431\u044F\u0442 \u0432\u043D\u0438\u043C\u0430\u043D\u0438\u0435, \u0430 \u043E\u0434\u0438\u043D \u0438\u0437 \u0433\u043B\u0430\u0432\u043D\u044B\u0445 \u043A\u043E\u043C\u043F\u043E\u043D\u0435\u043D\u0442\u043E\u0432 \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u044F - \u044D\u0442\u043E \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438! ",
                    keywords: 'шары для мужчины, воздушные шары для мужчины',
                    reverse: true
    when 'для неё'
      set_meta_tags title: "\u0412\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u0434\u043B\u044F \u0434\u0435\u0432\u0443\u0448\u043A\u0438 \u0441 \u043F\u043E\u0432\u043E\u0434\u043E\u043C \u0438 \u0431\u0435\u0437",
                    description: "\u0414\u0435\u0432\u0443\u0448\u043A\u0438 \u043D\u0435 \u043C\u043E\u0433\u0443\u0442 \u0436\u0438\u0442\u044C \u0431\u0435\u0437 \u0432\u043D\u0438\u043C\u0430\u043D\u0438\u044F, \u0430 \u043F\u043E\u043C\u043E\u0447\u044C \u0432 \u044D\u0442\u043E\u043C \u043F\u043E\u043C\u043E\u0436\u0435\u0442 \u0437\u0430\u043A\u0430\u0437 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435",
                    keywords: 'шары для девушки, шарики для девушки',
                    reverse: true
    when 'дочке'
      set_meta_tags title: "\u0428\u0430\u0440\u044B \u0434\u043B\u044F \u043B\u044E\u0431\u0438\u043C\u043E\u0439 \u0434\u043E\u0447\u043A\u0438 \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438",
                    description: "\u041B\u044E\u0431\u0438\u043C\u0430\u044F \u0434\u043E\u0447\u044C \u0437\u0430\u0441\u043B\u0443\u0436\u0438\u0432\u0430\u0435\u0442 \u0432\u0441\u0435\u0433\u043E \u0441\u0430\u043C\u043E\u0433\u043E \u043B\u0443\u0447\u0448\u0435\u0433\u043E, \u0430 \u0441\u0430\u043C\u043E\u0435 \u043B\u0443\u0447\u0448\u0435\u0435 - \u044D\u0442\u043E \u043F\u043E\u0434\u0430\u0440\u0438\u0442\u044C \u0447\u0435\u043B\u043E\u0432\u0435\u043A\u0443 \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u0435! \u0417\u0430\u043A\u0430\u0437 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435 \u0432\u044B\u0440\u0443\u0447\u0438\u0442 \u0432\u0430\u0441.",
                    keywords: 'шары для дочки, шарики для дочки',
                    reverse: true
    when "\u0436\u0435\u043D\u0435"
      set_meta_tags title: "\u0428\u0430\u0440\u044B \u0434\u043B\u044F \u0434\u043E\u0440\u043E\u0433\u043E\u0439 \u0436\u0435\u043D\u044B \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438",
                    description: "\u041F\u043E\u0434\u0430\u0440\u0438\u0442\u044C \u044D\u043C\u043E\u0446\u0438\u0438 \u0432 \u043D\u0443\u0436\u043D\u044B\u0439 \u043C\u043E\u043C\u0435\u043D\u0442 \u0438 \u0441\u043E\u0437\u0434\u0430\u0442\u044C \u0447\u0435\u043B\u043E\u0432\u0435\u043A\u0443 \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u0435 \u043E\u0447\u0435\u043D\u044C \u0432\u0430\u0436\u043D\u043E. \u0417\u0430\u043A\u0430\u0436\u0438 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u0438 \u043F\u043E\u0434\u0435\u043B\u0438\u0441\u044C \u0441\u0447\u0430\u0441\u0442\u044C\u0435\u043C \u0441 \u0441\u0443\u043F\u0440\u0443\u0433\u043E\u0439!",
                    keywords: 'шары для жены',
                    reverse: true
    when "\u043C\u0443\u0436\u0447\u0438\u043D\u0435"
      set_meta_tags title: "\u0428\u0430\u0440\u044B \u0434\u043B\u044F \u0434\u043E\u0440\u043E\u0433\u043E\u0433\u043E \u043C\u0443\u0436\u0430 \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438",
                    description: "\u041F\u043E\u0434\u0430\u0440\u0438\u0442\u044C \u044D\u043C\u043E\u0446\u0438\u0438 \u0432 \u043D\u0443\u0436\u043D\u044B\u0439 \u043C\u043E\u043C\u0435\u043D\u0442 \u0438 \u0441\u043E\u0437\u0434\u0430\u0442\u044C \u0447\u0435\u043B\u043E\u0432\u0435\u043A\u0443 \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u0435 \u043F\u043E\u043C\u043E\u0436\u0435\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u0430\u044F \u0444\u0435\u044F. \u041F\u043E\u0434\u0435\u043B\u0438\u0441\u044C \u0441\u0447\u0430\u0441\u0442\u044C\u0435\u043C \u0441 \u0441\u0443\u043F\u0440\u0443\u0433\u043E\u043C!",
                    keywords: 'шары для мужа, шары мужу на день рождения',
                    reverse: true
    when "\u043F\u043E\u0434\u0440\u0443\u0433\u0435"
      set_meta_tags title: "\u0428\u0430\u0440\u044B \u0434\u043B\u044F \u043B\u0443\u0447\u0448\u0435\u0439 \u043F\u043E\u0434\u0440\u0443\u0433\u0438 \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438",
                    description: "\u041F\u043E\u044F\u0432\u0438\u043B\u0441\u044F \u043F\u043E\u0432\u043E\u0434 \u043F\u043E\u0440\u0430\u0434\u043E\u0432\u0430\u0442\u044C \u043F\u043E\u0434\u0440\u0443\u0433\u0443, \u043D\u043E \u043D\u0435 \u0437\u043D\u0430\u0435\u0448\u044C \u043A\u0430\u043A? \u0417\u0430\u043A\u0430\u0436\u0438 \u0448\u0430\u0440\u044B \u0432 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435 \u0438\u043B\u0438 \u0441\u0434\u0435\u043B\u0430\u0439 \u043F\u0440\u0438\u044F\u0442\u043D\u044B\u0439 \u0441\u044E\u0440\u043F\u0440\u0438\u0437 \u0438\u0437 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0445 \u0448\u0430\u0440\u043E\u0432 \u0434\u043B\u044F \u043D\u0435\u0451.",
                    keywords: 'шары для подруги',
                    reverse: true
    when "\u0441\u044B\u043D\u0443"
      set_meta_tags title: "\u0428\u0430\u0440\u044B \u0434\u043B\u044F \u043B\u044E\u0431\u0438\u043C\u043E\u0433\u043E \u0441\u044B\u043D\u0430  \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438",
                    description: "\u041B\u044E\u0431\u0438\u043C\u044B\u0439 \u0441\u044B\u043D \u0437\u0430\u0441\u043B\u0443\u0436\u0438\u0432\u0430\u0435\u0442 \u0432\u0441\u0435\u0433\u043E \u0441\u0430\u043C\u043E\u0433\u043E \u043B\u0443\u0447\u0448\u0435\u0433\u043E, \u0430 \u0441\u0430\u043C\u043E\u0435 \u043B\u0443\u0447\u0448\u0435\u0435 - \u044D\u0442\u043E \u043F\u043E\u0434\u0430\u0440\u0438\u0442\u044C \u0447\u0435\u043B\u043E\u0432\u0435\u043A\u0443 \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u0435! \u0417\u0430\u043A\u0430\u0437 \u0448\u0430\u0440\u043E\u0432 \u0432 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435 \u0432\u044B\u0440\u0443\u0447\u0438\u0442 \u0432\u0430\u0441.",
                    keywords: 'шары сыну',
                    reverse: true
    else
      set_meta_tags title: "\u0428\u0430\u0440\u044B \u0434\u043B\u044F \u043B\u044E\u0431\u0438\u043C\u043E\u0433\u043E \u0441\u044B\u043D\u0430  \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438",
                    description: "Воздушные шары #{params[:title]}",
                    reverse: true
    end
    @compositions = Composition.with_receivers(@person.title).availible.order(:price).paginate(page: params[:page], per_page: 6)
    respond_to do |format|
      format.html  { redirect_to root_path, flash: { danger: 'Нет композиций!' } unless @compositions.any? }
      format.js if params[:page]
    end
  end
end
