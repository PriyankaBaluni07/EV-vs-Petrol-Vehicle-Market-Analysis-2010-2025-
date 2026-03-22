create database if not exists electric_vehicles;
use electric_vehicles;

-- Data Exploration- Count the no. of rows
-- Understanding the dataset size helps confirm the data import was successful.
Select count(*) from ev_vs_petrol;

-- Verify column names
-- Inspect the table structure to verify column names before performing further queries.
show columns from ev_vs_petrol;

-- Renaming column to "country"
-- Changing column name for better readability and consistency.
alter table ev_vs_petrol
rename column ï»¿Country to country;

-- Number of Countries in Dataset
-- Counting distinct countries helps understand the geographical coverage of the dataset.
select count(distinct country)
from ev_vs_petrol;

--  Year Range of Dataset
-- Checking the minimum and maximum year identifies the time span of the dataset.
select min(year) as start_date, max(year) as end_date
from ev_vs_petrol;

-- Preview Dataset
-- Viewing sample rows helps understand the structure and available variables.
select * from
ev_vs_petrol 
limit 10;

-- Total EV Sales by Year
-- Calculates the total EV sales for each year, revealing how EV adoption has changed over time.
select year, sum(ev_sales)
from ev_vs_petrol
group by year
order by year;

-- Total Petrol and Diesel Sales
-- Calculates the total sales of petrol and diesel cars to understand the overall scale of traditional vehicle sales.
select sum(petrol_car_sales), sum(diesel_car_sales)
from ev_vs_petrol;

-- Top 10 Countries by EV Sales
-- Identifies the countries with the highest EV sales, highlighting which markets are leading in EV adoption.
select country, sum(ev_sales) as total_ev_sales
from ev_vs_petrol
group by country
order by total_ev_sales desc
limit 10;

-- Charging Infrastructure by Country
-- The query identifies countries with the highest charging infrastructure, highlighting regions where charging availability supports and encourages EV adoption.
select country, max(charging_stations) as total_charging_stations
from ev_vs_petrol
group by country
order by total_charging_stations desc;

-- EV Growth Rate by Year
-- Calculates the average year-over-year EV growth, helping identify periods when the EV market experienced rapid expansion.
select year, round(avg(ev_growth_rate_yoy),2) as avg_growth_yoy
from ev_vs_petrol
group by year
order by year;

-- Relational Analysis Using SQL Joins
-- Since the original dataset was a single table, additional tables were created to enable SQL joins and analyze relationships between vehicle sales, country data, and charging infrastructure.
create table country_info as
select distinct country, region
from ev_vs_petrol;

create table vehicle_sales as
select country, year, ev_sales, petrol_car_sales, diesel_car_sales, total_vehicle_sales
from ev_vs_petrol;

-- LEFT JOIN Analysis – Regional EV Sales Performance
-- The query uses LEFT JOIN to combine the country_info table with the vehicle_sales table using the country column as the joining key.
select c.country, c.region, v.year, v.ev_sales, v.total_vehicle_sales,
round((v.ev_sales/v.total_vehicle_sales)*100,2) as ev_sales_percentage
from country_info c
left join vehicle_sales v
on c.country=v.country
order by ev_sales_percentage desc;

-- SELF JOIN Analysis – Comparing EV Sales Between Countries in the Same Year
-- This analysis compares EV sales between countries within the same year. Since each row represents one country per year, the table is self-joined to evaluate sales of different countries for the same year.

select a.year, a.country as country_1, b.country as country_2,
a.ev_sales as country_1_ev_sales, b.ev_sales as country_2_ev_sales, (a.ev_sales-b.ev_sales) as sales_difference
from ev_vs_petrol a
join ev_vs_petrol b
on a.year=b.year and a.country<b.country
order by a.year, sales_difference desc;

-- Impact of Subsidies on EV Sales
-- Examining the impact of government subsidies on EV adoption, as countries offering higher subsidies are likely to experience faster growth in electric vehicle sales.
select country, avg(ev_subsidy_usd) as avg_subsidy, 
sum(ev_sales) as total_ev_sales
from ev_vs_petrol
group by country
order by avg_subsidy desc;

-- EV Sales Ranking Within Each Region
-- Ranks countries within each region by EV sales to highlight regional leaders and compare market performance.
select region, country, sum(ev_sales) as total_ev_sales,
dense_rank() over(partition by region order by sum(ev_sales) desc) as regional_rank
from ev_vs_petrol
group by region, country
order by region, regional_rank;

