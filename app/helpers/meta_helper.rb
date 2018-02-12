module MetaHelper
	def set_meta_tags_for_tag(tag)
		@tag = tag
		case @tag.name
		when 'девичник'
			set_meta_tags title: "\u041E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0434\u0435\u0432\u0438\u0447\u043D\u0438\u043A\u0430 \u0442\u0440\u0435\u0431\u0443\u0435\u0442 \u043C\u043D\u043E\u0433\u043E \u0432\u0440\u0435\u043C\u0435\u043D\u0438 \u0438 \u0441\u0438\u043B?",
										description: "\u0414\u043E\u043B\u0433\u0430\u044F \u043F\u043E\u0434\u0433\u043E\u0442\u043E\u0432\u043A\u0430 \u043A \u0441\u0432\u0430\u0434\u044C\u0431\u0435 \u043D\u0435 \u043E\u0441\u0442\u0430\u0432\u043B\u044F\u0435\u0442 \u0432\u0440\u0435\u043C\u0435\u043D\u0438 \u043D\u0430 \u043F\u043E\u0434\u0433\u043E\u0442\u043E\u0432\u043A\u0443 \u043A \u0434\u0435\u0432\u0438\u0447\u043D\u0438\u043A\u0443? \u0417\u0430\u043A\u0430\u0436\u0438 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0448\u0430\u0440\u0430\u043C\u0438 \u0432 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435, \u0438 \u043F\u0440\u0430\u0437\u0434\u043D\u0438\u0447\u043D\u043E\u0435 \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u0435 \u0431\u0443\u0434\u0435\u0442 \u0433\u0430\u0440\u0430\u043D\u0442\u0438\u0440\u043E\u0432\u0430\u043D\u043E! ",
										keywords: 'оформление девичника',
										reverse: true
		when 'вечеринка'
			set_meta_tags title: "\u0412\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u0434\u043B\u044F \u0432\u0435\u0447\u0435\u0440\u0438\u043D\u043A\u0438 \u0438\u0441\u043F\u0440\u0430\u0432\u044F\u0442 \u0441\u0438\u0442\u0443\u0430\u0446\u0438\u044E, \u0435\u0441\u043B\u0438 \u043D\u0435\u0442 \u043F\u0440\u0430\u0437\u0434\u043D\u0438\u0447\u043D\u043E\u0433\u043E \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u044F ",
										description: "\u0417\u0430\u043A\u0430\u0436\u0438 \u043E\u0444\u043E\u0440\u043B\u0435\u043D\u0438\u0435 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438 \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438, \u0438 \u043F\u043E\u043B\u043E\u0436\u0438\u0442\u0435\u043B\u044C\u043D\u044B\u0435 \u044D\u043C\u043E\u0446\u0438\u0438 \u0432 \u044D\u0442\u043E\u0442 \u0432\u0435\u0447\u0435\u0440 \u043D\u0435 \u0437\u0430\u0441\u0442\u0430\u0432\u044F\u0442 \u0441\u0435\u0431\u044F \u0436\u0434\u0430\u0442\u044C!",
										keywords: 'шар для вечеринки,
																оформление вечеринок',
										reverse: true
		when 'сюрприз'
			set_meta_tags title: "\u0428\u0430\u0440\u044B \u0434\u043B\u044F \u0441\u044E\u0440\u043F\u0440\u0438\u0437\u0430 \u043F\u043E\u043C\u043E\u0433\u0443\u0442 \u043E\u0444\u043E\u0440\u043C\u0438\u0442\u044C \u043E\u0431\u0441\u0442\u0430\u043D\u043E\u0432\u043A\u0443 \u0434\u043B\u044F \u0431\u043E\u043B\u044C\u0448\u0435\u0433\u043E \u044D\u0444\u0444\u0435\u043A\u0442\u0430",
										description: "\u0421\u044E\u0440\u043F\u0440\u0438\u0437\u044B \u0432\u0441\u0435\u0433\u0434\u0430 \u0434\u0430\u0440\u044F\u0442 \u0440\u0430\u0434\u043E\u0441\u0442\u044C \u0438 \u043D\u0435\u0437\u0430\u0431\u044B\u0432\u0430\u0435\u043C\u044B\u0435 \u043E\u0449\u0443\u0449\u0435\u043D\u0438\u044F. \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u0430\u044F \u0444\u0435\u044F \u043F\u043E\u043C\u043E\u0436\u0435\u0442 \u0441\u043E\u0437\u0434\u0430\u0442\u044C \u043D\u0443\u0436\u043D\u0443\u044E \u0430\u0442\u043C\u043E\u0441\u0444\u0435\u0440\u0443 \u0432 \u0432\u0430\u0436\u043D\u044B\u0439 \u043C\u043E\u043C\u0435\u043D\u0442",
										keywords: 'шар сюрприз, шары на сюрприз',
										reverse: true
		when 'день рождения'
			set_meta_tags title: "\u0428\u0430\u0440\u044B \u043D\u0430 \u0434\u0435\u043D\u044C \u0440\u043E\u0436\u0434\u0435\u043D\u0438\u044F \u0434\u043E\u0431\u0430\u0432\u044F\u0442 \u043A\u0440\u0430\u0441\u043E\u043A \u043F\u0440\u0430\u0437\u0434\u043D\u0438\u043A\u0443",
										description: "\u0414\u0435\u043D\u044C \u0440\u043E\u0436\u0434\u0435\u043D\u0438\u044F \u0442\u043E\u043B\u044C\u043A\u043E \u0440\u0430\u0437 \u0432 \u0433\u043E\u0434\u0443. \u0421\u0442\u043E\u0438\u0442 \u043E\u0442\u043C\u0435\u0442\u0438\u0442\u044C \u0435\u0433\u043E \u043A\u0440\u0430\u0441\u0438\u0432\u043E! \u0414\u043B\u044F \u0432\u0430\u0441 \u043C\u044B \u043C\u043E\u0436\u0435\u043C \u0441\u043E\u0437\u0434\u0430\u0442\u044C \u043F\u043E\u043F\u0443\u043B\u044F\u0440\u043D\u044B\u0435 \u043A\u043E\u043C\u043F\u043E\u0437\u0438\u0446\u0438\u0438 \u043D\u0430 \u0442\u043E\u0440\u0436\u0435\u0441\u0442\u0432\u043E \u0438\u043B\u0438 \u0432\u044B \u043C\u043E\u0436\u0435\u0442\u0435 \u043F\u043E\u0434\u0435\u043B\u0438\u0442\u044C\u0441\u044F \u0441\u0432\u043E\u0438\u043C\u0438 \u043F\u043E\u0436\u0435\u043B\u0430\u043D\u0438\u044F\u043C\u0438 \u0438 \u0441\u0434\u0435\u043B\u0430\u0442\u044C \u0441\u0432\u043E\u0439 \u043F\u0440\u0430\u0437\u0434\u043D\u0438\u043A \u043D\u0435\u0437\u0430\u0431\u044B\u0432\u0430\u0435\u043C\u044B\u043C",
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
			set_meta_tags title: "\u0412\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u043D\u0430 \u0441\u0432\u0430\u0434\u044C\u0431\u0443, \u0447\u0442\u043E\u0431\u044B \u0441\u0434\u0435\u043B\u0430\u0442\u044C \u043F\u0440\u0438\u044F\u0442\u043D\u0443\u044E \u043E\u0431\u0441\u0442\u0430\u043D\u043E\u0432\u043A\u0443 \u0438 \u0441\u043E\u0437\u0434\u0430\u0442\u044C \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u0435 \u043C\u043E\u043B\u043E\u0434\u043E\u0436\u0451\u043D\u0430\u043C",
										description: "\u042D\u0442\u043E\u0442 \u0432\u0430\u0436\u043D\u044B\u0439 \u0448\u0430\u0433 \u0432 \u0436\u0438\u0437\u043D\u0438 \u043A\u0430\u0436\u0434\u043E\u0433\u043E \u0447\u0435\u043B\u043E\u0432\u0435\u043A\u0430 \u0434\u043E\u043B\u0436\u0435\u043D \u0431\u044B\u0442\u044C \u043E\u0441\u043E\u0431\u0435\u043D\u043D\u043E \u043A\u0440\u0430\u0441\u0438\u0432\u044B\u043C \u0438 \u043D\u0435\u0437\u0430\u0431\u044B\u0432\u0430\u0435\u043C\u044B\u043C. \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u0430\u044F \u0444\u0435\u044F \u043F\u043E\u0437\u0430\u0431\u043E\u0442\u0438\u0442\u0441\u044F \u043E \u0432\u0441\u0435\u0445 \u0442\u043E\u043D\u043A\u043E\u0441\u0442\u044F\u0445 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u044F \u0431\u0430\u043D\u043A\u0435\u0442\u043D\u043E\u0433\u043E \u0437\u0430\u043B\u0430 \u0432 \u0442\u0430\u043A\u043E\u0439 \u0437\u043D\u0430\u043C\u0435\u043D\u0430\u0442\u0435\u043B\u044C\u043D\u044B\u0439 \u0434\u043B\u044F \u0432\u0430\u0441 \u0434\u0435\u043D\u044C",
										keywords: 'шары на свадьбу,
																оформление свадьбы шарами,
																оформление зала на свадьбу шарами,
																сердечки из шаров на свадьбу,
																белые шары на свадьбу,
																воздушные шары на свадьбу,
																композиции из шаров на свадьбу',
										reverse: true
		when 'юбилей'
			set_meta_tags title: "\u041E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u044E\u0431\u0438\u043B\u0435\u044F \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438",
										description: "\u0428\u0430\u0440\u0438\u043A\u043E\u0432\u0430\u044F \u0444\u0435\u044F \u043C\u043E\u0436\u0435\u0442 \u043F\u0440\u0435\u0434\u043B\u043E\u0436\u0438\u0442\u044C \u043F\u043E\u043F\u0443\u043B\u044F\u0440\u043D\u044B\u0435 \u043A\u043E\u043C\u043F\u043E\u0437\u0438\u0446\u0438\u0438 \u0434\u043B\u044F \u0442\u043E\u0440\u0436\u0435\u0441\u0442\u0432\u0430, \u0430 \u0435\u0441\u043B\u0438 \u0436\u0435\u043B\u0430\u0435\u0442\u0435, \u043C\u043E\u0436\u0435\u0442\u0435 \u0432\u043D\u0435\u0441\u0442\u0438 \u0441\u0432\u043E\u0438 \u043F\u043E\u0436\u0435\u043B\u0430\u043D\u0438\u044F \u0438 \u043E\u0444\u043E\u0440\u043C\u0438\u0442\u044C \u0432 \u0438\u043D\u0434\u0438\u0432\u0438\u0434\u0443\u0430\u043B\u044C\u043D\u043E\u043C \u0441\u0442\u0438\u043B\u0435",
										keywords: 'шары на юбилей,
																оформление шарами юбилея,
																шары на юбилей женщине,
																воздушные шары на юбилей,
																шары юбилей мужчине,
																шары на юбилей свадьбы,
																шары на юбилей купить',
										reverse: true
		when '8 марта'
			set_meta_tags title: "\u0428\u0430\u0440\u044B \u043D\u0430 8 \u041C\u0430\u0440\u0442\u0430 \u0441\u0442\u0430\u043D\u0443\u0442 \u043B\u0443\u0447\u0448\u0438\u043C \u0434\u043E\u043F\u043E\u043B\u043D\u0435\u043D\u0438\u0435\u043C \u043A \u0446\u0432\u0435\u0442\u0430\u043C",
										description: "\u0412 \u0436\u0435\u043D\u0441\u043A\u0438\u0439 \u043F\u0440\u0430\u0437\u0434\u043D\u0438\u043A \u0442\u0430\u043A \u0445\u043E\u0447\u0435\u0442\u0441\u044F \u043F\u043E\u043B\u0443\u0447\u0438\u0442\u044C \u0432\u043D\u0438\u043C\u0430\u043D\u0438\u0435 \u0431\u043B\u0438\u0437\u043A\u0438\u0445 \u043B\u044E\u0434\u0435\u0439. \u0421\u0434\u0435\u043B\u0430\u0439\u0442\u0435 \u0434\u0435\u043D\u044C \u043E\u0441\u043E\u0431\u0435\u043D\u043D\u044B\u043C \u0441 \u043F\u043E\u043C\u043E\u0449\u044C\u044E \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438",
										keywords: 'шары на 8 марта,
																оформление шарами на 8 марта,
																оформление шариками на 8 марта,
																оформление на 8 марта',
										reverse: true
		when '14 февраля'
			set_meta_tags title: "\u0412\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u043D\u0430 14 \u0444\u0435\u0432\u0440\u0430\u043B\u044F \u043F\u043E\u043C\u043E\u0433\u0443\u0442 \u0441\u0434\u0435\u043B\u0430\u0442\u044C \u043F\u0440\u0438\u044F\u0442\u043D\u044B\u0439 \u0441\u044E\u0440\u043F\u0440\u0438\u0437 \u043B\u044E\u0431\u0438\u043C\u043E\u043C\u0443 \u0447\u0435\u043B\u043E\u0432\u0435\u043A\u0443",
										description: "\u041F\u043B\u0430\u043D\u0438\u0440\u0443\u0435\u0448\u044C \u0441\u0434\u0435\u043B\u0430\u0442\u044C \u0441\u044E\u0440\u043F\u0440\u0438\u0437 \u0431\u043B\u0438\u0437\u043A\u043E\u043C\u0443 \u0447\u0435\u043B\u043E\u0432\u0435\u043A\u0443 \u0438 \u043D\u0435 \u0437\u043D\u0430\u0435\u0448\u044C, \u0441 \u0447\u0435\u0433\u043E \u043D\u0430\u0447\u0430\u0442\u044C? \u0417\u0430\u043A\u0430\u0436\u0438 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438 \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438 \u043F\u043E \u0442\u0435\u043B\u0435\u0444\u043E\u043D\u0443 +7 (912) 453-25-98.",
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
			set_meta_tags title: "\u0428\u0430\u0440\u044B \u043D\u0430 \u0432\u044B\u043F\u0438\u0441\u043A\u0443 \u0441\u043E\u0437\u0434\u0430\u0434\u0443\u0442 \u0434\u043E\u043F\u043E\u043B\u043D\u0438\u0442\u0435\u043B\u044C\u043D\u0443\u044E \u0440\u0430\u0434\u043E\u0441\u0442\u044C \u043E\u0442 \u043F\u043E\u044F\u0432\u043B\u0435\u043D\u0438\u044F \u043D\u043E\u0432\u043E\u0440\u043E\u0436\u0434\u0451\u043D\u043D\u043E\u0433\u043E",
										description: "\u041F\u043E\u043F\u043E\u043B\u043D\u0435\u043D\u0438\u0435 \u0432 \u0441\u0435\u043C\u044C\u0435, \u0430 \u0432\u044B \u043D\u0435 \u0437\u043D\u0430\u0435\u0442\u0435, \u043A\u0430\u043A \u0432\u044B\u0440\u0430\u0437\u0438\u0442\u044C \u0431\u043B\u0430\u0433\u043E\u0434\u0430\u0440\u043D\u043E\u0441\u0442\u044C \u0438 \u0441\u0434\u0435\u043B\u0430\u0442\u044C \u043F\u0440\u0438\u044F\u0442\u043D\u043E\u0435? \u0412\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438 \u043F\u043E\u043C\u043E\u0433\u0443\u0442 \u0432\u0430\u043C \u0441\u0434\u0435\u043B\u0430\u0442\u044C \u0441\u043E\u0431\u044B\u0442\u0438\u0435 \u043D\u0435\u0437\u0430\u0431\u044B\u0432\u0430\u0435\u043C\u044B\u043C!",
										keywords: 'шары на выписку,
																шары на выписку из роддома,
																фигуры из шаров на выписку,
																шары выписку мальчика,
																шары воздушные выписка,,
																оформление шарами на выписку,
																оформление шарами на выписку из роддома',
										reverse: true
		when 'фотосессию'
			set_meta_tags title: "\u041D\u0443\u0436\u043D\u044B \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u043D\u0430 \u0444\u043E\u0442\u043E\u0441\u0435\u0441\u0441\u0438\u044E \u0432 \u043E\u043F\u0440\u0435\u0434\u0435\u043B\u0451\u043D\u043D\u043E\u043C \u0441\u0442\u0438\u043B\u0435?",
										description: "\u0417\u0430\u043A\u0430\u0436\u0438\u0442\u0435 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438 \u0432 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435 \u0438 \u0437\u0430\u043F\u0435\u0447\u0430\u0442\u043B\u0438\u0442\u0435 \u0432\u0430\u0436\u043D\u044B\u0435 \u043C\u043E\u043C\u0435\u043D\u0442\u044B \u0441\u0432\u043E\u0438\u0445 \u043A\u043B\u0438\u0435\u043D\u0442\u043E\u0432",
										keywords: 'шары на фотосессию',
										reverse: true
		when 'рождение малыша'
			set_meta_tags title: "\u0428\u0430\u0440\u044B \u043D\u0430 \u0440\u043E\u0436\u0434\u0435\u043D\u0438\u0435 \u0440\u0435\u0431\u0451\u043D\u043A\u0430 \u0441\u0442\u0430\u043D\u0443\u0442 \u043B\u0443\u0447\u0448\u0438\u043C \u0443\u043A\u0440\u0430\u0448\u0435\u043D\u0438\u0435\u043C",
										description: "\u0412\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u0430\u0441\u0441\u043E\u0446\u0438\u0438\u0440\u0443\u044E\u0442\u0441\u044F \u0441 \u0440\u0430\u0434\u043E\u0441\u0442\u044C\u044E, \u0434\u0435\u0442\u0441\u0442\u0432\u043E\u043C, \u044D\u043C\u043E\u0446\u0438\u044F\u043C\u0438. \u0412  \u0442\u0430\u043A\u043E\u0439 \u043E\u0441\u043E\u0431\u0435\u043D\u043D\u044B\u0439 \u0434\u0435\u043D\u044C \u0441 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435\u0439 \u0432\u043E\u043A\u0440\u0443\u0433 \u0441\u0442\u0430\u043D\u0435\u0442 \u0432\u0441\u0451 \u043E\u0441\u043E\u0431\u0435\u043D\u043D\u043E \u043A\u0440\u0430\u0441\u0438\u0432\u044B\u043C \u0438 \u043F\u0440\u0438\u044F\u0442\u043D\u044B\u043C",
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
			set_meta_tags title: "\u0412\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u0435 \u0448\u0430\u0440\u044B \u043D\u0430 \u043F\u0440\u0435\u0434\u043B\u043E\u0436\u0435\u043D\u0438\u0435 \u0440\u0443\u043A\u0438 \u0438 \u0441\u0435\u0440\u0434\u0446\u0430 \u043F\u043E\u043C\u043E\u0433\u0443\u0442 \u0432\u0430\u043C \u0432\u044B\u0440\u0430\u0437\u0438\u0442\u044C \u0441\u0432\u043E\u0438 \u0447\u0443\u0432\u0441\u0442\u0432\u0430",
										description: "\u0420\u0435\u0448\u0435\u043D\u0438\u0435 \u043F\u0440\u0438\u043D\u044F\u0442\u043E, \u0430 \u043F\u043E\u0434\u0433\u043E\u0442\u043E\u0432\u043A\u0443 \u0432\u043E\u0437\u044C\u043C\u0451\u0442 \u043D\u0430 \u0441\u0435\u0431\u044F \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u0430\u044F \u0444\u0435\u044F. \u0417\u0430\u043A\u0430\u0436\u0438 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438 \u0438 \u043F\u043E\u0434\u0430\u0440\u0438 \u044D\u043C\u043E\u0446\u0438\u0438 \u0441\u0432\u043E\u0435\u0439 \u043B\u044E\u0431\u0438\u043C\u043E\u0439!",
										keywords: 'шар на предложение,
																шары на предложение,
																шарики на предложение',
										reverse: true
		when 'праздник'
			set_meta_tags title: "\u0428\u0430\u0440\u044B \u043D\u0430 \u043F\u0440\u0430\u0437\u0434\u043D\u0438\u043A \u0437\u0430\u043A\u0430\u0436\u0438 \u0438 \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u0435 \u043F\u043E\u043B\u0443\u0447\u0438!",
										description: "\u0417\u0430\u043A\u0430\u0436\u0438 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u043F\u043E\u043C\u0435\u0449\u0435\u043D\u0438\u044F \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0433\u0435\u043B\u0438\u0435\u0432\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438  \u0434\u043B\u044F \u043F\u0440\u043E\u0432\u0435\u0434\u0435\u043D\u0438\u044F \u0442\u043E\u0440\u0436\u0435\u0441\u0442\u0432\u0430 \u0438 \u0432\u0430\u0436\u043D\u043E\u0433\u043E \u0441\u043E\u0431\u044B\u0442\u0438\u044F \u0438 \u043F\u043E\u043B\u0443\u0447\u0438 \u0434\u043E\u043F\u043E\u043B\u043D\u0438\u0442\u0435\u043B\u044C\u043D\u044B\u0435 \u044D\u043C\u043E\u0446\u0438\u0438 \u043E\u0442 \u043F\u0440\u0435\u043A\u0440\u0430\u0441\u043D\u043E\u0439 \u043E\u0431\u0441\u0442\u0430\u043D\u043E\u0432\u043A\u0438",
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
			set_meta_tags title: "\u0428\u0430\u0440\u044B \u043D\u0430 \u043A\u043E\u0440\u043F\u043E\u0440\u0430\u0442\u0438\u0432 \u0434\u043B\u044F \u0434\u0440\u0443\u0436\u043D\u044B\u0445 \u0441\u043E\u0442\u0440\u0443\u0434\u043D\u0438\u043A\u043E\u0432 \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438",
										description: "\u041A\u043E\u0440\u043F\u043E\u0440\u0430\u0442\u0438\u0432 - \u0432\u0435\u0441\u0451\u043B\u044B\u0439 \u043F\u0440\u0430\u0437\u0434\u043D\u0438\u043A, \u043D\u043E \u043D\u0430\u0441\u0442\u0440\u043E\u0435\u043D\u0438\u0435 \u043D\u0443\u0436\u043D\u043E \u0437\u0430\u0434\u0430\u0442\u044C. \u0417\u0430\u043A\u0430\u0436\u0438\u0442\u0435 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438 \u043E\u0442 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0438 \u0438 \u0440\u0430\u0434\u043E\u0441\u0442\u043D\u043E \u043F\u0440\u043E\u0432\u0435\u0434\u0438\u0442\u0435 \u044D\u0442\u043E\u0442 \u0432\u0435\u0447\u0435\u0440.",
										keywords: 'шары на корпоратив',
										reverse: true
		else
			set_meta_tags title: "Оформление воздушными шарами на #{@tag.name} в Ижевске в компании Шариковая Фея",
										description: "Закажите оформление воздушными шарами на #{params[:tag_name]} в Ижевске по недорогой цене в компании Шариковая Фея",
										reverse: true
		end
	end
	def	set_meta_tags_for_receiver(receiver)
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
                  description: "\u041F\u0435\u0440\u0432\u044B\u0439 \u0432\u044B\u043F\u0443\u0441\u043A\u043D\u043E\u0439 \u0434\u043E\u043B\u0436\u0435\u043D \u0437\u0430\u043F\u043E\u043C\u043D\u0438\u0442\u044C\u0441\u044F \u0440\u0435\u0431\u0451\u043D\u043A\u0443 \u043D\u0430 \u0432\u0441\u044E \u0436\u0438\u0437\u043D\u044C, \u0434\u043B\u044F \u044D\u0442\u043E\u0433\u043E \u0437\u0430\u043A\u0430\u0436\u0438\u0442\u0435 \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0432\u043E\u0437\u0434\u0443\u0448\u043D\u044B\u043C\u0438 \u0448\u0430\u0440\u0430\u043C\u0438 \u043D\u0430 \u0432\u044B\u043F\u0443\u0441\u043A\u043D\u043E\u0439 \u0432 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435.",
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
                  description: "\u0417\u0430\u043A\u0430\u0437\u0430\u0442\u044C \u043E\u0444\u043E\u0440\u043C\u043B\u0435\u043D\u0438\u0435 \u0448\u0430\u0440\u0430\u043C\u0438 \u0438\u043B\u0438 \u0448\u0430\u0440\u044B \u043D\u0430 \u0437\u0430\u043F\u0443\u0441\u043A \u0432 \u043D\u0435\u0431\u043E \u0441 \u043C\u0435\u0447\u0442\u0430\u043C\u0438 \u0438 \u043F\u043B\u0430\u043D\u0430\u043C\u0438 \u0432\u044B\u043F\u0443\u0441\u043A\u043D\u0438\u043A\u043E\u0432 \u0432\u044B \u043C\u043E\u0436\u0435\u0442\u0435 \u0432 \u0428\u0430\u0440\u0438\u043A\u043E\u0432\u043E\u0439 \u0444\u0435\u0435.",
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
                  description: 'Доставка самых красивых воздушных шаров, оформление праздников, доставка по Ижевску бесплатно!',
                  keywords: 'воздушные шары, заказать воздушные шары, шарики с доставкой, доставка шариков'
    when 'show'
    	set_meta_tags title: "Композиция № #{@comp.id} из воздушных шаров | Шариковая фея",
                  reverse: true,
                  keywords: 'воздушные шары, заказать воздушные шары, шарики с доставкой, доставка шариков, воздушные шары с доставкой',
                  description: "Композиция из воздушных шаров на #{tags.map(&:name).join(', ')}, #{receivers.map(&:title).join(', ')}",
                  canonical: (composition_path(@comp) if @tag || @receiver)

    set_meta_tags og: {
									      title: "Композиция № #{@comp.id} из воздушных шаров | Шариковая фея",
									      type: 'product',
									      url: request.url,
									      description: "Композиция из воздушных шаров на #{tags.map(&:name).join(', ')}, #{receivers.map(&:title).join(', ')}",
									      image: {
									        _: view_context.image_path(@comp.img.url(:large)),
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
