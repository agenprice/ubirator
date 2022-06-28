﻿&НаСервере
Функция ПолучитьНаименованиеНоменклатурыКонтрагента(Контрагент, Номенклатура)
	
	СтруктураНоменклатураПоставшика = Новый Структура;
	СтруктураНоменклатураПоставшика.Вставить("НоменклатураПоставщика", неопределено);
	СтруктураНоменклатураПоставшика.Вставить("НазваниеНоменклатурыПоставщика", "");

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ РАЗРЕШЕННЫЕ
		|	НоменклатураКонтрагентов.Ссылка КАК НоменклатураПоставщика,
		|	НоменклатураКонтрагентов.НаименованиеПолное КАК НаименованиеПолноеКонтрагента,
		|	НоменклатураКонтрагентов.НаименованиеХарактеристики КАК НаименованиеХарактеристики,
		|	НоменклатураКонтрагентов.НаименованиеУпаковки КАК НаименованиеУпаковки
		|ИЗ
		|	Справочник.НоменклатураКонтрагентов КАК НоменклатураКонтрагентов
		|ГДЕ
		|	НоменклатураКонтрагентов.ПометкаУдаления = ЛОЖЬ
		|	И НоменклатураКонтрагентов.ВладелецНоменклатуры = &Контрагент
		|	И НоменклатураКонтрагентов.Номенклатура = &Номенклатура";
	
	Запрос.УстановитьПараметр("Контрагент", Контрагент);
	Запрос.УстановитьПараметр("Номенклатура", Номенклатура);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СтруктураНоменклатураПоставшика.Вставить("НоменклатураПоставщика", ВыборкаДетальныеЗаписи.НоменклатураПоставщика);
		СтруктураНоменклатураПоставшика.Вставить("НазваниеНоменклатурыПоставщика", ВыборкаДетальныеЗаписи.НаименованиеПолноеКонтрагента);
	КонецЦикла;
	
	Возврат СтруктураНоменклатураПоставшика;
	
КонецФункции


&Вместо("ТабличныйДокументУПД")
Функция инт_ТабличныйДокументУПД(Макет, МассивОбъектов, ОбъектыПечати, ТабДокумент, ТекстЗапросаДокументам, ТолькоПередаточныйДокумент, ПараметрыПечати)
	// Исключим из массива документы на чтение которых у пользователя нет прав
	УправлениеДоступомБП.УдалитьНедоступныеЭлементыИзМассива(МассивОбъектов);

	УстановитьПривилегированныйРежим(Истина);

	Если МассивОбъектов.Количество() = 0 Тогда
		ДанныеУниверсальныхПередаточныхДокументов = НовыйТаблицаСчетовФактур();
	ИначеЕсли ТолькоПередаточныйДокумент Тогда
		ДанныеУниверсальныхПередаточныхДокументов = ПолучитьДанныеДляПечатиУниверсальногоПередаточногоДокумента(
		МассивОбъектов, ТекстЗапросаДокументам);
	Иначе
		ДанныеУниверсальныхПередаточныхДокументов = ПолучитьДанныеДляПечатиСчетаФактуры1137(
		МассивОбъектов, ТекстЗапросаДокументам, Истина);
	КонецЕсли;

	ПервыйДокумент = Истина;

	Для Каждого ВыборкаУПД ИЗ ДанныеУниверсальныхПередаточныхДокументов Цикл

		Если ЗначениеЗаполнено(ВыборкаУПД.Дата)
			И ВыборкаУПД.Дата < '20130101'
			И ТипЗнч(ВыборкаУПД.СчетФактура) <> Тип("ДокументСсылка.СчетФактураПолученный") Тогда
			Продолжить;
		КонецЕсли;

		ТаблицаДокумента = ВыборкаУПД.ТаблицаДокумента;
		Если ТаблицаДокумента = Неопределено Тогда
			Продолжить;
			
		// + agen Подменяем номенклатуру	
		Иначе	
			Для Каждого СтрТаблицы из ТаблицаДокумента цикл
					СтрНоменклатураПоставщика = ПолучитьНаименованиеНоменклатурыКонтрагента(МассивОбъектов[0].Контрагент, СтрТаблицы.Товар);
					Если СтрНоменклатураПоставщика.НоменклатураПоставщика = неопределено тогда
						Продолжить;
					КонецЕсли;	
					СтрТаблицы.Товар = СтрНоменклатураПоставщика.НоменклатураПоставщика;
					СтрТаблицы.ТоварНаименование = СтрНоменклатураПоставщика.НазваниеНоменклатурыПоставщика;
			КонецЦикла;	
		КонецЕсли; 
		// agen

		Если НЕ ПервыйДокумент Тогда
			ТабДокумент.ВывестиГоризонтальныйРазделительСтраниц();
		КонецЕсли;
		ПервыйДокумент = Ложь;

		// Запомним номер строки, с которой начали выводить текущий документ.
		НомерСтрокиНачало = ТабДокумент.ВысотаТаблицы + 1;

		ВывестиСчетФактуруВТабличныйДокумент(ТабДокумент, Макет, ВыборкаУПД, Истина);

		// Вывод подвала накладной
		ОбластьМакета = Макет.ПолучитьОбласть("ПодвалНакладной");
		ОбластьМакета.Параметры.Заполнить(ВыборкаУПД.ДанныеШапки);
		ТабДокумент.Вывести(ОбластьМакета);

		// В табличном документе зададим имя области, в которую был выведен объект.
		// Нужно для возможности печати покомплектно.
		УправлениеПечатью.ЗадатьОбластьПечатиДокумента(
		ТабДокумент, НомерСтрокиНачало, ОбъектыПечати, ВыборкаУПД.Ссылка);

		УправлениеПечатьюБП.ДополнитьДокументПодписьюИПечатью(ТабДокумент, ВыборкаУПД, ОбъектыПечати, ПараметрыПечати);

	КонецЦикла;

	Если МассивОбъектов.Количество() = 1 И ПервыйДокумент Тогда
		СообщениеОбОшибке = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
		НСтр("ru='Для %1 универсальный передаточный документ не применяется'"), Строка(МассивОбъектов[0]));
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(СообщениеОбОшибке);
	КонецЕсли;

	Возврат ТабДокумент;

КонецФункции
