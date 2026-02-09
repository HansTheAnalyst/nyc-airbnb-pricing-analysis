# 🗽 NYC Airbnb Market Analysis (2019)
![SQL](https://img.shields.io/badge/Microsoft%20SQL%20Server-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white) ![Excel](https://img.shields.io/badge/Excel-217346?style=for-the-badge&logo=microsoft-excel&logoColor=white) ![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=Tableau&logoColor=white)

### 🚀 Executive Summary
The New York City Airbnb market is a high-volume, competitive landscape with over **48,000 active listings**. This project analyzes the 2019 dataset to identify high-value investment opportunities and operational inefficiencies.

**The Goal:** Provide data-driven recommendations for real estate investors looking to enter the NYC short-term rental market.
**The Result:** Identified a specific "Authenticity Premium" where individual hosts outperform agencies by **12% in nightly rates**, identifying a clear strategy for maximizing ROI.

---

### 📊 Interactive Dashboard
> **[👉 Click Here to View the Live Dashboard on Tableau Public](https://public.tableau.com/views/NYCAirbnbMarketAnalysisSupplyPricingTrends/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

---

### 💡 Key Insights & Recommendations

| Insight | Supporting Data | Recommendation |
| :--- | :--- | :--- |
| **The "Authenticity" Premium** | Single-listing hosts earn **$158/night** avg vs. **$141/night** for multi-listing agencies. | **Strategy:** Even as you scale, maintain a "boutique" hosting persona. Guests pay a premium for a personalized experience. |
| **Market Concentration** | **Manhattan & Brooklyn** account for **85%** of all active listings. | **Location:** Volume-based strategies must focus on these two boroughs. Queens offers lower entry costs but significantly lower demand volume. |
| **Asset Class Dominance** | **Entire Homes/Apts** make up **52%** of supply and command the highest price points. | **Investment:** Prioritize acquiring full-unit rentals over shared spaces to align with the majority of traveler demand. |
| **Saturation Warning** | The **"Low Price / Low Availability"** segment is the most crowded (14k+ listings). | **Pricing:** Position inventory in the "Medium" price tier to avoid the race-to-the-bottom competition in the budget sector. |

---

### 🛠️ Technical Workflow
This project followed a strict ETL (Extract, Transform, Load) and validation pipeline to ensure data integrity.

#### **Phase 1: SQL ETL Pipeline**
Raw data was processed using a modular SQL approach in **SSMS (SQL Server Management Studio)**.

* **01_Import (`01_import_raw.sql`):**
    * Documented the ingestion of the raw Kaggle dataset via **SSMS Import Flat File Wizard**.
    * Validated successful load by checking row counts and inspecting head records.

* **02_Cleaning & Staging (`02_cleaning_staging.sql`):**
    * **Data Cleaning:** Trimmed whitespace from text fields and replaced NULL `reviews_per_month` with `0`.
    * **Filtering:** Removed invalid records where `price = 0` (clean row count: 48,884).
    * **Feature Engineering:** Calculated business metrics directly into the staging table:
        * `price_category`: Segmented into Low (<$100), Medium ($100-200), High (>$200).
        * `host_type`: Classified hosts as "Single Listing" vs "Multi Listing" based on listing count.
        * `availability_category`: Grouped listings by availability tiers (Low/Medium/High).

* **03_Analytical Views (`03_analytical_views.sql`):**
    * Created business-ready SQL Views to pre-aggregate data for Tableau performance:
        * `vw_borough_stats`: Aggregated supply and pricing by neighborhood group.
        * `vw_room_type_stats`: Compared premiums for Entire Homes vs. Private Rooms.
        * `vw_host_stats`: Analyzed pricing behavior between Single vs. Multi-listing hosts.

#### **Phase 2: Data Validation (Excel)**
* Exported SQL views to `nyc_airbnb_final.xlsx`.
* Performed pivot table spot-checks to verify SQL aggregation logic.

#### **Phase 3: Visualization (Tableau)**
* **Design Logic:** Implemented a strict color system (**Blue** = Volume/Count, **Green** = Financials/Price) to reduce cognitive load.
* **Interactivity:** Added filters for Borough and Room Type to allow users to drill down into specific neighborhoods.

---

### 📂 Repository Structure
```text
├── data/
│   ├── raw/                   # Original 2019 Dataset (NYC_BNB_2019.csv)
│   └── processed/             # Cleaned views (nyc_airbnb_final.xlsx)
├── sql_scripts/
│   ├── 01_import_raw.sql      # Raw ingestion verification
│   ├── 02_cleaning_staging.sql # Cleaning, Null handling, Feature Engineering
│   └── 03_analytical_views.sql # View creation for dashboarding
└── README.md

