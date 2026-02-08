--========================================
--File:01_import_raw.sql
--Purpose: Document raw data ingestion
--Source: Kaggle - New York City Airbnb Open Data
--Method: SSMS Import Flat File
--========================================

SELECT COUNT(*) AS row_count
FROM airbnb_raw

SELECT TOP(10) * 
FROM airbnb_raw