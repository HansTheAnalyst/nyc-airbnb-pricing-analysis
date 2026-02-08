-- =============================================
-- File: 02_cleaning_staging.sql
-- Purpose: Clean raw data and create staging table
-- =============================================

--Drop the table if it exists to re-run the script anytime
DROP TABLE IF EXISTS airbnb_cleaned;

--Create the clean table
SELECT id,
       TRIM(name) AS name,
       host_id, 
       TRIM(host_name) AS host_name, 
       TRIM(neighbourhood_group) AS neighbourhood_group,
       TRIM(neighbourhood) AS neighbourhood,
       latitude,
       longitude,
       TRIM(room_type) AS room_type,
       price,
       minimum_nights,
       number_of_reviews,
       last_review,
       ISNULL(reviews_per_month, 0) AS reviews_per_month,
       calculated_host_listings_count,
       availability_365,

--Business Metrics
            CASE
                WHEN price < 100 THEN 'Low'
                WHEN price >= 100 AND price <= 200 THEN 'Medium'
                ELSE 'High'
            END AS price_category,
            CASE
                WHEN availability_365 < 120 THEN 'Low'
                WHEN availability_365 >= 120 AND availability_365 <= 240 THEN 'Medium'
            ELSE 'High'
            END AS availability_category,
            CASE
                WHEN calculated_host_listings_count = 1 THEN 'Single Listing Host'
                ELSE 'Multi Listing Host'
            END AS host_type
INTO airbnb_cleaned
FROM airbnb_raw
WHERE price > 0 

--Validation Steps (Run manually to check quality)

--Row count should be 48,884
SELECT Count(*) as total_rows
FROM airbnb_cleaned

--Check for duplicates
SELECT id, COUNT(*) AS count_of_records
FROM airbnb_cleaned
GROUP BY id
HAVING COUNT(*) > 1