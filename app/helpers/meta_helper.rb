module MetaHelper
	def set_meta_tags_for_tag(tag)
		@tag = tag
		case @tag.name
		when 'девичник'
			set_meta_tags title: "Оформление девичника требует много времени и сил?",
										description: "Долгая подготовка к свадьбе не оставляет времени на подготовку к девичнику? Закажи оформление шарами в Шариковой фее, и праздничное настроение будет гарантировано!",
										keywords: 'оформление девичника',
										reverse: true
		when 'вечеринка'
			set_meta_tags title: "Воздушные шары для вечеринки исправят ситуацию, если нет праздничного настроения",
										description: "Закажи офорление воздушными шарами от Шариковой феи, и положительные эмоции в этот вечер не заставят себя ждать!",
										keywords: 'шар для вечеринки,
																оформление вечеринок',
										reverse: true
		when 'сюрприз'
			set_meta_tags title: "Шары для сюрприза помогут оформить обстановку для большего эффекта",
										description: "Сюрпризы всегда дарят радость и незабываемые ощущения. Шариковая фея поможет создать нужную атмосферу в важный момент. ",
										keywords: 'шар сюрприз, шары на сюрприз',
										reverse: true
		when 'день рождения'
			set_meta_tags title: "Шары на день рождения добавят красок празднику",
										description: "День рождения только раз в году. Стоит отметить его красиво! Для вас мы можем создать популярные композиции на торжество или вы можете поделиться своими пожеланиями и сделать свой праздник незабываемым.",
										keywords: 'шары на день рождения
																шары на день рождения ижевск,
																шары цифры на день рождения,
																шары на день рождения девочке,
																воздушные шары на день рождения,
																шары на день рождения ребенку,
																оформление шарами день рождения,
																фигуры из шаров на день рождения,
																украшение шарами на день рождения,
																1 день рождения шары,
																шары на день рождения 1 год,
																украсить шарами день рождения,
																недорогие шары на день рождения,
																гелевые шары на день рождения недорого,
																гелевые шары на день рождения,
																шары на день рождения 18 лет,
																шары на день рождения цена,
																шары на день рождения мальчику,
																шары на день рождения девушке,
																украсить шарами комнату на день рождения девочки,
																украсить шарами день рождения девочки,
																шары на день рождения 14 лет,
																шары на день рождения ребенка 1 год,
																украшение шарами на день рождения ребенка',
										reverse: true
		when 'свадьба'
			set_meta_tags title: "Воздушные шары на свадьбу, чтобы сделать приятную обстановку и создать настроение молодожёнам",
										description: "Этот важный шаг в жизни каждого человека должен быть особенно красивым и незабываемым. Шариковая фея позаботится о всех тонкостях оформления банкетного зала в такой знаменательный для вас день.",
										keywords: 'шары на свадьбу,
																оформление свадьбы шарами,
																оформление зала на свадьбу шарами,
																сердечки из шаров на свадьбу,
																белые шары на свадьбу,
																воздушные шары на свадьбу,
																композиции из шаров на свадьбу',
										reverse: true
		when 'юбилей'
			set_meta_tags title: "Оформление юбилея воздушными шарами",
										description: "Шариковая фея может предложить популярные композиции для торжества, а если желаете, можете внести свои пожелания и оформить в индивидуальном стиле.",
										keywords: 'шары на юбилей,
																оформление шарами юбилея,
																шары на юбилей женщине,
																воздушные шары на юбилей,
																шары юбилей мужчине,
																шары на юбилей свадьбы,
																шары на юбилей купить',
										reverse: true
		when '8 марта'
			set_meta_tags title: "Шары на 8 Марта станут лучшим дополнением к цветам",
										description: "В женский праздник так хочется получить внимание близких людей. Сделайте день особенным с помощью Шариковой феи.",
										keywords: 'шары на 8 марта,
																оформление шарами на 8 марта,
																оформление шариками на 8 марта,
																оформление на 8 марта',
										reverse: true
		when '14 февраля'
			set_meta_tags title: "Воздушные шары на 14 февраля помогут сделать приятный сюрприз любимому человеку",
										description: "Планируешь сделать сюрприз близкому человеку и не знаешь, с чего начать? Закажи оформление воздушными шарами от Шариковой феи по телефону +7 (912) 453-25-98",
										keywords: 'шары на 14 февраля,
																шары на день влюбленных,
																оформление на 14 февряля,
																оформление шарами на 14 февряля,
																оформление на день влюбленных,
																оформление шарами на день влюбленных,
																оформление шариками на 14 февраля,
																оформление шариками на день влюбленных',
										reverse: true
		when 'выписку из роддома'
			set_meta_tags title: "Шары на выписку создадут дополнительную радость от появления новорождённого",
										description: "Пополнение в семье, а вы не знаете, как выразить благодарность и сделать приятное? Воздушные шары от Шариковой феи помогут вам сделать событие незабываемым!",
										keywords: 'шары на выписку,
																шары на выписку из роддома,
																фигуры из шаров на выписку,
																шары выписку мальчика,
																шары воздушные выписка,,
																оформление шарами на выписку,
																оформление шарами на выписку из роддома',
										reverse: true
		when 'фотосессию'
			set_meta_tags title: "Нужны воздушные шары на фотосессию в определённом стиле?",
										description: "Закажите оформление воздушными шарами в Шариковой фее и запечатлите важные моменты своих клиентов.",
										keywords: 'шары на фотосессию',
										reverse: true
		when 'рождение малыша'
			set_meta_tags title: "Шары на рождение ребёнка станут лучшим украшением ",
										description: "Воздушные шары ассоциируются с радостью, детством, эмоциями. В  такой особенный день с Шариковой феей вокруг станет всё особенно красивым и приятным.",
										keywords: 'шары на рождение,
																шары на рождение девочки,
																шары на день рождения девочке,
																шары на день рождения ижевск,
																шары на рождение ребенка,
																воздушные шары на рождение,
																фигуры из шаров на рождения ребенка,
																украшение шарами на рождение ребенка,
																композиции из шаров на рождение ребенка',
										reverse: true
		when 'предложение'
			set_meta_tags title: "Воздушные шары на предложение руки и сердца помогут вам выразить свои чувства",
										description: "Решение принято, а подготовку возьмёт на себя Шариковая фея. Закажи оформление воздушными шарами и подари эмоции своей любимой!",
										keywords: 'шар на предложение,
																шары на предложение,
																шарики на предложение',
										reverse: true
		when 'праздник'
			set_meta_tags title: "Шары на праздник закажи и настроение получи!",
										description: "Закажи оформление помещения воздушными гелиевыми шарами  для проведения торжества и важного события и получи дополнительные эмоции от прекрасной обстановки.",
										keywords: 'шары на праздник
																украсить праздник шарами,
																украсить праздник воздушными шарами,
																украшение праздника шарами,
																оформление праздников шарами,
																украшение праздников воздушными шарами,
																купить шары на праздник,
																заказать шары на праздник,
																оформление шарами детского праздника,
																украшение шарами детского праздника,
																детские праздники воздушными шарами,
																оформление праздников воздушными шарами,
																оформление детского праздника воздушными шарами',
										reverse: true
		when 'корпоратив'
			set_meta_tags title: "Шары на корпоратив для дружных сотрудников от Шариковой феи",
										description: "Корпоратив - весёлый праздник, но настроение нужно задать. Закажите оформление воздушными шарами от Шариковой феи и радостно проведите этот вечер.",
										keywords: 'шары на корпоратив',
										reverse: true
		else
			set_meta_tags title: "Оформление воздушными шарами на #{@tag.name} в %{city} в компании Шариковая Фея" % {city: t("cities.#{@city}.where")},
										description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в %{city} по недорогой цене в компании Шариковая Фея" % {city: t("cities.#{@city}.where")},
										reverse: true
		end
	end
	def	set_meta_tags_for_receiver(receiver)
		case @person.title
	  when 'для него'
	    set_meta_tags title: "Воздушные шары для мужчины с поводом и без",
	                  description: "Мужчины тоже любят внимание, а один из главных компонентов настроения - это воздушные шары от Шариковой феи!",
	                  keywords: 'шары для мужчины, воздушные шары для мужчины',
	                  reverse: true
	  when 'для неё'
	    set_meta_tags title: "Воздушные шары для девушки с поводом и без",
	                  description: "Девушки не могут жить без внимания, а помочь в этом поможет заказ воздушных шаров в Шариковой фее.",
	                  keywords: 'шары для девушки, шарики для девушки',
	                  reverse: true
	  when 'дочке'
	    set_meta_tags title: "Шары для любимой дочки от Шариковой феи",
	                  description: "Любимая дочь заслуживает всего самого лучшего, а самое лучшее - это подарить человеку настроение! Заказ шаров в Шариковой фее выручит вас.",
	                  keywords: 'шары для дочки, шарики для дочки',
	                  reverse: true
	  when 'жене'
	    set_meta_tags title: "Шары для дорогой жены от Шариковой феи",
	                  description: "Подарить эмоции в нужный момент и создать человеку настроение очень важно. Закажи воздушные шары и поделись счастьем с супругой!",
	                  keywords: 'шары для жены',
	                  reverse: true
	  when 'мужу'
	    set_meta_tags title: "Шары для дорогого мужа от Шариковой феи",
	                  description: "Подарить эмоции в нужный момент и создать человеку настроение поможет Шариковая фея. Поделись счастьем с супругом!",
	                  keywords: 'шары для мужа, шары мужу на день рождения',
	                  reverse: true
	  when 'подруге'
	    set_meta_tags title: "Шары для лучшей подруги от Шариковой феи",
	                  description: "Появился повод порадовать подругу, но не знаешь как? Закажи шары в Шариковой фее или сделай приятный сюрприз из воздушных шаров для неё.",
	                  keywords: 'шары для подруги',
	                  reverse: true
	  when 'сыну'
	    set_meta_tags title: "Шары для любимого сына  от Шариковой феи",
	                  description: "Любимый сын заслуживает всего самого лучшего, а самое лучшее - это подарить человеку настроение! Заказ шаров в Шариковой фее выручит вас.",
	                  keywords: 'шары сыну',
	                  reverse: true
	  else
	    set_meta_tags title: "Оформление воздушными шарами на #{@tag.name} в %{city} в компании Шариковая Фея" % {city: t("cities.#{@city}.where")},
	                  description: "Воздушные шары #{params[:title]} в %{city}" % {city: t("cities.#{@city}.where")},
	                  reverse: true
	  end
	end

	def set_meta_tags_for_main
		keywords = 'доставка воздушных шаров ижевск,
	                              воздушные шары с доставкой,
	                              воздушные гелиевые шары с доставкой,
	                              доставка воздушных шаров цена,
	                              оформление воздушными шарами,
	                              оформление праздников воздушными шарами,
	                              оформление шарами,
	                              оформление шарами ижевск,
	                              оформление праздников шарами,
	                              воздушные шары ижевск,
	                              купить воздушные шары ижевск,
	                              доставка воздушных шаров ижевск,
	                              заказ шаров ижевск,
	                              шары на заказ ижевск,
	                              заказать шары ижевск,
	                              гелиевые шары ижевск,
	                              гелиевые шары ижевск недорого,
	                              гелиевые шары ижевск купить,
	                              гелиевые шары ижевск с доставкой,
	                              украшение шарами ижевск,
	                              шары ижевск,
	                              купить шары ижевск,
	                              воздушные шары ижевск,
	                              доставка шаров ижевск,
	                              шары гелий ижевск,
	                              шары в ижевске где купить,
	                              заказать гелевые шары в ижевске'
	  description = 'Оформление торжества воздушными шарами от "Шариковой феи" оставит приятные впечатления и сделает этот день ярким. Для оформления заказа звоните по телефону +7 (912) 453-25-98'
	  case params[:action]
		when 'index'
			set_meta_tags title: 'Доставка и оформление воздушными шарами в Ижевске от Шариковой феи',
	                  description: description,
	                  keywords: keywords
	  when 'by_price'
	  	set_meta_tags title: "Оформление воздушными шарами до #{params[:max]} рублей",
                  description: "Воздушные шары на #{params[:tag_name]}",
                  keywords: keywords
	  when 'contacts'
	  	set_meta_tags title: "Контакты | Шариковая фея",
	  	keywords: keywords
	  when 'prices'
	  	set_meta_tags title: "Цена на воздушные шары |  Шариковая фея",
                  description: description,
                  keywords: keywords
	  when 'about'
	  	set_meta_tags title: "О компании | Шариковая фея",
                  description: description,
                  keywords: keywords
	  when 'info'
	  	  set_meta_tags title: "Доставка и оплата | Шариковая фея",
                  description: description,
                  keywords: keywords
	  when 'garant'
	  	 set_meta_tags title: "Гарантии | Шариковая фея",
                  description: description,
                  keywords: keywords
    end
	end

	def set_meta_tags_for_graduation
		case params[:action]
		when 'kg'
			set_meta_tags title: 'Оформление для детей шарами на выпускной в детском саду',
                  description: "Первый выпускной должен запомниться ребёнку на всю жизнь, для этого закажите оформление воздушными шарами на выпускной в Шариковой фее.",
                  keywords: 'оформление шарами выпускной в детском саду,
                              выпускной детский сад шары,
                              украшение шарами на выпускной в детском саду,
                              шары в сад на выпускной,
                              выпускной в саду украшение шарами,
                              украшения шарами на выпускной в детском,
                              украшение зала шарами на выпускной в саду,
                              оформление шарами выпускной в детском,
                              оформление зала шарами на выпускной в детском,
                              оформление выпускного в саду шарами'
		when 'school'
			set_meta_tags title: 'Воздушные шары на выпускной',
                  description: "Заказать оформление шарами или шары на запуск в небо с мечтами и планами выпускников вы можете в Шариковой фее. ",
                  keywords: 'шары на выпускной
                              украшение шарами на выпускной,
                              оформление шарами выпускной,
                              зал на выпускной шарами,
                              украшение зала шарами на выпускной,
                              воздушные шары на выпускной,
                              оформление выпускного зала шарами'
		end
	end


	def set_meta_tags_for_composition
		case params[:action]
		when 'index'
			set_meta_tags title: 'Воздушные шары с доставкой, все композиции',
                  description: 'Доставка самых красивых воздушных шаров, оформление праздников, доставка по %{city} бесплатно!' % {city: t("cities.#{@city}.in")},
                  keywords: 'воздушные шары, заказать воздушные шары, шарики с доставкой, доставка шариков'
    when 'show'
    	set_meta_tags title: "Композиция № #{@comp.id} из воздушных шаров | Шариковая фея",
                  reverse: true,
                  keywords: 'воздушные шары, заказать воздушные шары, шарики с доставкой, доставка шариков, воздушные шары с доставкой',
                  description: "Композиция из воздушных шаров на #{tags.map(&:name).join(', ')}, #{receivers.map(&:title).join(', ')}",
                  canonical: (composition_path(@comp) if @tag || @receiver)

    set_meta_tags og: {
									      title: "Композиция № #{@comp.id} из воздушных шаров | Шариковая фея",
									      type: 'article',
									      url: request.url,
									      description: 'Оформление торжества воздушными шарами от "Шариковой феи" оставит приятные впечатления и сделает этот день ярким. Для оформления заказа звоните по телефону +7 (912) 453-25-98',
									      image: {
									        _: 'https:' + view_context.image_path(@comp.img.url(:large)),
									        width: 968,
									        height: 504,
									        alt: @comp.title
									      },
									      site_name: 'Шариковая фея'
    							},
    							product: {
    								availability: 'instock',
    								brand: "Шариковая фея",
    								condition: 'new',
    								price: {
									        amount: @comp.comp_price.round(0),
									        currency: 'RUB'
									      },
									  retailer_item_id: @comp.id
    							}

    end
	end

	def set_meta_og
		set_meta_tags og: {
      title: 'Доставка и оформление воздушными шарами в Ижевске от Шариковой феи',
      description: 'Оформление торжества воздушными шарами от "Шариковой феи" оставит приятные впечатления и сделает этот день ярким. Для оформления заказа звоните по телефону +7 (912) 453-25-98',
      type: 'article',
      url: request.url,
      image: {
        _: view_context.image_path('logo1.png'),
        width: 1000
      },
      site_name: 'Шариковая фея'
    }
	end


end
