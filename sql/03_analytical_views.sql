-- =============================================
-- File: 03_analytical_views.sql
-- Purpose: Create business-ready views for Excel/Tableau Dashboarding
-- Description: These views pre-aggregate data to improve dashboard performance and ensure consistent metric calculations across tools
-- =============================================


USE nyc_airbnb
GO

-- 1. BOROUGH PERFORMANCE
-- Business Question: Where is the most supply? Which borough is the most expensive?

CREATE OR ALTER VIEW vw_borough_stats AS
SELECT neighbourhood_group,
	   COUNT(*) AS TotalSupply, 
	   AVG(price) AS AveragePrice, 
	   MIN(price) AS MinimumPrice, 
	   MAX(price) AS MaxPrice, 
	   AVG(CAST(availability_365 AS int))  AS AverageAvailability
FROM airbnb_cleaned
GROUP BY neighbourhood_group
GO

-- 2. ROOM TYPE PERFORMANCE
-- Business Question: What is the price premium for an 'Entire home' vs. 'Private room'?

CREATE OR ALTER VIEW vw_room_type_stats AS
SELECT room_type, COUNT(*) AS TotalSupply, AVG(price) AS AveragePrice,AVG(CAST(availability_365 AS INT)) AS AverageAvailability
FROM airbnb_cleaned
GROUP BY room_type
GO

-- 3. PRICE VS. AVAILABILITY CORRELATION
-- Business Question: Do expensive listings sit empty (high availability) or sell out?

CREATE OR ALTER VIEW vw_price_availability AS
SELECT price_category, availability_category, AVG(price) AS AveragePrice, COUNT(*) AS TotalSupply
FROM airbnb_cleaned
GROUP BY price_category, availability_category
GO

-- 4. HOST BEHAVIOR ANALYSIS
-- Business Question: Do professional hosts (multi-listing) charge higher prices than individuals?

CREATE OR ALTER VIEW vw_host_stats AS
SELECT host_type, AVG(price) AS AveragePrice, MIN(price) AS MinimumPrice, MAX(price) AS MaximumPrice, AVG(CAST(availability_365 AS INT)) AS AverageAvailability, COUNT(*) AS TotalSupply
FROM airbnb_cleaned
GROUP BY host_type 
GO

--VALIDATION QUERIES
--SELECT * 
--FROM vw_borough_stats
--ORDER BY AveragePrice DESC

--SELECT *
--FROM vw_host_stats

--SELECT *
--FROM vw_price_availability
--ORDER BY price_category, availability_category

--SELECT *
--FROM vw_room_type_stats
--ORDER BY TotalSupply DESC