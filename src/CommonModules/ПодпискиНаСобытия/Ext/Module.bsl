Процедура ОбновитьЗаписиРегистраНомераТелефоновСводно(Контрагент, ТелефоныСтрокой)
	
	НаборЗаписей = РегистрыСведений.НомераТелефоновСводно.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Контрагент.Установить(Контрагент);
	НаборЗаписей.Прочитать();
	
	Если НаборЗаписей.Количество() = 0 Тогда
		НоваяЗапсиь = НаборЗаписей.Добавить();
		НоваяЗапсиь.Контрагент = Контрагент;
		НоваяЗапсиь.ТелефоныСтрокой = ТелефоныСтрокой;
	Иначе	
		НаборЗаписей[0].Контрагент = Контрагент;
		НаборЗаписей[0].ТелефоныСтрокой = ТелефоныСтрокой;
	КонецЕсли;
	
	НаборЗаписей.Записать(); 
	
КонецПроцедуры

Процедура ОбновитьЗаписиРегистраНомераКартСводно(Контрагент, КартыСтрокой)
	
	НаборЗаписей = РегистрыСведений.НомераКартСводно.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Контрагент.Установить(Контрагент);
	НаборЗаписей.Прочитать();
	
	Если НаборЗаписей.Количество() = 0 Тогда
		НоваяЗапсиь = НаборЗаписей.Добавить();
		НоваяЗапсиь.Контрагент = Контрагент;
		НоваяЗапсиь.КартыСтрокой = КартыСтрокой;
	Иначе	
		НаборЗаписей[0].Контрагент = Контрагент;
		НаборЗаписей[0].КартыСтрокой = КартыСтрокой;
	КонецЕсли;
	
	НаборЗаписей.Записать(); 
	
КонецПроцедуры

Процедура ЗаписьНомеровТелефоновПриЗаписи(Источник, Отказ) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ТелефоныКонтрагента.Наименование КАК Наименование
	|ИЗ
	|	Справочник.ТелефоныКонтрагента КАК ТелефоныКонтрагента
	|ГДЕ
	|	ТелефоныКонтрагента.Владелец = &Владелец
	|	И НЕ ТелефоныКонтрагента.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("Владелец", Источник.Владелец);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	ТелефоныСтрокой = "";
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		ТелефоныСтрокой = ТелефоныСтрокой + СокрЛП(ВыборкаДетальныеЗаписи.Наименование) + ";"; 
	КонецЦикла;
	
	ОбновитьЗаписиРегистраНомераТелефоновСводно(Источник.Владелец, ТелефоныСтрокой);
	
КонецПроцедуры

Процедура ЗаписьНомеровКартПриЗаписи(Источник, Отказ) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	БанковскиеКартыКонтрагента.Наименование КАК Наименование
	|ИЗ
	|	Справочник.БанковскиеКартыКонтрагента КАК БанковскиеКартыКонтрагента
	|ГДЕ
	|	БанковскиеКартыКонтрагента.Владелец = &Владелец
	|	И НЕ БанковскиеКартыКонтрагента.ПометкаУдаления";
	
	Запрос.УстановитьПараметр("Владелец", Источник.Владелец);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	КартыСтрокой = "";
	Пока ВыборкаДетальныеЗаписи.Следующий() Цикл
		КартыСтрокой = КартыСтрокой + СокрЛП(ВыборкаДетальныеЗаписи.Наименование) + ";"; 
	КонецЦикла;
	
	ОбновитьЗаписиРегистраНомераКартСводно(Источник.Владелец, КартыСтрокой);
	
КонецПроцедуры
