select * from customer support_rep_id

select * from track 

-- Задача №1
select e.employee_id, 
concat(e.first_name, ' ', e.last_name)as full_name,
count(c.customer_id) as total_cust,
round(count(c.customer_id) * 100.0 / sum(count(c.customer_id)) over(), 2) AS customer_percentage
from employee e left join customer c on e.employee_id =  c.support_rep_id
group by e.employee_id, e.first_name, e.last_name

-- Задача №2
select a.title, t.composer
from album a join track t on a.album_id = t.album_id 
left join invoice_line il on t.track_id = il.track_id 
where il.track_id is null 

-- Задача №3
select 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) as full_name,
    extract(year from i.invoice_date) * 100 + extract(month from i.invoice_date) as monthkey,
    SUM(i.total) as total,
    SUM(i.total) / SUM(SUM(i.total)) OVER(PARTITION BY DATE_TRUNC('month', i.invoice_date)) * 100 AS sales_percentage
   -- SUM(i.total) OVER(PARTITION BY c.customer_id ORDER BY i.invoice_date) AS running_total
from customer c
join invoice i on c.customer_id = i.customer_id
group by c.customer_id, monthkey, i.invoice_date
order by c.customer_id

-- Задача №4
select e.employee_id, e.first_name
from employee e
WHERE 
    e.employee_id NOT IN (SELECT DISTINCT reports_to FROM employee WHERE reports_to IS NOT NULL)

-- Задача №5
select 
	c.customer_id,
	CONCAT(c.first_name, ' ', c.last_name) as full_name,
	min(i.invoice_date) as first_purchase_date, 
	max(i.invoice_date) as last_purchase_date,
	floor(extract('day' from max(i.invoice_date) - min(i.invoice_date)) / 365) as diff_in_years
from invoice i
left join customer c on i.customer_id = c.customer_id
group by c.customer_id


select * from album a 

-- Задача №6
select
	year, 
	album_name, 
	artist_name, 
	total_tracks_sold
from (
select 
	extract(year from i.invoice_date) as year, 
	a.title as album_name,
	ar.name as artist_name, 
	count(il.track_id) as total_tracks_sold, 
	row_number() over (partition by extract(year from i.invoice_date) order by count(il.track_id) desc) as rank 
from invoice_line il 
join invoice i on il.invoice_id = i.invoice_id 
join track t on il.track_id = t.track_id 
join album a on t.album_id = a.album_id 
join artist ar on a.artist_id = ar.artist_id 
group by year, album_name, artist_name)
as ranked_albums 
where rank <= 3 order by year, rank;

-- Задача №7
select t.track_id, t.name
from track t
join invoice_line il on t.track_id = il.track_id
join invoice i on il.invoice_id = i.invoice_id
where i.billing_country in ('Canada', 'USA')
group by t.track_id, t.name
having count(distinct i.billing_country) = 2;

-- Задача №8
select distinct t.track_id, t.name
from track t
join invoice_line il on t.track_id = il.track_id
join invoice i on il.invoice_id = i.invoice_id
where i.billing_country = 'Canada'
and t.track_id not in (
select il_us.track_id
    from invoice_line il_us
    join invoice i_us on il_us.invoice_id = i_us.invoice_id
    where i_us.billing_country = 'USA')





