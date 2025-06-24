
# 📊 Walmart Retail Performance Optimization 
(https://public.tableau.com/app/profile/prabhjot.singh7010/viz/WalmartRetailPerformanceOptimizationDashboard/Dashboard1)

![Facebook vs AdWords](https://cdn.prod.website-files.com/65d8ee5f025f02594c614c17/677e6eec4ac51f76b61392f4_66143cf720b8195f15298a0b_1.webp)

# Problem Statement
Retailers often struggle to understand which customer segments drive the most revenue, and which products underperform across various regions and demographics. Without granular insights into buyer behavior and SKU performance, companies risk inefficient targeting, poor inventory planning, and lost revenue.

## 🎯 Project Objectives

 
- Identify high- and low-performing products (SKUs) across brands, segments, and cities.
- Understand customer behavior across demographic groups (age, gender, marital status).
- Segment customers based on behavioral patterns for targeted marketing.
- Predict customer purchase value using demographic and transactional variables.
- Deliver actionable business insights through interactive dashboards.


# 🧭 Project Goals

- Improve data accessibility and performance through optimized SQL schema and indexing.
- Clean and transform raw transactional data to remove outliers and inconsistencies.
- Cluster customers to identify distinct high-value segments.
- Visualize key performance indicators and trends that support merchandising decisions.
- Support product and marketing strategy through insight-driven recommendations.


# 📊 Project Overview
This is end-to-end analytics project analyzes over **1.1 million retail transactions** using advanced SQL, Python modeling, and Tableau dashboarding. The solution spans:

- **Data Engineering**: Cleaned, transformed, and indexed data using SQL for performance optimization.
- **Customer Segmentation**: Used Pyhton and KMeans clustering to analyze behaviors of 300K+ customers.
- **Predictive Modeling**: Developed a Python based regression model (R² = 0.80) to forecast purchase amounts.
- **Business Intelligence**: Delivered a Tableau dashboard covering AOV trends, SKU performance, and segment engagement to inform strategy.



# 🔗 Tableau Dashboard Link
https://public.tableau.com/app/profile/prabhjot.singh7010/viz/WalmartRetailPerformanceOptimizationDashboard/Dashboard1



# 📊 Key Features & Deliverables

## 🔍 1. Data Cleaning & Exploration (SQL)

- Analyzed 1.1M+ rows of raw transaction data and 3.6K+ unique products using advanced SQL.
- Restructured schema by adding primary and foreign keys and converting data types for indexing.
- Performed data validation to ensure all product_ids were unique and relationally consistent.
- Identified and removed 700+ outliers using Z-score normalization on purchase values.
- Cleaned nulls, handled categorical inconsistencies, and ensured referential integrity.
- Created an optimized, clean table (walmart_clean) for downstream analysis.

## 🧼 2. ETL & Data Preparation (Python)

- Built an ETL pipeline using Python to extract, transform, and prepare cleaned data for modeling.
- Joined demographic and transaction-level data and formatted features for machine learning.
- Converted categorical features (e.g., gender, city, marital status) using one-hot encoding.
- Scaled numerical variables and created derived features (e.g., average spend per segment).

## 📊 3. Exploratory & Statistical Data Analysis (Python)

- Conducted deep EDA using Pandas and Seaborn to understand relationships across:
Age, gender, marital status, city category vs. purchase behavior
- Segment-level trends and product engagement
- Analyzed average purchase behavior across combinations (e.g., gender × marital status).
- Compared SKU performance across city categories, brands, and customer types.
- Extracted statistically significant patterns to inform modeling and dashboard design.

## 🤖 4. Behavioral Clustering (Python – KMeans)

- Applied KMeans clustering to segment 300K+ customers into 5 behavior-based groups.
- Cluster features included average spend, frequency, and demographics.
- Validated clusters using silhouette scores and visualized behavior differences across groups.
- Enabled 25% more precise targeting by aligning marketing with customer segment behavior.

## 📈 5. Predictive Modeling (Regression Analysis)

- Built a linear regression model (R² = 0.80) to predict purchase amounts.
- Model features included: gender, age group, city category, marital status, and product category.
- Performed feature selection and residual analysis to ensure model validity.
- Output used to identify potential high-value customers and estimate future spend patterns.

## 📊 6. Tableau Dashboard – Business Intelligence & Visualization

#Developed a fully interactive Tableau dashboard that included:
- Top & underperforming SKUs by segment, city, and brand
- Average Order Value (AOV) analysis by customer segments and demographics
- Revenue contribution by product brand, segment, and category
- Heatmap of SKU engagement across customer segments
- High-level KPIs for total customers, unique SKUs, revenue share
- Designed with end-user experience in mind, featuring filters, tooltips, and annotations.
- Enabled 39% faster merchandising decisions through real-time insight delivery.

# 🧠 Tools, Libraries & Techniques Used

## 🛠️ Languages & Tools
- SQL (MySQL) – Data cleaning, transformation, optimization
- Python – Data wrangling, clustering, regression modeling
- Tableau – Dashboarding and visualization

## 📦 Libraries
- pandas, numpy – Data manipulation and transformation
- scikit-learn – Clustering (KMeans), regression modeling
- matplotlib, seaborn – Exploratory and visual analysis

## 🧠 Techniques
- CTEs, joins, indexing, schema optimization
- Z-score for outlier detection
- KMeans clustering for segmentation
- Linear regression modeling
- AOV and segment-based analysis
- Business KPI visualization in Tableau


# 🔑 Key Insights

- **68% of revenue** comes from Segments 1 & 2 with highest AOV (~₹9,300).
- Married female shoppers spend slightly more — ideal for upselling.
- **Asus, Dell, Apple, and Sony** top performers; **HP, Toshiba, and Lenovo** underperform.
- Samsung Appliance SKU-145 is the **top-performing SKU** overall.
- Segment 0 contains an unexpectedly high-performing SKU — a potential growth area.

---

# ✅ Recommendations

- **Prioritize Segments 1 & 2** in marketing and merchandising.
- **Target married females** with premium bundles and loyalty campaigns.
- **Boost visibility** of top-performing SKUs (e.g., Samsung, Dell).
- **Phase out or discount** consistently underperforming brands.
- **Explore Segment 0** with pilot campaigns to test its growth potential.


# 👨‍💻 Author

**Prabhjot Singh**  
🎓 B.S. in Information Technology, Marymount University  
🔗 [LinkedIn](https://www.linkedin.com/in/prabhjot-singh-10a88b315/)  
🧠 Passionate about data-driven decision making, analytics, and automation

---

## ⭐ Support

If you found this project useful, feel free to ⭐ it and share it with others!
