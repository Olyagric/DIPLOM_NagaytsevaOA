#Область СлужебныеПроцедурыИФункции

Процедура ВКМ_СоздатьРеализацию(Период, Договор) Экспорт
//ВКМ_РеализацияАгентскихДоговоровСервер.ВКМ_СоздатьРеализацию(Договор);
ВКМ_РеализацияАгентскихДоговоровСервер.ВКМ_СоздатьРеализацию(Период, Договор);
КонецПроцедуры

Процедура ВКМ_ВыполнитьАвтозаполнение(Документ, Договор) Экспорт
	
ВКМ_РеализацияАгентскихДоговоровСервер.ВКМ_ВыполнитьАвтозаполнение(Документ, Договор);

КонецПроцедуры

Функция ВКМ_СозданиеАбонентскихОтгрузок(ДатаНачала, ДатаОкончания) Экспорт
ДанныеДляФормыОбработки = ВКМ_РеализацияАгентскихДоговоровСервер.ВКМ_МассовоеСозданиеАбонентскихОтгрузок(ДатаНачала, ДатаОкончания);
Возврат ДанныеДляФормыОбработки;
КонецФункции


//Процедура ВКМ_СозданиеАбонентскихОтгрузок(ДатаНачала, ДатаОкончания) Экспорт
//	
//ВКМ_РеализацияАгентскихДоговоровСервер.ВКМ_МассовоеСозданиеАбонентскихОтгрузок(ДатаНачала, ДатаОкончания, АдресРезультата);
//
//Конецпроцедуры

#КонецОбласти