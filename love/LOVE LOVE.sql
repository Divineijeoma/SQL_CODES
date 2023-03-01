create table "sales"(
"SALES_ID" numeric,	
"SALES_REP" text,	
"EMAILS" varchar,	
"BRANDS" text,	
"PLANT_COST" numeric,	
"UNIT_PRICE" numeric,	
"QUANTITY" numeric,	
"COST" numeric,	
"PROFIT" numeric,	
"COUNTRIES" text,	
"REGION" text, 	
"MONTHS" text,	
"YEARS" numeric
);
select *
from "sales"

--SECTION AQ1
select sum("PROFIT") as "total_profit"
from "sales";


--Q2
select "TERRITORY", sum("PROFIT") as "total_profit"
from 
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from sales) as "table_one"
group by "TERRITORY";


--Q3
select "COUNTRIES", sum("PROFIT") as "total_profit"
from "sales"
where "YEARS" = 2019
group by "COUNTRIES"
order by "total_profit" desc;


--Q4
select "YEARS", sum("PROFIT") as "total_profit"
from "sales"
group by "YEARS"
order by "total_profit" desc;


--Q5
select "MONTHS", "YEARS", sum("PROFIT") as "total_profit"
from "sales"
group by "MONTHS", "YEARS"
order by "total_profit"
limit 5;



--Q6
select ("PROFIT")
from "sales"
where "MONTHS" = 'December' and "YEARS" = 2018
order by "PROFIT";


--Q7
select "MONTHS", round((sum ("PROFIT")/sum("COST"))*100,3) as "profit_perc"
from "sales"
where "YEARS" = 2019
group by "MONTHS";


--Q8
select "BRANDS", sum("PROFIT") as "total_profit"
from "sales"
where "COUNTRIES" ='Senegal'
group by "BRANDS"
order by "total_profit" desc;


--SECTION BQ1
select "BRANDS", sum("QUANTITY") as "qty"
from
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from sales) as "table one"
where "YEARS" in (2019, 2018) and "TERRITORY" ='Francophone'
group by "BRANDS"
order by "qty" desc
limit 3;



--Q2
select "BRANDS", sum("QUANTITY") as "qty"
from "sales"
where "COUNTRIES" = 'Ghana'
group by "BRANDS"
order by "qty" desc
limit 2;

--Q3
select "BRANDS", sum ("QUANTITY") as "qty"
from "sales"
where "COUNTRIES" ='Nigeria' and "BRANDS" not like '%malt'
group by "BRANDS"
order by "qty" desc;

--Q4b formular 1
select "BRANDS", sum("QUANTITY") as "qty"
from
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone' 
else 'Francophone' end as "TERRITORY"
from "sales") as "table_1" 
where "BRANDS" like '%malt' and "TERRITORY" ='Anglophone' and "YEARS" in (2018, 2019)
group by "BRANDS"
order by "qty" desc;

--formular 2
select "BRANDS", sum("QUANTITY") as "qty"
from "sales"
where "BRANDS" like '%malt' and "COUNTRIES" in ('Nigeria', 'Ghana') and "YEARS" in (2018, 2019)
group by "BRANDS"
order by "qty" desc;

--Q5
select "BRANDS", sum("QUANTITY") as "qty"
from "sales"
where "COUNTRIES" = 'Nigeria' and "YEARS" = 2019
group by "BRANDS"
order by "qty" desc;

--Q6
select "BRANDS", sum("QUANTITY") as "qty"
from "sales"
where "REGION" = 'southsouth' and "COUNTRIES" = 'Nigeria'
group by "BRANDS"
order by "qty" desc;

--Q7
select sum("QUANTITY") as "qty"
from "sales"
where "COUNTRIES" = 'Nigeria' and "BRANDS" not like '%malt'

--Q8
select "REGION", sum("QUANTITY") as "qty"
from "sales"
where "BRANDS" = 'budweiser' and "COUNTRIES" ='Nigeria'
group by "REGION"
order by "qty" desc;

--Q9
select "REGION", sum("QUANTITY") as "qty"
from "sales" 
where "BRANDS" = 'budweiser' and "COUNTRIES" = 'Nigeria' and "YEARS"= 2019
group by "REGION"
order by "qty" desc;

--SECTION CQ1
select "COUNTRIES", sum("QUANTITY") as "qty"
from "sales"
where "BRANDS" not like '%malt'
group by "COUNTRIES"
order by "qty" desc;

--Q2
select "SALES_REP", sum("QUANTITY") as "qty"
from "sales"
where "BRANDS" = 'budweiser' and "COUNTRIES" = 'Senegal'
group by "SALES_REP"
order by "qty" desc;

--Q3
select "COUNTRIES", sum("PROFIT") as "total_profit"
from "sales"
where "MONTHS" in ('October', 'November', 'December') and "YEARS" = 2019
group by "COUNTRIES"
order by "total_profit" desc;

OR
select "COUNTRIES", sum("PROFIT") as "total_profit"
from
(select *,
case when "MONTHS" in ('October', 'November', 'December') then 'Q4'
else 'others' end as "QUARTERS"
from "sales") as "Table_z"
where "QUARTERS" = 'Q4' and "YEARS" =2019
group by "COUNTRIES"
order by "total_profit" desc;

select "TERRITORY", sum("QUANTITY") as "qty"
from
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from
((select *,
case when "MONTHS" in ('October', 'November', 'December') then 'Q4'
when "MONTHS" in ('January', 'February', 'March') then 'Q1'
when "MONTHS" in ('Aprail', 'May', 'June') then 'Q2'
else 'Q3' end as "QUARTERS" 
from "sales")) as "Table_z") as "t1"
where "QUARTERS" ='Q4'
group by "TERRITORY" 
order by "qty" desc;



































 
 
 
 
 
 
 
 






















