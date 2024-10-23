select phone
from customer
wher phone not like '%(%' and phone not like '%)%';


select upper(left('lorem ipsum', 1)) || lower(substr('lorem ipsum', 2));


select name from track where name like '%run%'

select email from customer where email like '%gmail%'

select name, length(name) as sym_cnt
from track 
order by sym_cnt desc limit 1
	
	
select 
extract(month from invoice_date) AS month_id,
sum(total) as sales_sum
from invoice
where extract(year from invoice_date) = 2021
group by month_id;


select 
extract(month from invoice_date) AS month_id,
sum(total) as sales_sum,
to_char(invoice_date,'month') as month_name
from invoice
where extract(year from invoice_date) = 2021
group by month_id, month_name;

  
select concat(last_name , ' ', first_name) as full_name,
birth_date ,
extract(year from age(current_date, birth_date)) as age_now
from employee
order by age_now desc
limit 3;


select avg(extract (year from age(current_date, birth_date + INTERVAL '3 months 4 days'))) as new_date from employee


select 
extract(year from invoice_date) years,
billing_country as country,
SUM(total) as sales_sum
from invoice
group by years, country
having sum(total) > 20
order by years asc , sales_sum desc;




