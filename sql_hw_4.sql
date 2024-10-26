/*
	1. Курбанова Мунира

	Описание задач: 
3. Напишите код, который вернёт из таблицы `track` поля *name* и *genreid*
4. Напишите код, который вернёт из таблицы `track` поля *name*, *composer*, *unitprice*. Переименуйте поля на *song*, *author* и *price* соответственно. Расположите поля так, чтобы сначало следовало название произведения, далее его цена и в конце список авторов.
5. Напишите код, который вернёт из таблицы `track` название произведения и его длительность в минутах. Результат должен быть отсортирован по длительности произведения по убыванию.
6. Напишите код, который вернёт из таблицы `track` поля *name* и *genreid*, и **только первые 15 строк**.
7. Напишите код, который вернёт из таблицы `track` все поля и все строки начиная **с 50-й строки**.
8. Напишите код, который вернёт из таблицы `track` названия всех произведений, чей объём **больше 100 мегабайт**.
9. Напишите код, который вернёт из таблицы `track` поля name и composer, где composer **не равен "U2"**. Код должен вернуть записи **с 10 по 20-й включительно**.
10. Напишите код, который из таблицы `invoice` вернёт дату самой первой и самой последней покупки.
11. Напишите код, который вернёт размер среднего чека для покупок из **США**.
12. Напишите код, который вернёт список городов в которых имеется **более одного клиента**.
*/

select name, genre_id from track;

select
name as song, 
unit_price as prise,
composer as autor
FROM track;

select name, milliseconds/60000 as min from track;

select name, genre_id from track limit 15;

select * from track offset 49;

select * from track where bytes > 100;

select name, composer 
from track 
where composer <> 'U2'
OFFSET 9 limit 20

SELECT 
min(invoice_date),
max() (invoice_date)
FROM invoice;
   

select avg(total) from invoice where billing_country = 'USA'

select billing_country
from invoice 
group by billing_country
having COUNT(customer_id) > 1;