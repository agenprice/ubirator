﻿&НаСервере
// <Описание функции>
//
// Параметры:
//  <HTTPМетод>  - Строка, содержащая имя HTTP-метода для запроса ("POST"."PATCH", "PUT" ,"GET","DELETE"
//  <HTTPСоединение>  - объект HTTPСоединение
//  <АдресРесурса>  - Строка http-ресурса, к которому будет отправлен HTTP запрос.
//  <ОтправляемыеДанные>  - Структура или соответствие, содержащие данные, отправляемые на указанный адрес для обработки  
//                     на сервер с использованием указанного HTTP-метода "POST" или "PATCH" или  "PUT" 
// Возвращаемое значение:
//   Структура ответа сервера в зависимости от HTTPМетод
//
Функция ВызватьHTTPМетодНаСервере(HTTPМетод,HTTPСоединение,АдресРесурса,ОтправляемыеДанные = Неопределено) экспорт
	
	СтруктураОтвета = Новый Структура;
	
	//  Создание HTTPЗапрос
	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Content-Type", "application/json");
	ЗапросHTTP = Новый HTTPЗапрос( АдресРесурса, Заголовки);
	//  ЗаписьJson толка для создания и обновление данных
	Если HTTPМетод= "POST" или HTTPМетод="PATCH" или HTTPМетод="PUT" Тогда
		Попытка
			ЗаписьJSON = Новый ЗаписьJSON; 
			ПараметрыJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Авто,"",Истина);	
			ЗаписьJSON.УстановитьСтроку(ПараметрыJSON);
			ЗаписатьJSON(ЗаписьJSON, ОтправляемыеДанные); // ОтправляемыеДанные обязательны в этом случае
			СтрокаДляТела = ЗаписьJSON.Закрыть();
			ЗапросHTTP.УстановитьТелоИзСтроки(СтрокаДляТела,КодировкаТекста.UTF8, ИспользованиеByteOrderMark.НеИспользовать);
			ОтветHTTP = HTTPСоединение.ВызватьHTTPМетод(HTTPМетод, ЗапросHTTP);
			ЧтениеJSON = Новый ЧтениеJSON;
			ЧтениеJSON.УстановитьСтроку(ОтветHTTP.ПолучитьТелоКакСтроку());
			СтруктураОтвета = ПрочитатьJSON(ЧтениеJSON, Ложь);
		Исключение
			СтруктураОтвета = Неопределено;
		КонецПопытки	
		// ЧтениеJSON только для метода GET
	ИначеЕсли HTTPМетод= "GET"  Тогда
		Попытка
			ЗапросHTTP.УстановитьТелоИзСтроки("",КодировкаТекста.UTF8, ИспользованиеByteOrderMark.НеИспользовать);
			ОтветHTTP = HTTPСоединение.ВызватьHTTPМетод(HTTPМетод, ЗапросHTTP);
			ЧтениеJSON = Новый ЧтениеJSON;
			ЧтениеJSON.УстановитьСтроку(ОтветHTTP.ПолучитьТелоКакСтроку());
			СтруктураОтвета = ПрочитатьJSON(ЧтениеJSON, Ложь);
		Исключение
			СтруктураОтвета = Неопределено;
		КонецПопытки;
	Конецесли;
	Возврат СтруктураОтвета;
КонецФункции // ВызватьHTTPМетодНаСервере()

&НаСервере
Функция СформироватьHTTPЗапрос(ДанныеПрофиляОбмена, ОтправляемыеДанные = Неопределено) экспорт
	
	Адрес = ДанныеПрофиляОбмена.ИмяWEBСервера;
	Пользователь = ДанныеПрофиляОбмена.Пользователь;
	Пароль = ДанныеПрофиляОбмена.Пароль;
	ИмяБазы = ДанныеПрофиляОбмена.ИмяБД;
	Порт = ДанныеПрофиляОбмена.Порт;
	Ресурс = ДанныеПрофиляОбмена.Ресурс;
	Метод = Строка(ДанныеПрофиляОбмена.Метод);
	HTTPСоединение = Новый HTTPСоединение(Адрес, Порт, Пользователь, Пароль);
	
	
	//АдресРесурса = ИмяБазы + "/hs/int/getdata/post";
	АдресРесурса = ИмяБазы + Ресурс;
	СтруктураОтвета = ВызватьHTTPМетодНаСервере(Метод, HTTPСоединение, АдресРесурса, ОтправляемыеДанные); 
	
	// ----- Если вернулось не понятно что, формируем state -------- //
	Если СтруктураОтвета = Неопределено Тогда
		СтруктураОтвета = Новый Структура("state", Неопределено);
	КонецЕсли;
	
	Возврат СтруктураОтвета;
КонецФункции

&НаСервере
Функция СформироватьJSON(Структура) экспорт
	ЗаписьJSON = Новый ЗаписьJSON;
	ЗаписьJSON.УстановитьСтроку(Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Нет,Символы.Таб,Истина));
	
	НастройкиСериализацииJSON = Новый НастройкиСериализацииJSON;
	НастройкиСериализацииJSON.ВариантЗаписиДаты = ВариантЗаписиДатыJSON.ЛокальнаяДатаСоСмещением;
	НастройкиСериализацииJSON.ФорматСериализацииДаты = ФорматДатыJSON.ISO;
	ЗаписатьJSON(ЗаписьJSON, Структура, НастройкиСериализацииJSON);
	
	Возврат ЗаписьJSON.Закрыть();
КонецФункции

&НаСервере
Функция ПолучитьДанныеJSON(ЗапросСтруктура) экспорт
	
	ИдентификаторЗапроса = ЗапросСтруктура.ident;
	ПараметрыЗапроса = ЗапросСтруктура.params;
	
	Если СокрЛП(ИдентификаторЗапроса) = "create_linked_doc" тогда
			 Результат = СвязанныеДокументы.СоздатьПодчиненныйДокумент(ПараметрыЗапроса.doc_owner_uuid, ПараметрыЗапроса.doc_type, ПараметрыЗапроса.doc_subtype, ПараметрыЗапроса.doc_wh_uuid, ПараметрыЗапроса.force, ПараметрыЗапроса.post);
	КонецЕсли;	
		 
	Если СокрЛП(ИдентификаторЗапроса) = "create_all_linked_docs" тогда
			 doc_owner_uuid = ЗапросСтруктура.doc_owner_uuid;
			 Результат = СвязанныеДокументы.СоздатьВсеПодчиненныеДокументы(doc_owner_uuid, ПараметрыЗапроса);
	КонецЕсли;	
	 
	
	Возврат Результат;
	
КонецФункции	


