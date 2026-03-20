# EV-vs-Petrol-Vehicle-Market-Analysis(2010-2025)
The analysis is performed using Excel, SQL, and Power BI to explore trends in EV adoption, compare EV and petrol vehicle sales, and identify key factors influencing EV market growth.

## Objectives of the project
1) Analyzing EV vs petrol vehicle sales trends across countries and years.

2) Examining how fuel prices, electricity costs, and government subsidies affect EV adoption.

3) Studying the role of charging infrastructure in EV market growth.

4) Identifying countries and segments where EVs are becoming dominant.

5) Building interactive dashboards in Power BI for visual insights.

## Dataset Description

The dataset includes 1200 rows and 22 columns representing EV and traditional vehicle sales across countries and years.

### Key Columns

1) Country- The column represents the country where the vehicle sales were recorded, allowing analysis of EV adoption patterns across different national markets.
   
2) Region- The column represents region to which a country belongs (e.g., Europe, Asia, North America), allowing comparison of EV adoption trends across regions.

3) Year- The column represents the year in which vehicle sales and related metrics were recorded, enabling analysis of electric vehicle market trends over time from 2010 to 2025.
   
4) ev_sales- The total number of electric vehicles sold in a specific country and year. This column is a key metric for measuring EV market growth.
   
5) ev_market_share- The percentage of EV sales relative to total vehicle sales in a given country and year, indicating the level of EV adoption.
   
6) charging_stations- The number of EV charging stations available in a country during a given year. Charging infrastructure is a major factor that positively influences the adoption of electric vehicles.
   
7) gdp_per_capita- The column represents average economic output per person in a country. It provides insight into the economic conditions that may affect EV adoption and purchasing power.

8) ev_subsidy_usd- The amount of government financial incentive provided for purchasing electric vehicles, measured in US dollars. This variable helps analyze how policy support and subsidies influence EV adoption across different nations.

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

### Query 12- Country Information Table
CREATE TABLE country_info AS
SELECT DISTINCT
country,
region,
FROM ev_vs_petrol;

###   Query 13- Vehicle Sales Table
CREATE TABLE vehicle_sales AS
SELECT
country,
year,
ev_sales,
petrol_car_sales,
diesel_car_sales,
total_vehicle_sales,
FROM ev_vs_petrol;

### Query 14- LEFT JOIN Analysis – Regional EV Sales Performance

SELECT 
c.country,
c.region,
v.year,
v.ev_sales,
v.total_vehicle_sales,
ROUND((v.ev_sales / v.total_vehicle_sales) * 100, 2) AS ev_sales_percentage
FROM country_info c
LEFT JOIN vehicle_sales v
ON c.country = v.country
ORDER BY ev_sales_percentage desc;

Analysis- This analysis links country-level information with yearly vehicle sales data to examine EV adoption across regions. The calculated column ev_sales_percentage represents the share of electric vehicles in total vehicle sales for each country. Results are ordered by this percentage to highlight markets with stronger EV adoption, where Norway consistently ranks among the top countries, indicating its leading role in the transition toward electric mobility.

### Query 15- SELF JOIN Analysis – Comparing EV Sales Between Countries in the Same Year

SELECT 
a.year,
a.country AS country_1,
b.country AS country_2,
a.ev_sales AS country_1_ev_sales,
b.ev_sales AS country_2_ev_sales,
(a.ev_sales - b.ev_sales) AS sales_difference
FROM ev_vs_petrol a
JOIN ev_vs_petrol b
ON a.year = b.year
AND a.country < b.country
ORDER BY a.year, sales_difference DESC;

Analysis- This analysis applies a self join on the ev_vs_petrol table to compare EV sales between countries in the same year. Since each row contains data for only one country-year combination, joining the table with itself enables direct comparison of EV sales across countries for that year. The calculated sales difference highlights variations in EV adoption and helps identify markets with stronger EV sales performance.

### Query 16- Impact of Subsidies on EV Sales

SELECT 
country,
AVG(ev_subsidy_usd) AS avg_subsidy,
SUM(ev_sales) AS total_ev_sales
FROM ev_vs_petrol
GROUP BY country
ORDER BY avg_subsidy DESC;

Analysis- This query evaluates government incentives for EV adoption by calculating the average subsidy offered by each country along with their total EV sales. The results show that the United States, China, and France offer the highest EV subsidies, and these countries also record the highest EV sales, indicating a possible correlation between government incentives and increased EV adoption.

### Query 17- EV Sales Ranking Within Each Region

SELECT 
region,
country,
SUM(ev_sales) AS total_ev_sales,
DENSE_RANK() OVER(PARTITION BY region ORDER BY SUM(ev_sales) DESC) AS regional_rank
FROM ev_vs_petrol
GROUP BY region, country
ORDER BY region, regional_rank;

Analysis- This query ranks countries by total EV sales within each region using the `DENSE_RANK()` window function. By partitioning the data by region, the ranking resets for each region, allowing comparison of EV sales performance among countries within the same geographic area. The results show that China ranks first in the APAC region and also leads overall EV sales, highlighting its dominant position in the global electric vehicle market.

## Conclusion

The SQL analysis involved importing, cleaning, and exploring the ev_vs_petrol vehicle dataset to examine sales trends, compare country performance, and identify patterns in EV adoption. The results show a strong rise in global EV sales, increasing from 20,139 units in 2010 to 19,673,169 units in 2025, with 2025 recording the highest sales. The largest year-over-year growth occurred in 2011 at 151.31%, marking an early surge in EV adoption.

Country-level analysis shows that China dominates the EV market with 46,544,667 total sales, ranking first in the APAC region and globally. China also leads in charging infrastructure with 4,338,106 charging stations, indicating strong support for EV adoption. Additionally, the United States, China, and France offer the highest EV subsidies and also record some of the highest EV sales, suggesting a link between government incentives and EV adoption.

Overall, the findings highlight the important role of government policies, charging infrastructure, and market expansion in accelerating EV adoption, with China emerging as the global leader. Further analysis and visualization will be conducted using Excel and Power BI to gain deeper insights into EV market trends.

## Excel Analysis and Visualization

After completing data cleaning and initial analysis in SQL, the project now moves to Excel for deeper analysis. Initial insights were derived in SQL using aggregation and filtering queries to understand basic trends and distributions. In the next stage, Excel is used to perform detailed analytical operations such as time-series analysis, country-wise comparisons, cost evaluation, and environmental impact assessment using formulas and structured data exploration. This step focuses on generating meaningful insights from the dataset, which are further extended into Power BI for building interactive dashboards and visualizing the results effectively.

### Data Preparation
The following data preparation steps are performed in Excel to ensure data quality and consistency:

1) Converted raw data into a structured table for efficient data handling, filtering, and structured references.

2) Checked for missing values to maintain completeness and avoid analytical errors.

3) Removed duplicate records to ensure data accuracy and integrity.

4) Applied freeze panes to improve navigation and maintain header visibility.

5) Validated data formats (dates, numbers, text, currency) to ensure consistency and reliable analysis.

## Global EV Trend Analysis

### Objective
This dataset analyzes the growth of electric vehicles (EVs) compared to traditional petrol and diesel vehicles from 2010 to 2025. It highlights trends in sales, market share, infrastructure, and technology.

### Key Columns

1) Year – Time period of analysis
2) EV_Sales – Total EVs sold
3) Petrol_Car_Sales & Diesel_Car_Sales – Traditional vehicle sales
4) All_Vehicle_Sales – Total vehicle market size
5) EV_Market_Share_% – EV share in total sales
6) Charging_Stations – EV infrastructure growth
7) Avg_EV_Range_KM – Improvement in EV technology
8) EV_Growth_YoY_% – Annual growth rate of EV sales
9) ICE_Sales – (Calculated) Petrol + Diesel sales

### Key Insights

1) EV sales grew from ~20K (2010) to ~19M (2025) → massive adoption surge.
2) EV market share increased from ~3% to ~20% → steady market penetration.
3) Charging stations expanded from 148 to 236,994 → strong infrastructure support.
4) Avg EV range improved from ~120 km to ~470 km → major tech advancement.
5) EV YoY growth was 150%+ in early years, now stabilizing at ~20–50% → market maturing.
6) ICE vehicles still dominate but show slower growth vs EVs → declining dominance.
7) Overall trend indicates a shift toward mainstream EV adoption and sustainable mobility.

## Environmental Impact Analysis

### Objective
To analyze the relationship between EV adoption, emission regulations, and transport-related CO₂ emissions across countries over time.

### Key Columns

1) Country, Region, Year – Geographic and time-based analysis
2) CO2_Transport_MT – Total transport emissions (in million tonnes)
3) Emission_Regulation_Score – Strength of environmental policies
4) EV_Market_Share_Pct – EV penetration in total vehicle sales
5) EV_Sales – Total EV adoption volume

### Key Insights

1) EV adoption has increased significantly across all countries, especially after 2020
2) Countries with strong emission regulations tend to have higher EV market share (e.g., Norway, Netherlands)
3) High EV adoption correlates with declining transport emissions in developed countries
4) Emerging economies show rising emissions despite EV growth due to lower adoption levels
5) China leads in EV scale, helping stabilize emissions despite large transport demand
6) The US shows slower emission reduction, indicating EV growth alone is not sufficient without stronger policies

## Segment Analysis

### Objective
To analyze EV adoption across different market segments (Commercial, Mass Market, Premium) and understand how sales, growth, technology, and infrastructure vary across segments over time.

### Key Columns

1) Vehicle_Segment – Type of EV market (Commercial, Mass, Premium)
2) Year – Time period of analysis
3) EV_Sales – EV sales per segment
4) ICE_Sales – Traditional vehicle sales for comparison
5) Total_Sales – Overall vehicle sales
6) EV_Market_Share_% – EV penetration within each segment
7) Avg_EV_Range_KM – Technology improvement across segments
8) EV_Growth_YoY_% – Segment-wise growth trends
9) Avg_Charging_Stations – Represents the average availability of charging infrastructure, indicating overall infrastructure growth supporting EV adoption.
Calculation- SUM(Charging_Stations) / Vehicle Segment
11) Share_of_Segment_% – Shows the contribution of each vehicle segment to total EV sales.
Calculation= Segment EV Sales / Total EV Sales * 100
    
### Key Insight

1) Mass Market EV sales grew from 11,849 (2010) to 11,688,453 (2025) → highest contributor to total EV adoption (23.71% share)
   
2) Premium segment has the highest EV penetration, rising from 0.05% (2010) to 34.26% (2025) → fastest adoption rate
   
3) Commercial segment shows slowest EV adoption, with share increasing only from 0.01% to 8.33% (2010–2025)
   
4) EV sales surged significantly post-2020:
   Mass Market: 1.77M → 11.68M (2020–2025)
   Premium: 1.06M → 6.96M
   Commercial: 154K → 1.01M

5) YoY growth peaked around 2021 (~110%) across segments and declined to ~21–22% by 2025 → indicates market maturity
    
6) Charging stations expanded from 148 (2010) to 236,994 (2025) → strong infrastructure support for EV growth
    
7) Average EV range improved from 120 km to 471 km → ~4x increase in battery efficiency
    
8) ICE vehicles still lead in volume but gap is narrowing:
   Mass Market (2025): 37.6M ICE vs 11.68M EV
   Premium (2025): 13.36M ICE vs 6.96M EV

9) Clear adoption pattern:
    Premium → fastest adoption (34.26%)
   Mass Market → largest volume (11.68M sales)
   Commercial → slowest transition (8.33%)

## Infrastructure Analysis

### Objective
To analyze the growth of EV charging infrastructure across countries and understand its relationship with EV adoption, technology (range), and economic factors. This analysis aims to understand whether infrastructure development is keeping pace with EV growth and how it influences adoption.

### Key Columns

1) Country, Region, Year – Geographic and time-based analysis
2) Charging_Stations – Total EV charging infrastructure
3) Fast_Charger_Share_Pct – Share of fast chargers
4) EV_Sales – EV adoption level
5) Chargers_per_1000_EVs – Measures charging infrastructure adequacy by showing chargers available per 1000 EVs.
   Calulation= Charging_Stations / EV_Sales * 1000
   
6) Avg_EV_Range_KM – Technological improvement
7) Urban_Population_Pct & GDP_per_Capita – Demand and economic indicators

### Key Insights

1) Charging infrastructure grew massively across countries
   Example: China (530 → 4.33M), US (500 → 131K), Australia (0 → 13K) (2010–2025)
   
2) Fast charger share increased significantly
   Example: China (9.9% → 49.3%), Australia (0% → 31.2%), UK (3% → 34.5%)
   
3) Strong link between EV sales and infrastructure
   China EV sales: 1.8K → 12.9M, chargers: 530 → 4.33M
   US EV sales: 12.9K → 2.06M, chargers: 500 → 131K
   
4) Chargers per 1000 EVs decline over time
   Example: Australia 477 → 87, Austria 1536 → 429

5) EV growth is faster than infrastructure expansion

6) EV range improved consistently across all countries
   From ~120 km to ~480–500 km (global trend)

7) Developed countries lead in infrastructure
   Norway, Netherlands, Switzerland show high charger density (1000+ per 1000 EVs in early years)

8) Emerging economies show rapid growth but lower base
   India: 0 → 34K chargers, EV sales: 136 → 181K
   Brazil: 0 → 16.5K chargers, EV sales: 30 → 103K

## EV Sales & Infrastructure Summary (Pivot Analysis)
The last sheet presents a summarized view of EV sales, charging infrastructure, and EV subsidies across regions using an Excel Pivot Table. The data is aggregated at the regional level to provide a clear comparison of EV adoption and supporting infrastructure.

### Analysis Approach
1) Created a Pivot Table using the raw dataset
2) Grouped data by Region
3) Calculated the following fields-
   Total EV Sales
   Total Charging Stations
   Total EV Subsidy (USD)
4) Added a Year slicer to filter data dynamically

### Why Pivot Table Was Used
1) To quickly aggregate large datasets into meaningful summaries
2) To enable easy comparison across regions
3) To perform quick validation of trends before building the Power BI dashboard
4) To keep analysis simple and structured without heavy visualization

### Key Insights
1) APAC leads in EV adoption, with ~49.7M EV sales, driven mainly by China
2) Europe shows strong infrastructure support, with ~1.31M charging stations
3) North America has high EV adoption but relatively lower infrastructure density
4) Oceania and South America are still emerging markets with lower EV adoption and infrastructure
5) EV subsidies are highest in APAC and Europe, indicating strong government support


