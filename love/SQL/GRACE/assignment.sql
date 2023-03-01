create table "sales_data"(
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
from "sales_data"

--SECTION B QUESTION 2
select "BRANDS", sum("QUANTITY") as "qty"
from "sales_data"
where "COUNTRIES" ='Ghana'
group by "BRANDS"
order by "qty" desc
limit 2;
--QUESTION 4
select "BRANDS", "YEARS", sum("QUANTITY") as "qty"
from
select *,
case when "COUNTRIES" in ('Nigeria','Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from "sales_data" as "t1"
where "BRANDS" like '%malt' and "TERRITORY" ='Anglophone'
and "YEARS" in (2018, 2019)
group by "BRANDS", "YEARS"
order by "qty" desc;

--QUESTION 3
select "BRANDS", sum("QUANTITY") as "qty"
from "sales_data"
where "BRANDS" not like '%malt'
group by "BRANDS"
order by "qty" desc;

--QUESTION 5
select "BRANDS", sum("PROFIT") as "brands_profit"
from sales_data
where "COUNTRIES" ='Nigeria'
group by "BRANDS"
order by "brands_profit";

--QUESTION 6
select "BRANDS", sum("QUANTITY") as "qty"
from sales_data
where "COUNTRIES" ='Nigeria'
group by "BRANDS"
order by "qty";

--QUESTION 7
select "BRANDS", sum("PROFIT") as "brands_profit"
from sales_data
where "COUNTRIES" = 'Nigeria'
group by "BRANDS"
order by "brands_profit";

--QUESTION 8
select "BRANDS", sum("PROFIT") as "brands_profit"
from sales_data
where "COUNTRIES" ='Nigeria'
group by "BRANDS"
order by "brands_profit";

--QUESTION 9
select "BRANDS", sum("PROFIT") as "brands_profit"
from sales_data
where "COUNTRIES" ='Nigeria' and "YEARS" =2019
group by "BRANDS"
order by "brands_profit";

--SECTION C QUESTION 1
select "COUNTRIES", sum("PROFIT")
from sales_data
group by "COUNTRIES";


--QUESTION 2
select "SALES_REP", sum("QUANTITY") as "qty"
from sales_data
where "COUNTRIES" ='Senegal' and "BRANDS" ='budweiser'
group by "SALES_REP"
order by "qty";

--QUESTION 3
select "COUNTRIES", sum("PROFIT") as "profit"
from
(select *,
case when "MONTHS" in ('January', 'February', 'March') then 'q1'
when "MONTHS" in ('Aprail', 'May', 'June') then 'q2'
when "MONTHS" in ('July', 'August', 'September') then 'q3'
else 'q4' end as "QUARTERS"
from "sales_data") as "t1"
where "QUARTERS" = 'q4'
group by "COUNTRIES"
order by "profit" desc;

select "TERRITORY", sum("QUANTITY") as "qty_sales"
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from
(
(select *,
case when "MONTHS" in ('January', 'February', 'March') then 'q1'
when "MONTHS" in ('Aprail', 'May', 'June') then 'q2'
when "MONTHS" in ('July', 'August', 'September') then 'q3'
else 'q4' end as "QUARTERS"
from "sales_data")) as "t1") as "t2"
where "QUARTERS" ='q4'
group by "TERRITORY"
order by "qty_sales" desc;