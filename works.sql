--Q1 we need to know the sales managers full name, his total sales (based on car price), and the percentage of his target left (based on car price)
select "first_name" || ' ' || "last_name" as "full_name", t2.month_name,
sm.monthly_target,sum(c.car_price) over (partition by t2.month_name, sm.sales_manager_id) as "total_sales",
((sm.monthly_target - sum(c.car_price))/(sm.monthly_target))*100 as "percentage_left"
from
(select *,
case when "month" = 4 then 'Aprail'
     when "month" = 5 then 'May'
     when "month" = 6 then 'June'
     when "month" = 7 then 'July'
     when "month" = 8 then 'August'
else 'September' end as "month_name"
from
(select *, extract(month from "sold_on") as "month"
from "sales_data") as t1) as t2
join "sales_team" sm
on sm.sales_manager_id = t2.sales_manager_id
join "cars_data" c
on c.car_code = t2.customer_car_code
group by "full_name", t2.month_name, sm.monthly_target, c.car_price, sm.sales_manager_id
order by full_name,"percentage_left"


--Q2
--for the sales manager with sales manager id as 12134 which car constituted how much percentage of his target
select "first_name" || ' ' || "last_name" as "full_name", t2.month_name, car_name,
sm.monthly_target,sum(c.car_price) over (partition by t2.month_name, sm.sales_manager_id) as "total_sales",
((sm.monthly_target - sum(c.car_price))/(sm.monthly_target))*100 as "percentage_left"
from
(select *,
case when "month" = 4 then 'Aprail'
     when "month" = 5 then 'May'
     when "month" = 6 then 'June'
     when "month" = 7 then 'July'
     when "month" = 8 then 'August'
else 'September' end as "month_name"
from
(select *, extract(month from "sold_on") as "month"
from "sales_data") as t1) as t2
join "sales_team" sm
on sm.sales_manager_id = t2.sales_manager_id
join "cars_data" c
on c.car_code = t2.customer_car_code
where  sm.sales_manager_id = 12134
group by "full_name", t2.month_name, sm.monthly_target, c.car_price, sm.sales_manager_id, car_name

--Q3
--who has the least and the most deposit collected as a percentage of the total price of cars sold by each sales manager
select "first_name" || ' ' || "last_name" as "full_name", 
Round(sum(sd.deposit_paid_for_booking)/sum(c.car_price)*100, 2) as percentage_deposit,
case
    when rank() over(order by Round(sum(sd.deposit_paid_for_booking)/sum(c.car_price)*100, 2)) = 1 then 'minimum'
    when rank() over(order by Round(sum(sd.deposit_paid_for_booking)/sum(c.car_price)*100, 2)) = 3 then 'maximum'
end as "min_max"
from "sales_data" sd
join "sales_team" sm
on sm.sales_manager_id = sd.sales_manager_id
join "cars_data" c
on c.car_code = sd.customer_car_code
group by "full_name"
order by percentage_deposit desc;

--Q4
--which car contributed to the minimum sales for each sales manager and what is the amount
--(find the sales managers full name, the name of the car that contributed to the least sales by car price)
--total amount for that car sold
with cte as (
select "first_name" || ' ' || "last_name" as "full_name",
'$'|| min(c.car_price) as "total_amount", row_number()
over (partition by st.sales_manager_id
order by min ("first_name" || ' ' || "last_name")) as rn,
case
    when row_number() over (partition by st.sales_manager_id
	order by min(c.car_price)) = 1 then c.car_name
else null
end as "car_name"
from "sales_data" sd
join "sales_team" st
on st.sales_manager_id = sd.sales_manager_id
join "cars_data" c
on c.car_code = sd.customer_car_code
group by "full_name", c.car_name, st.sales_manager_id, c.car_price
)
select "full_name", "total_amount", "car_name"
from cte
where rn<2
order by "total_amount" asc;

--Q5
--what is the average number of days between cars sold?(find the average number of days from one sales to the next)
select Round(avg(s2.sold_on - s1.sold_on), 2) as Avg_diff
from "sales_data" s1
join sales_data s2 on s1.customer_car_code = s2.customer_car_code
and s1.sold_on < s2.sold_on
order by Avg_diff;
