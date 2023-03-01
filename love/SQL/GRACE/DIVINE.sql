create table "buy_data"(
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
"YEARS" numeric);



select *
from buy_data


select "COUNTRIES", sum("PROFIT") as "total_profit"
from "buy_data"
where "YEARS" = 2019
group by "COUNTRIES"
order by "total_profit" desc


select ("SALES_REP"), sum("PROFIT") as "total profit"
from "buy_data"
where "BRANDS" = 'trophy'
group by "SALES_REP"



select distinct("SALES_REP")
from "buy_data"
limit 5




