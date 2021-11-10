﻿&НаСервере
Функция ПолучитьДопСведенияКАСтрокой(Владелец)
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ТелефоныКонтрагента.Наименование КАК Наименование
		|ИЗ
		|	Справочник.ТелефоныКонтрагента КАК ТелефоныКонтрагента
		|ГДЕ
		|	ТелефоныКонтрагента.Владелец = &Владелец
		|	И НЕ ТелефоныКонтрагента.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("Владелец", Владелец);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	НомераТелефонов = "";
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	    НомераТелефонов = НомераТелефонов + СокрЛП(ВыборкаДетальныеЗаписи.Наименование) + ";";
	КонецЦикла; 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	БанковскиеКартыКонтрагента.Наименование КАК Наименование
		|ИЗ
		|	Справочник.БанковскиеКартыКонтрагента КАК БанковскиеКартыКонтрагента
		|ГДЕ
		|	БанковскиеКартыКонтрагента.Владелец = &Владелец
		|	И НЕ БанковскиеКартыКонтрагента.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("Владелец", Владелец);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	НомераКарт = "";
	
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
	    НомераКарт = НомераКарт + СокрЛП(ВыборкаДетальныеЗаписи.Наименование) + ";";
	КонецЦикла;
	
	СтруктураВозврата = Новый Структура;
	СтруктураВозврата.Вставить("ТелефоныКонтрагентов", НомераТелефонов); 
	СтруктураВозврата.Вставить("БанковскиеКартыКонтрагентов", НомераКарт);

	Возврат СтруктураВозврата;
	
КонецФункции	


&После("ПередЗаписью")
Процедура инт_ПередЗаписью(Отказ)
	СтруктТелефоныКарты = ПолучитьДопСведенияКАСтрокой(ЭтотОбъект.Ссылка);
	ТелефоныКонтрагентаСтрокой = СтруктТелефоныКарты.ТелефоныКонтрагентов;
	БанковскиеКартыКонтрагентаСтрокой = СтруктТелефоныКарты.БанковскиеКартыКонтрагентов;
КонецПроцедуры
