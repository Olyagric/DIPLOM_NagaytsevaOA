#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
Адрес = Параметры.Адрес;

ДанныеОтпуска = ПолучитьИзВременногоХранилища(Адрес);

Планированиеотпусков.Очистить();

Для Каждого Строка Из ДанныеОтпуска Цикл
	Точка = Планированиеотпусков.УстановитьТочку(Строка.Сотрудник);
	Серия = Планированиеотпусков.УстановитьСерию("Отпуск");
	Значение = Планированиеотпусков.ПолучитьЗначение(Точка,Серия);
	Интервал = Значение.Добавить();
	Интервал.Начало = Строка.ДатаНачала;
	Интервал.Конец = Строка.ДатаОкончания;
	
КонецЦикла;

КонецПроцедуры

#КонецОбласти