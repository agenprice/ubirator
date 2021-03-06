
&НаСервере
Процедура инт_ПриСозданииНаСервереПосле(Отказ, СтандартнаяОбработка)
	ЭтаФорма.Продукт = Объект.Продукт; 
	ЭтаФорма.СтатьяРасходовУУ = Объект.СтатьяРасходовУУ;
КонецПроцедуры

&НаСервере
Процедура инт_ПродуктПриИзмененииВместоНаСервере(Структ)
	Объект.Продукт = Структ.Продукт;
	Объект.СтатьяРасходовУУ= Структ.СтатьяРасходовУУ;
КонецПроцедуры

&НаКлиенте
Процедура инт_ПродуктПриИзмененииВместо(Элемент)
	Структ = Новый Структура;
	Структ.Вставить("Продукт", ЭтаФорма.Продукт);
	Структ.Вставить("СтатьяРасходовУУ", ЭтаФорма.СтатьяРасходовУУ);
	инт_ПродуктПриИзмененииВместоНаСервере(Структ);
КонецПроцедуры

&НаКлиенте
Процедура инт_СтатьяРасходовУУПриИзмененииВместо(Элемент)
	Структ = Новый Структура;
	Структ.Вставить("Продукт", ЭтаФорма.Продукт);
	Структ.Вставить("СтатьяРасходовУУ", ЭтаФорма.СтатьяРасходовУУ);
	инт_ПродуктПриИзмененииВместоНаСервере(Структ);
КонецПроцедуры
