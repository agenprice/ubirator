//С запросом
&НаСервере
Функция ПолучитьСписокСвязанныхДокументов(СсылкаНаДокумент) экспорт
	
	ТаблицаСвязанныхДокументов = Новый ТаблицаЗначений;
	ТаблицаСвязанныхДокументов.Колонки.Добавить("Ссылка");
	НоваяСтрока = ТаблицаСвязанныхДокументов.Добавить();
	НоваяСтрока.Ссылка = СсылкаНаДокумент;
	
	Запрос = Новый Запрос;
	Запрос.Текст =
	"ВЫБРАТЬ РАЗРЕШЕННЫЕ
	|    СвязанныеДокументы.Ссылка
	|ИЗ
	|    КритерийОтбора.СвязанныеДокументы(&ЗначениеКритерияОтбора) КАК СвязанныеДокументы";
	
	Для Каждого СтрокаТаблицы Из ТаблицаСвязанныхДокументов Цикл
		
		Если Метаданные.КритерииОтбора.СвязанныеДокументы.Тип.СодержитТип(ТипЗнч(СтрокаТаблицы.Ссылка))  Тогда
			
			Запрос.УстановитьПараметр("ЗначениеКритерияОтбора", СтрокаТаблицы.Ссылка);
			ТаблицаСвязанныхДокументовВременная = Запрос.Выполнить().Выгрузить();
			
			Для Каждого ЭлементКоллекции Из ТаблицаСвязанныхДокументовВременная Цикл
				РезультатПоиска = ТаблицаСвязанныхДокументов.Найти(ЭлементКоллекции.Ссылка);
				Если РезультатПоиска = НеОпределено Тогда
					НоваяСтрока = ТаблицаСвязанныхДокументов.Добавить();
					НоваяСтрока.Ссылка = ЭлементКоллекции.Ссылка;
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЦикла;
	
	Возврат ТаблицаСвязанныхДокументов ;
	
КонецФункции

//Без запроса
&НаСервере
Функция ПолучитьСписокПодчиненныхДокументовНов(СсылкаНаДокумент)
	
	ТаблицаСвязанныхДокументов = Новый ТаблицаЗначений;
	ТаблицаСвязанныхДокументов.Колонки.Добавить("Ссылка");
	НоваяСтрока = ТаблицаСвязанныхДокументов.Добавить();
	НоваяСтрока.Ссылка = СсылкаНаДокумент;
	
	Для Каждого СтрокаТаблицы Из ТаблицаСвязанныхДокументов Цикл
		МассивСвязанныхДокументов = КритерииОтбора.СвязанныеДокументы.Найти(СтрокаТаблицы.Ссылка);
		
		Для Каждого ЭлементКоллекции Из МассивСвязанныхДокументов Цикл
			РезультатПоиска = ТаблицаСвязанныхДокументов.Найти(ЭлементКоллекции);
			Если РезультатПоиска = НеОпределено Тогда
				НоваяСтрока = ТаблицаСвязанныхДокументов.Добавить();
				НоваяСтрока.Ссылка = ЭлементКоллекции.Ссылка;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Возврат ТаблицаСвязанныхДокументов ;
	
КонецФункции

// ----------------- Создание подчиненных документов ----------------------- //

&НаСервере
Функция ОтсортироватьМассив(Массив) экспорт

	Таблица = Новый ТаблицаЗначений;
	Таблица.Колонки.Добавить("index");
	Таблица.Колонки.Добавить("Структура");
	
	Для каждого Элемент Из Массив Цикл
		СтрокаТЗ = Таблица.Добавить();	
		СтрокаТЗ.index = Элемент["index"];
		СтрокаТЗ.Структура = Элемент;
	КонецЦикла;

	Таблица.Сортировать("index Возр");
	Массив = Таблица.ВыгрузитьКолонку("Структура");
 
	Возврат Массив;
	
КонецФункции	



&НаСервере
Функция СоздатьПодчиненныйДокумент(doc_owner_uuid, doc_type, doc_subtype, doc_wh_uuid, force = истина, post = истина) экспорт
	
	Если НРЕГ(СокрЛП(doc_type)) = "sales" тогда //Создать реализацию на основании счета на оплату
		 МассивДокументов = СозданиеДокументовРеализации.СоздатьДокументРеализации(doc_owner_uuid, doc_wh_uuid, doc_subtype, force, post);
	КонецЕсли;
	 
	Если НРЕГ(СокрЛП(doc_type)) = "invoice" тогда //Создать cф на основании реализации
		 МассивДокументов = СозданиеСчетовФактур.СоздатьДокументСФНаРеализацию(doc_owner_uuid, force, post);
	КонецЕсли;
	
	Возврат МассивДокументов;
	
КонецФункции	

&НаСервере
Функция СоздатьВсеПодчиненныеДокументы(doc_owner_uuid, ПараметрыЗапроса) экспорт
	
	ПараметрыЗапроса = ОтсортироватьМассив(ПараметрыЗапроса);
	МассивДокументов = Новый Массив;
	
	Для Каждого ПараметрЗапроса из ПараметрыЗапроса цикл
		
		МассивСозданныхДокументов = СоздатьПодчиненныйДокумент(doc_owner_uuid, ПараметрЗапроса.doc_type, ПараметрЗапроса.doc_subtype, ПараметрЗапроса.doc_wh_uuid, ПараметрЗапроса.force, ПараметрЗапроса.post);
		МассивДокументов.Добавить(МассивСозданныхДокументов[0].Ссылка);
		
		doc_owner_uuid = Строка(МассивСозданныхДокументов[0].Ссылка.УникальныйИдентификатор());
		
	КонецЦикла;
	
	Возврат МассивДокументов;
	
КонецФункции	
