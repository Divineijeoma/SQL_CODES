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

-- section A question one 
select sum("PROFIT") as "Anglo_Franco"
from 
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from "sales_data") as "table_one";
--question 2
select "TERRITORY", sum("PROFIT") as "profit_sum"
from 
(select *,
case when "COUNTRIES" in ('Nigeria', 'Ghana') then 'Anglophone'
else 'Francophone' end as "TERRITORY"
from "sales_data") as "table_one"
group by "TERRITORY"
order by "profit_sum" desc;

--question 3
select "COUNTRIES", sum("PROFIT") as "country_profit"
from "sales_data"
where "YEARS" in (2019)
group by "COUNTRIES"
order by "country_profit" desc;

--question 4
select "YEARS", sum("PROFIT") as "year_profit"
from "sales_data"
group by "YEARS"
order by "year_profit" desc;

--question 5
select "MONTHS", "YEARS", sum("PROFIT") as "profit_sum"
from "sales_data"
group by "MONTHS", "YEARS"
order by "profit_sum" asc

--question 6
select min("PROFIT")
from "sales_data"
where "MONTHS" = 'December' and "YEARS" = 2018;

--question 7
select "MONTHS", round((sum("PROFIT")/sum("COST"))*100, 3) as "percentage_profit"
from "sales_data"
where "YEARS" in (2019)
group by "MONTHS"
order by "percentage_profit" desc;

--question 8
select "BRANDS", sum ("PROFIT") as "brand_profit"
from "sales_data"
where "COUNTRIES" = 'Senegal'
group by "BRANDS";

--section B question 4
select "BRANDS", sum("QUANTITY") as "qty"
from "sales_data"
where "BRANDS" not like '%malt'
group by "BRANDS"
order by "qty" desc;

