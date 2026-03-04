# EV-vs-Petrol-Vehicle-Market-Analysis-2010-2025
The analysis is performed using Excel, SQL, and Power BI to explore trends in EV adoption, compare EV and petrol vehicle sales, and identify key factors influencing EV market growth.

## Objectives of the project
1) Analyzing EV vs petrol vehicle sales trends across countries and years.

2) Examining how fuel prices, electricity costs, and government subsidies affect EV adoption.

3) Studying the role of charging infrastructure in EV market growth.

4) Identifying countries and segments where EVs are becoming dominant.

5) Building interactive dashboards in Power BI for visual insights.

## Dataset Description

The dataset includes 1200 rows and 22 columns representing EV and traditional vehicle sales across countries and years.

## Database Setup
Step 1: Create Database
CREATE DATABASE electric_vehicles;

Step 2: Select Database
USE electric_vehicles;

Step 3: Import Dataset
The dataset was imported using MySQL Workbench Table Data Import Wizard, which automatically created the table and loaded the CSV data.

## Dataset Source & Exploration
The dataset for this project was downloaded from Kaggle in CSV format and contains country-level EV and petrol vehicle sales data from 2010–2025. The file was imported into MySQL Workbench using the Table Data Import Wizard, which automatically created the table and assigned column data types. Some column names were later shortened to make them more SQL-friendly for querying.

After importing the dataset into MySQL, initial data exploration was performed to understand the structure and contents of the data. Basic SQL queries were used to preview the dataset, check the number of records, identifying column names, and examine the range of years available. This helped ensure that the dataset was correctly imported and provided a better understanding of the variables before performing further analysis.

## SQL Analysis Queries

### Query 1- Total Number of Records

SELECT COUNT(*) AS total_records
FROM ev_vs_petrol;

Analysis- This query counts the total number of records in the dataset, confirming that the data was imported correctly. The result showed that the table contains 1,200 rows.

### Query 2- Verify column names

SHOW columns FROM ev_vs_petrol;

Analysis- This query shows the table structure, helping verify column names and data types before running further analysis or writing additional SQL queries.

### Query 3- Fixing Incorrect Column Name

ALTER TABLE ev_vs_petrol
RENAME column ï»¿Country to Country;

Analysis- After running the last query it was detected that during data import, the column Country appeared as "ï»¿Country" due to a UTF-8 encoding issue in the CSV file. So, the column was renamed to "Country" to ensure a clean and consistent column name.

### Query 4- Distinct Countries in Dataset

SELECT COUNT(DISTINCT country)
FROM ev_vs_petrol;

Analysis- This query counts the distinct countries in the dataset, providing an overview of its geographical coverage. The derived output revealed that their are total 25 countries in the given data.

### Query 5- Time Period Covered

SELECT MIN(year) AS start_date, MAX(year) AS end_date
FROM ev_vs_petrol;

Analysis- Identifies the earliest and latest years in the dataset, showing its overall time span. The MIN(year) is labeled as start_year and MAX(year) as end_year for better readability, revealing that the data ranges from 2010 to 2025.

### Query 6- Sample Data Preview

SELECT * FROM
ev_vs_petrol 
LIMIT 10;

Analysis- The query displayed the first 10 rows of the dataset, which helps review the table structure, understand the available variables, and verify that the data has been imported correctly before performing further analysis.

### Query 7- Total EV Sales by Year

SELECT year,
SUM(ev_sales)
FROM ev_vs_petrol
GROUP BY year
ORDER BY year;

Analysis- This query calculates the total EV sales for each year to examine adoption trends over time. The results show a steady and significant increase in EV sales from 20,139 units in 2010 to 19,673,169 units in 2025, with 2025 recording the highest sales, indicating rapid global growth in EV adoption.

### Query 8- Total Petrol and Diesel Sales

SELECT 
SUM(petrol_car_sales), SUM(diesel_car_sales)
FROM ev_vs_petrol;

Analysis- The query helped us identify the total sales of traditional vehicles in the dataset, with 927,967,539 petrol car sales and 169,124,260 diesel car sales, enabling a comparison with EV sales.

### Query 9- Top 10 Countries by EV Sales

SELECT country,
SUM(ev_sales) AS total_ev_sales
FROM ev_vs_petrol
GROUP BY country
ORDER BY total_ev_sales DESC
LIMIT 10;

Analysis- The query identified the top 10 countries with the highest EV sales, indicating the markets leading EV adoption. The results show that China dominates the EV market with 46,544,667 sales, far ahead of other countries.

### Query 10- Charging Infrastructure by Country

SELECT country,
MAX(charging_stations) AS total_charging_stations
FROM ev_vs_petrol
GROUP BY country
ORDER BY total_charging_stations DESC;

Analysis- The query helped identify countries with the highest charging infrastructure, showing that China leads with 4,338,106 charging stations. A well-developed charging network plays a critical role in EV adoption, making electric vehicles more convenient and accessible for consumers.

### Query 11- EV Growth Rate by Year

SELECT year,
ROUND(AVG(ev_growth_rate_yoy),2) AS avg_ev_growth_yoy
FROM ev_vs_petrol
GROUP BY year
ORDER BY year;

Analysis- The query calculates the year-over-year growth of EV sales, helping identify periods of rapid market expansion. The results show that the highest growth occurred in 2011 at 151.31%, indicating a major early surge in EV adoption as the market began expanding globally.

### Relational Analysis Using SQL Joins
Since the original dataset exists as a single table, additional tables were created by logically separating the data into smaller tables. This allows the use of SQL joins to demonstrate relational database analysis and to examine relationships between vehicle sales, country information, and charging infrastructure.

### Country Information Table
CREATE TABLE country_info AS
SELECT DISTINCT
country,
region,
gdp_per_capita,
urban_population_percent
FROM ev_vs_petrol;

### Vehicle Sales Table
CREATE TABLE vehicle_sales AS
SELECT
country,
year,
ev_sales,
petrol_car_sales,
diesel_car_sales,
total_vehicle_sales,
ev_market_share
FROM ev_vs_petrol;

### Charging Infrastructure Table
CREATE TABLE infrastructure AS
SELECT
country,
year,
charging_stations,
fast_chargers_share,
avg_ev_range_km
FROM ev_vs_petrol;


