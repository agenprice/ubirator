﻿
&НаСервере
Функция ЗаполнитьНаСервере(НачалоПериода, КонецПериода, ВидДокумента, Организация, Подразделение, Договор, Комментарий)
	
	Запрос = Новый Запрос;
	
	МассивДокументов = Новый Массив;
	
	Если ВидДокумента = Перечисления.ВидыДокументов.СчетНаОплатуПокупателю тогда
		
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	СчетНаОплатуПокупателю.Ссылка КАК Ссылка,
		|	СчетНаОплатуПокупателю.Продукт КАК Продукт
		|ИЗ
		|	Документ.СчетНаОплатуПокупателю КАК СчетНаОплатуПокупателю
		|ГДЕ
		|	СчетНаОплатуПокупателю.Дата МЕЖДУ &НачалоПериода И &КонецПериода И СчетНаОплатуПокупателю.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СчетНаОплатуПокупателю.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СчетНаОплатуПокупателю.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СчетНаОплатуПокупателю.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;
		
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.РеализацияТоваровУслуг тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	РеализацияТоваровУслуг.Ссылка КАК Ссылка,
		|	РеализацияТоваровУслуг.Продукт КАК Продукт
		|ИЗ
		|	Документ.РеализацияТоваровУслуг КАК РеализацияТоваровУслуг
		|ГДЕ
		|	РеализацияТоваровУслуг.Дата МЕЖДУ &НачалоПериода И &КонецПериода И РеализацияТоваровУслуг.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И РеализацияТоваровУслуг.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И РеализацияТоваровУслуг.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И РеализацияТоваровУслуг.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;
		
		
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.ПриходныйКассовыйОрдер тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПриходныйКассовыйОрдер.Ссылка КАК Ссылка,
		|	ПриходныйКассовыйОрдер.Продукт КАК Продукт
		|ИЗ
		|	Документ.ПриходныйКассовыйОрдер КАК ПриходныйКассовыйОрдер
		|ГДЕ
		|	ПриходныйКассовыйОрдер.Дата МЕЖДУ &НачалоПериода И &КонецПериода И ПриходныйКассовыйОрдер.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПриходныйКассовыйОрдер.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПриходныйКассовыйОрдер.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПриходныйКассовыйОрдер.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;
		
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.РасходныйКассовыйОрдер тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	РасходныйКассовыйОрдер.Ссылка КАК Ссылка,
		|	РасходныйКассовыйОрдер.Продукт КАК Продукт
		|ИЗ
		|	Документ.РасходныйКассовыйОрдер КАК РасходныйКассовыйОрдер
		|ГДЕ
		|	РасходныйКассовыйОрдер.Дата МЕЖДУ &НачалоПериода И &КонецПериода И РасходныйКассовыйОрдер.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И РасходныйКассовыйОрдер.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И РасходныйКассовыйОрдер.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И РасходныйКассовыйОрдер.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;
		
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.ПоступлениеНаРасчетныйСчет тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПоступлениеНаРасчетныйСчет.Ссылка КАК Ссылка,
		|	ПоступлениеНаРасчетныйСчет.Продукт КАК Продукт
		|ИЗ
		|	Документ.ПоступлениеНаРасчетныйСчет КАК ПоступлениеНаРасчетныйСчет
		|ГДЕ
		|	ПоступлениеНаРасчетныйСчет.Дата МЕЖДУ &НачалоПериода И &КонецПериода И ПоступлениеНаРасчетныйСчет.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеНаРасчетныйСчет.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеНаРасчетныйСчет.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеНаРасчетныйСчет.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;
		
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.СписаниеСРасчетногоСчета тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	СписаниеСРасчетногоСчета.Ссылка КАК Ссылка,
		|	СписаниеСРасчетногоСчета.Продукт КАК Продукт
		|ИЗ
		|	Документ.СписаниеСРасчетногоСчета КАК СписаниеСРасчетногоСчета
		|ГДЕ
		|	СписаниеСРасчетногоСчета.Дата МЕЖДУ &НачалоПериода И &КонецПериода И СписаниеСРасчетногоСчета.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СписаниеСРасчетногоСчета.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СписаниеСРасчетногоСчета.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СписаниеСРасчетногоСчета.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;

	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.ПоступлениеТоваровУслуг тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПоступлениеТоваровУслуг.Ссылка КАК Ссылка,
		|	ПоступлениеТоваровУслуг.Продукт КАК Продукт
		|ИЗ
		|	Документ.ПоступлениеТоваровУслуг КАК ПоступлениеТоваровУслуг
		|ГДЕ
		|	ПоступлениеТоваровУслуг.Дата МЕЖДУ &НачалоПериода И &КонецПериода И ПоступлениеТоваровУслуг.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеТоваровУслуг.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеТоваровУслуг.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеТоваровУслуг.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;
		
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.СчетНаОплатуПоставщика тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	СчетНаОплатуПоставщика.Ссылка КАК Ссылка,
		|	СчетНаОплатуПоставщика.Продукт КАК Продукт
		|ИЗ
		|	Документ.СчетНаОплатуПоставщика КАК СчетНаОплатуПоставщика
		|ГДЕ
		|	СчетНаОплатуПоставщика.Дата МЕЖДУ &НачалоПериода И &КонецПериода И СчетНаОплатуПоставщика.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СчетНаОплатуПоставщика.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СчетНаОплатуПоставщика.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И СчетНаОплатуПоставщика.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;
		
		
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.ПоступлениеДопРасходов тогда
		Запрос.Текст = 
		"ВЫБРАТЬ
		|	ПоступлениеДопРасходов.Ссылка КАК Ссылка,
		|	ПоступлениеДопРасходов.Продукт КАК Продукт
		|ИЗ
		|	Документ.ПоступлениеДопРасходов КАК ПоступлениеДопРасходов
		|ГДЕ
		|	ПоступлениеДопРасходов.Дата МЕЖДУ &НачалоПериода И &КонецПериода И ПоступлениеДопРасходов.Организация = &Организация";
		
		Если НЕ Подразделение = Справочники.ПодразделенияОрганизаций.ПустаяСсылка() тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеДопРасходов.ПодразделениеОрганизации = &Подразделение";
			Запрос.УстановитьПараметр("Подразделение", Подразделение);
		КонецЕсли;
		
		Если НЕ СокрЛП(Договор) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеДопРасходов.ДоговорКонтрагента.Наименование ПОДОБНО &Договор";
			Запрос.УстановитьПараметр("Договор", "%"+Договор+"%");
		КонецЕсли;
		
		Если НЕ СокрЛП(Комментарий) = "" тогда 
			Запрос.Текст = Запрос.Текст + 
			"	И ПоступлениеДопРасходов.Комментарий ПОДОБНО &Комментарий";
			Запрос.УстановитьПараметр("Комментарий", "%"+Комментарий+"%");
		КонецЕсли;
		
	Иначе
		
	КонецЕсли;
	
	Запрос.УстановитьПараметр("НачалоПериода", НачалоДня(НачалоПериода));
	Запрос.УстановитьПараметр("КонецПериода", КонецДня(КонецПериода));
	Запрос.УстановитьПараметр("Организация", Организация);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		СтруктураДокумента = Новый Структура;
		СтруктураДокумента.Вставить("Документ", ВыборкаДетальныеЗаписи.Ссылка);
		СтруктураДокумента.Вставить("Продукт", ВыборкаДетальныеЗаписи.Продукт);
		МассивДокументов.Добавить(СтруктураДокумента);
	КонецЦикла;
	
	Возврат МассивДокументов;
	
КонецФункции

&НаКлиенте
Процедура Заполнить(Команда)
	МассивДокументов = ЗаполнитьНаСервере(Объект.НачалоПериода, Объект.КонецПериода, Объект.ВидДокумента, Объект.Организация, Объект.Подразделение, Объект.Договор, Объект.Комментарий);
	Объект.СписокДокументов.Очистить();
	Для Каждого СтруктураДокумента из МассивДокументов цикл
		СтрокаТЧ = Объект.СписокДокументов.Добавить();
		СтрокаТЧ.Документ = СтруктураДокумента.Документ;
		СтрокаТЧ.Продукт = СтруктураДокумента.Продукт;
	КонецЦикла;	
	
КонецПроцедуры

&НаСервере
Функция ОбновитьНаСервере(Документ, Продукт, ВидДокумента)
	
	Рез = Ложь;
	
	Если ВидДокумента = Перечисления.ВидыДокументов.СчетНаОплатуПокупателю тогда
		ДокСсылка = Документы.СчетНаОплатуПокупателю.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.РеализацияТоваровУслуг тогда
		ДокСсылка = Документы.РеализацияТоваровУслуг.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.ПриходныйКассовыйОрдер тогда
		ДокСсылка = Документы.ПриходныйКассовыйОрдер.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.РасходныйКассовыйОрдер тогда
		ДокСсылка = Документы.РасходныйКассовыйОрдер.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.ПоступлениеНаРасчетныйСчет тогда
		ДокСсылка = Документы.ПоступлениеНаРасчетныйСчет.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.СписаниеСРасчетногоСчета тогда
		ДокСсылка = Документы.СписаниеСРасчетногоСчета.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.ПоступлениеТоваровУслуг тогда
		ДокСсылка = Документы.ПоступлениеТоваровУслуг.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.СчетНаОплатуПоставщика тогда
		ДокСсылка = Документы.СчетНаОплатуПоставщика.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	ИначеЕсли ВидДокумента = Перечисления.ВидыДокументов.ПоступлениеДопРасходов тогда
		ДокСсылка = Документы.ПоступлениеДопРасходов.ПолучитьСсылку(Документ.УникальныйИдентификатор());
	Иначе
		 Рез = Ложь;
	 КонецЕсли;
	 
	 Попытка
		 Док = ДокСсылка.ПолучитьОбъект();
		 Док.Продукт = Продукт;
		 Док.Записать(РежимЗаписиДокумента.Запись);
		 Рез = Истина;
	 Исключение
		 Рез = Ложь;
	 КонецПопытки;
	 
	 Возврат Рез;
		 
КонецФункции

&НаКлиенте
Процедура Обновить(Команда)
	
	Для Каждого СтрокаТЧ из Объект.СписокДокументов Цикл
		ДокументОбновлен = ОбновитьНаСервере(СтрокаТЧ.Документ, Объект.Продукт, Объект.ВидДокумента);
		Если ДокументОбновлен тогда
			СтрокаТЧ.Продукт = Объект.Продукт;
			СтрокаТЧ.Обновлен = Истина;
			Сообщить("Обработан документ: " + Строка(СтрокаТЧ.Документ));
		Иначе
			Сообщить("Не удалось записать документ: " + Строка(СтрокаТЧ.Документ) + ". Возможно он находится в закрытом периоде.");
		КонецЕсли;	
	КонецЦикла;
КонецПроцедуры
