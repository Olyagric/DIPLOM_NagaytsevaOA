//Создайте общий модуль "Телеграм"
//В модуле реализуйте метод, который получает на вход текст сообщения
//В рамках метода:
//создайте защищённое соединение с сервером "api.telegram.org" +
//создайте HTTP-запрос к ресурсу /bot[ВашТокен]/sendMessage + 
//добавьте заголовок "Content-Type" со значением "application/json"
//подготовьте структуру с полями:
//"chat_id" - идентификатор группы из константы, +
//"text" - текст сообщения +
//установите JSON строку, полученную из структуры, в качестве тела HTTP-запроса
//отправьте запрос с помощью метода "POST"
//проверьте, что получет ответ с кодом состояния 200, если код состояния отличный от 200, 
//получите тело ответа как строку и запишите в журнал регистрации информацию об ошибке.
Процедура СформироватьСообщениеТелеграм(ТекстСообщения) Экспорт

	
	//ТекстСообщения = "Тест";
	 
	ЧатID = Константы.ВКМ_ИдентификаторГруппыДляОповещения.Получить();
	Токен = Константы.ВКМ_ТокенУправленияТелеграмБотом.Получить();
	//Ресурс = СтрШаблон("bot%1/sendMessage?chat_id=%2?&text=%3", Токен, ЧатID, ТекстСообщения);
	
	Ресурс = СтрШаблон("bot%1/sendMessage", Токен);
	
	Хост = "api.telegram.org";
	
	SSL = Новый ЗащищенноеСоединениеOpenSSL();
	
	HTTPСоединение = Новый HTTPСоединение(Хост,,,,,,SSL);
		HTTPЗапрос = Новый HTTPЗапрос(Ресурс);
	
	//добавьте заголовок "Content-Type" со значением "application/json"
	
	HTTPЗапрос.Заголовки.Вставить("Content-Type", "application/json");
	
	//подготовьте структуру с полями:
    //"chat_id" - идентификатор группы из константы, +
    //"text" - текст сообщения +
	ДанныеОтвета = Новый Структура;
	ДанныеОтвета.Вставить("chat_id", ЧатID);
	ДанныеОтвета.Вставить("text", ТекстСообщения);
		
	//установите JSON строку, полученную из структуры, в качестве тела HTTP-запроса
	
	Запись = Новый ЗаписьJSON();
	Запись.УстановитьСтроку();
	ЗаписатьJSON(Запись, ДанныеОтвета);
	ТелоЗапроса = Запись.Закрыть();
	HTTPЗапрос.УстановитьТелоИзСтроки(ТелоЗапроса);	
	
	//отправьте запрос с помощью метода "POST"
	
	HTTPОтвет = HTTPСоединение.Получить(HTTPЗапрос);
	
	Если HTTPОтвет.КодСостояния <> 200 Тогда
		Сообщить("Ошибка подключения");
	КонецЕсли;
	
	
	//получите тело ответа как строку и запишите в журнал регистрации информацию об ошибке
	
	ЧтениеJSON = Новый ЧтениеJSON();
	СтрокаОтвета = HTTPОтвет.ПолучитьТелоКакСтроку();
	ЧтениеJSON.УстановитьСтроку(СтрокаОтвета);
	
КонецПроцедуры


Процедура ОтправкаСообщенийВТелеграм() Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст =
		"ВЫБРАТЬ
		|	ВКМ_УведомленияТелеграмБоту.Ссылка Как Ссылка,
		|	ВКМ_УведомленияТелеграмБоту.ТекстСообщения Как ТекстСообщения,
		|	ВКМ_УведомленияТелеграмБоту.ПометкаУдаления Как ПометкаУдаления
		|ИЗ
		|	Справочник.ВКМ_УведомленияТелеграмБоту КАК ВКМ_УведомленияТелеграмБоту
		|ГДЕ
		|	НЕ ВКМ_УведомленияТелеграмБоту.ПометкаУдаления";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Пока Выборка.Следующий() Цикл
		
		СформироватьСообщениеТелеграм(Выборка.ТекстСообщения);
		СправочникОбъект = Выборка.Ссылка.ПолучитьОбъект();
		СправочникОбъект.удалить();
	   // СправочникОбъект.Записать();

	КонецЦикла;
	
КонецПроцедуры

