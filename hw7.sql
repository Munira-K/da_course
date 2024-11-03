select * from invoice i 

select * from employee 

-- 1.
select 
    e1.employee_id,
    concat(e1.first_name, ' ', e1.last_name) as employee_name,
    e1.title as employee_title,
    e1.reports_to as manager_id,
    concat(e2.first_name, ' ', e2.last_name) as manager_name,
    e2.title as manager_title
from employee e1
left join employee e2 on e1.reports_to = e2.employee_id
order by e1.employee_id;

-- 2, 3, 4, 5, 6
with total_revenue_2024 as 
(select sum(total) as total
from invoice
where extract(year from invoice_date) = 2024)
select 
    i.invoice_id,
    i.invoice_date,
    extract(year from i.invoice_date) * 100 + extract(month from i.invoice_date) as monthkey,
    i.customer_id,
    i.total,
    c.email,
    round(i.total / tr.total * 100, 2) as invoice_percentage,
    round(sum(i.total) over (partition by i.customer_id) / tr.total * 100, 2) as customer_percentage
from invoice i
join customer c on i.customer_id = c.customer_id
cross join total_revenue_2024 tr
where c.email not ilike '%gmail%'
order by i.invoice_date;







