﻿//С запросом
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


Процедура ЗаполнитьРеализациюПоДокументуОснованию(ДокументРеализации, МассивОснований)
	
	Основание = МассивОснований[0];
	
	// Поддерживается множественный ввод на основании только для счета, для остальных документов - берется первый из списка оснований
	Если ТипЗнч(Основание) = Тип("ДокументСсылка.СчетНаОплатуПокупателю") Тогда
		
		// Заполним реквизиты шапки по документу основанию.
		ВидОперации = Документы.РеализацияТоваровУслуг.ОпределитьВидОперацииПоДокументуОснованию(МассивОснований);
		
		ДанныеОснования = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Основание, 
		"АдресДоставки, СтруктурнаяЕдиница, СпособДоставки, СпособДоставки.Контрагент");
		
		СпособДоставки = ДанныеОснования.СпособДоставки;
		АдресДоставки  = ДанныеОснования.АдресДоставки;
		Перевозчик     = ДанныеОснования.СпособДоставкиКонтрагент;
		
		СчетНаОплатуПокупателю = Основание;
		
		// Заполним реквизиты из стандартного набора по документу основанию.
		ЗаполнениеДокументов.ЗаполнитьПоОснованию(ДокументРеализации, Основание, Истина);
		
		ПараметрыОбъекта = Новый Структура("ВидОперации, ДеятельностьНаПатенте");
		ЗаполнитьЗначенияСвойств(ПараметрыОбъекта, ДокументРеализации);
		
		//МассивВидовДоговоров   = Документы.РеализацияТоваровУслуг.ПолучитьМассивВидовДоговоров(ВидОперации, ДеятельностьНаПатенте);
		МассивВидовДоговоров   = Документы.РеализацияТоваровУслуг.ПолучитьМассивВидовДоговоров(ВидОперации, Ложь);
		ВидДоговораКонтрагента = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Основание.ДоговорКонтрагента, "ВидДоговора");
		
		Если МассивВидовДоговоров.Найти(ВидДоговораКонтрагента) = Неопределено Тогда
			ДоговорКонтрагента = Справочники.ДоговорыКонтрагентов.ПустаяСсылка();
		КонецЕсли;
		
		// заполним банковский счет
		Если ЗначениеЗаполнено(ДанныеОснования.СтруктурнаяЕдиница)
			И ТипЗнч(ДанныеОснования.СтруктурнаяЕдиница) = БухгалтерскийУчетКлиентСерверПереопределяемый.ТипЗначенияБанковскогоСчетаОрганизации() Тогда
			БанковскийСчетОрганизации = ДанныеОснования.СтруктурнаяЕдиница;
		КонецЕсли;
		
		
	ИначеЕсли ТипЗнч(Основание) = Тип("ДокументСсылка.ПоступлениеТоваровУслуг") Тогда
		
		// Заполним реквизиты из стандартного набора по документу основанию.
		ДанныеОснования = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(Основание, 
		"ВалютаДокумента, ПодразделениеОрганизации, ВидОперации, Организация, Склад");
		
		Если ДанныеОснования.ВидОперации = Перечисления.ВидыОперацийПоступлениеТоваровУслуг.Оборудование Тогда
			ВидОперации = Перечисления.ВидыОперацийРеализацияТоваров.Оборудование;
		Иначе
			ВидОперации = Документы.РеализацияТоваровУслуг.ОпределитьВидОперацииПоДокументуОснованию(
			ОбщегоНазначенияКлиентСервер.ЗначениеВМассиве(Основание));
		КонецЕсли;
		
		ТипСклада = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(ДанныеОснования.Склад, "ТипСклада");
		Если ТипСклада <> Перечисления.ТипыСкладов.НеавтоматизированнаяТорговаяТочка Тогда
			Склад = ДанныеОснования.Склад;
		КонецЕсли;
		
		Организация              = ДанныеОснования.Организация;
		ВалютаДокумента          = ДанныеОснования.ВалютаДокумента;
		ПодразделениеОрганизации = ДанныеОснования.ПодразделениеОрганизации;
		ЗаполнениеДокументов.Заполнить(ДокументРеализации);
		
		// Флаги включения налогов.
		Если ЗначениеЗаполнено(Основание.ТипЦен) Тогда
			СуммаВключаетНДС = ОбщегоНазначения.ЗначениеРеквизитаОбъекта(Основание.ТипЦен, "ЦенаВключаетНДС");
		Иначе
			СуммаВключаетНДС = Истина;
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры


&НаСервере
Функция СоздатьПодчиненныйДокумент(doc_owner_uuid, doc_type, doc_subtype, doc_wh_uuid, force = истина, post = истина) экспорт
	
	ДокОснование = РаботаСоСсылками.НайтиСсылкуПоУИД(doc_owner_uuid);
	Если ДокОснование = неопределено тогда
		Возврат неопределено;
	КонецЕсли;	
	
	ОсновнойСклад = РаботаСоСсылками.НайтиСсылкуПоУИД(doc_wh_uuid);
	Если ОсновнойСклад = неопределено тогда
	   Возврат неопределено;
	КонецЕсли;	
	
	МассивОснований = Новый Массив;
	МассивОснований.Добавить(ДокОснование);
	
	Если doc_type = "sales" тогда //Создать реализацию на основании счета на оплату
		
		//Если указан force тогда создаем реализацию в любом случае
		
		Если force тогда
			
			МассивДокументов = Новый Массив;
			
			//---------------------- Создание реализации ---------------------------- //
			ДокРеализации = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
			ДокРеализации.Организация = ДокОснование.Организация;
			ДокРеализации.Дата = НачалоДня(ДокОснование.Дата);
			ДокРеализации.СчетНаОплатуПокупателю = ДокОснование.Ссылка;
			Если doc_subtype = "goods" тогда
				ДокРеализации.ВидОперации = Перечисления.ВидыОперацийРеализацияТоваров.Товары;
			Иначе //Определить какой это тип реализации, услуги, комиссия
				ДокРеализации.ВидОперации = Перечисления.ВидыОперацийРеализацияТоваров.Товары;
			КонецЕсли;	
			
			ДокРеализации.Записать(РежимЗаписиДокумента.Запись);
			ЗаполнитьРеализациюПоДокументуОснованию(ДокРеализации, МассивОснований);
			ДокРеализации.ЗаполнитьПоСчету("Товары, Услуги, ВозвратнаяТара",МассивОснований,Истина);
			ЗаполнениеДокументов.Заполнить(ДокРеализации, неопределено, истина);
			ДокРеализации.Склад = ОсновнойСклад.Ссылка;

			Если НЕ post тогда
				ДокРеализации.Записать(РежимЗаписиДокумента.Запись);
			Иначе
				ДокРеализации.Записать(РежимЗаписиДокумента.Проведение);
			КонецЕсли;
			
			МассивДокументов.Добавить(ДокРеализации);
			
			//---------------------- Конец Создание реализации ---------------------------- //
			
		Иначе // force = false
			ТаблицаСвязанныхДокументов = ПолучитьСписокСвязанныхДокументов(ДокОснование);
			МассивРеализаций = Новый Массив;
			Для каждого Док из ТаблицаСвязанныхДокументов цикл
				Если (ТипЗнч(Док.Ссылка) = Тип("ДокументСсылка.РеализацияТоваровУслуг")) и (НЕ Док.Ссылка.ПометкаУдаления) тогда
					МассивРеализаций.Добавить(Док);
				КонецЕсли;	 
			КонецЦикла; 
			//Если в массиве нет не помеченных на удаление реализаций - создаем, иначе отдаем массив не создавая документов
			Если МассивРеализаций.Количество() = 0 тогда
				
				//---------------------- Создание реализации ---------------------------- //
				ДокРеализации = Документы.РеализацияТоваровУслуг.СоздатьДокумент();
				ДокРеализации.Организация = ДокОснование.Организация;
				ДокРеализации.Дата = НачалоДня(ДокОснование.Дата);
				ДокРеализации.СчетНаОплатуПокупателю = ДокОснование.Ссылка;
				ДокРеализации.Склад = ОсновнойСклад;
				Если doc_subtype = "goods" тогда
					ДокРеализации.ВидОперации = Перечисления.ВидыОперацийРеализацияТоваров.Товары;
				Иначе //Определить какой это тип реализации, услуги, комиссия
					ДокРеализации.ВидОперации = Перечисления.ВидыОперацийРеализацияТоваров.Товары;
				КонецЕсли;	
				
				ДокРеализации.Записать(РежимЗаписиДокумента.Запись);
				ЗаполнитьРеализациюПоДокументуОснованию(ДокРеализации, МассивОснований);
				ДокРеализации.ЗаполнитьПоСчету("Товары, Услуги, ВозвратнаяТара",МассивОснований,Истина);
				ЗаполнениеДокументов.Заполнить(ДокРеализации, неопределено, истина);
				ДокРеализации.Склад = ОсновнойСклад.Ссылка;

				Если НЕ post тогда
					ДокРеализации.Записать(РежимЗаписиДокумента.Запись);
				Иначе
					ДокРеализации.Записать(РежимЗаписиДокумента.Проведение);
				КонецЕсли;	
				
				МассивДокументов.Добавить(ДокРеализации);
				
				//---------------------- Конец Создание реализации ---------------------------- //
			иначе
				МассивДокументов = МассивРеализаций;
			КонецЕсли;	 
		КонецЕсли;
	Иначе 
		//Какой то другой документ
	КонецЕсли;
	
	Возврат МассивДокументов;
	
КонецФункции