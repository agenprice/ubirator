﻿
&НаСервере
Процедура инт_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	ЭтаФорма.Продукт = Объект.Продукт;
КонецПроцедуры

&НаСервере
Процедура инт_ПередЗаписьюНаСервереПеред(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	ТекущийОбъект.Продукт = ЭтаФорма.Продукт;
КонецПроцедуры
