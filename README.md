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

### Derived Metrics

EV Share %
EV Share % = EV Sales / (EV Sales + ICE Sales)
→ Measures EV adoption rate

Cost Metrics
→ Cost per km and total ownership cost for EV vs Petrol

CO₂ Reduction
→ Difference between petrol and EV emissions

Break-even Years
→ Time required for EV to become cost-effective

### Global EV Trend Analysis

## Objective
Analyze the growth of Electric Vehicle (EV) adoption globally over the period 2010–2025, with the aim of identifying long-term trends, growth patterns, and key inflection points in the market.

## Analysis

Aggregated year-wise EV sales to observe overall growth in adoption

Evaluated year-over-year changes to understand how rapidly the market is expanding

Analyzed EV share (%) over time to measure the proportion of EVs relative to total vehicle sales

Identified trend patterns (linear vs exponential growth) to understand the nature of market expansion

Compared early-stage adoption (2010–2015) with later stages (post-2020) to highlight acceleration in growth

## Key Insight

EV adoption remains relatively low and gradual in the early years (2010–2015)

A noticeable increase in growth rate begins around 2016–2018

Post-2020, EV adoption experiences exponential growth, indicating rapid market expansion

This surge suggests the combined impact of government policies, technological advancements, and increased consumer awareness

### Country-wise Analysis

## Objective
Compare EV adoption across different countries to identify market leaders, emerging regions, and variations in adoption patterns. This analysis helps understand how geographical, economic, and policy factors influence EV growth.

## Analysis
Performed country-level aggregation of EV sales to compare overall adoption volume

Evaluated market share of EVs within each country to understand penetration levels

Compared high-volume vs high-penetration markets to distinguish between scale and adoption intensity

Analyzed growth trends across countries to identify consistent performers and rapidly growing markets

Assessed regional differences to highlight how adoption varies across developed and developing economies

## Key Insights
Norway leads in EV adoption in terms of market penetration, indicating strong policy support and consumer acceptance

China dominates in total EV sales volume, driven by its large market size and manufacturing capabilities

United States shows steady and consistent growth, reflecting gradual but stable adoption

Significant variation exists across countries, suggesting that government incentives, infrastructure availability, and economic factors play a crucial role in EV adoption

### Cost Analysis (EV vs Petrol)

## Objective
Evaluate the financial viability of Electric Vehicles (EVs) compared to petrol vehicles by analyzing both short-term and long-term cost factors. The goal is to determine whether EVs provide economic benefits over time despite higher initial investment.

## Analysis

Compared cost per kilometer between EV and petrol vehicles to understand day-to-day running expenses

Evaluated total cost of ownership (TCO), including purchase cost, fuel/electricity cost, and operational expenses

Analyzed the difference between upfront cost and long-term savings to understand cost recovery potential

Assessed how cost efficiency varies across different countries based on fuel prices and economic conditions

Identified the role of recurring savings (fuel vs electricity) in reducing overall ownership cost

## Key Insights

EVs have a lower running cost per kilometer, making them more economical for daily usage

Despite higher initial purchase cost, EVs become more cost-efficient in the long term due to lower fuel and maintenance expenses

The cost advantage increases over time, especially with higher vehicle usage

However, the high upfront cost remains a major barrier to adoption, particularly in price-sensitive markets

Long-term savings make EVs a financially viable option, especially in regions with high fuel prices

### Environmental Impact Analysis

## Objective
Assess the environmental sustainability benefits of Electric Vehicle (EV) adoption by comparing emissions with petrol vehicles. The aim is to understand how EVs contribute to reducing carbon footprint and supporting cleaner transportation.

## Analysis

Compared CO₂ emissions generated by petrol vehicles vs EVs to evaluate environmental impact

Estimated CO₂ reduction achieved through EV adoption by calculating the difference in emissions

Analyzed how emission savings vary across countries and years based on adoption levels

Evaluated the relationship between increasing EV adoption and overall emission reduction trends

Considered the broader impact of EV growth on sustainable and eco-friendly mobility


## Key Insights

EVs contribute to a significant reduction in carbon emissions compared to petrol vehicles

Higher EV adoption directly leads to greater CO₂ reduction over time

The environmental impact varies across regions, depending on factors such as energy sources and adoption rates

Countries with higher EV penetration demonstrate stronger sustainability outcomes

EV adoption plays a crucial role in supporting long-term environmental and climate goals


### Segment Analysis

## Objective
Understand how EV adoption varies across different vehicle segments to identify which segments drive early adoption and how the transition spreads across the market over time.

## Analysis

Performed segment-wise comparison of EV adoption across categories such as Passenger, Commercial, and Premium vehicles

Evaluated EV share within each segment to understand penetration levels

Analyzed adoption patterns across segments over time to identify early adopters and late movers

Compared growth trends between high-end and mass-market segments

Assessed how consumer behavior and pricing sensitivity influence adoption in each segment

## Key Insight

The Premium segment shows early adoption of EVs, driven by higher purchasing power and quicker acceptance of new technology

The Passenger (mass-market) segment experiences adoption at a later stage as EVs become more affordable and accessible

The Commercial segment adoption depends on cost efficiency and operational benefits, showing gradual growth

EV adoption typically follows a pattern where it starts in high-end segments and gradually expands to the mass market

Segment-wise differences highlight the impact of pricing, usage patterns, and consumer preferences on EV adoption


### Infrastructure Analysis

## Objective
Evaluate the readiness and availability of charging infrastructure to support the growing adoption of Electric Vehicles (EVs). This analysis aims to understand whether infrastructure development is keeping pace with EV growth and how it influences adoption.

## Analysis

Analyzed the growth in number of charging stations over time to track infrastructure expansion

Calculated chargers per 1000 EVs to measure infrastructure adequacy relative to EV adoption

Compared infrastructure availability across countries and regions to identify gaps and leading markets

Examined the relationship between charging infrastructure and EV adoption rates

Identified trends indicating whether infrastructure growth is proactive or reactive to EV demand

## Key Insight

Availability of charging infrastructure is a critical factor influencing EV adoption

Regions with better infrastructure show higher EV penetration and faster growth

In the early stages, limited charging availability acts as a barrier (range anxiety)

Over time, infrastructure expansion helps accelerate EV adoption

The balance between EV growth and infrastructure development is essential for sustainable market expansion

## Break-even Analysis

## Objective
Determine the cost recovery period for Electric Vehicles (EVs) by identifying how long it takes for the initial higher investment in EVs to be offset by savings from lower running and maintenance costs. This helps evaluate the practical financial feasibility of EV adoption.

## Analysis
Calculated break-even years based on the difference between upfront cost and annual savings from fuel and maintenance

Categorized break-even periods into ranges (e.g., <5 years, 6–10 years, >10 years) to simplify comparison

Compared break-even timelines across countries and regions to identify variation in cost recovery

Analyzed the impact of fuel prices, electricity costs, and usage patterns on payback period

Assessed how external factors such as government incentives and subsidies influence break-even duration

## Key Insight
The break-even period varies significantly across countries, depending on economic and policy conditions

Regions with higher fuel costs and strong subsidies tend to have a shorter payback period

In some markets, EVs achieve cost recovery in less than 5 years, making them highly attractive

In contrast, regions with lower fuel prices or limited incentives show longer break-even periods

The break-even timeline is a critical decision-making factor influencing EV adoption at the consumer level

