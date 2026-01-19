# Meta Ads Performance Dashboard

👉 Live dashboard link: https://app.powerbi.com/view?r=eyJrIjoiYTc5Y2QyOWQtODk3My00N2VkLWFmNzYtZjk5NTBjNzA0NjA1IiwidCI6ImZkM2YzMjMwLTE5YzQtNDAxNy1iMGNlLTBmZTJmYjU4OWQzOCJ9

🔍 Project Overview

This project delivers an end-to-end Power BI analytics solution for evaluating paid advertising performance across Meta platforms (Facebook & Instagram).

The dashboard is designed to help marketing and business teams:
* Monitor full-funnel performance (Awareness → Engagement → Conversion)
* Evaluate campaign and creative effectiveness
* Understand audience behavior and demographics
* Optimize budget allocation and ROI

It simulates a real-world marketing analytics use case and follows professional BI practices including star-schema modeling, KPI engineering, and business-driven insights.

🎯 Business Objectives
* Track ad performance across platforms and campaigns
* Identify high-performing creatives and audience segments
* Measure engagement quality and conversion efficiency
* Detect funnel drop-offs and optimization opportunities
* Support data-driven marketing investment decisions

📌 Key KPIs Tracked
* Impressions
* Clicks
* Engagements (Clicks + Shares + Comments)
* Purchases (Conversions)
* CTR (Click-Through Rate)
* Engagement Rate
* Conversion Rate
* Purchase Rate
* Total Budget
* Average Budget per Campaign

These KPIs support both executive-level monitoring and deep-dive performance analysis.

🏗️ Data Model

The solution follows a star schema design:
* Fact Table
   * ad_events – All impressions, clicks, and purchase events
* Dimension Tables
    * ads – Creative details, platforms, targeting
    * campaigns – Campaign timelines and budgets
    * users – Demographics and geographic attributes

This model enables:
* Funnel analysis
* Campaign benchmarking
* Audience segmentation
* ROI evaluation

📄 Detailed documentation:

 * Business Requirements → /docs/Business_Requirements_Document.pdf
 * Domain overview → /docs/Domain_Knowledge_Meta_Ads.pdf

📊 Dashboard Pages

The Power BI report includes dedicated analytical views for both platforms:

✔ Facebook Performance Dashboard
 * KPI overview
 * Funnel metrics
 * Gender & age insights
 * Geo performance
 * Time-based trends
 * Creative comparison

✔ Instagram Performance Dashboard
  * KPI overview
  * Audience segmentation
  * Conversion efficiency
  * Engagement trends
  * Ad-format performance

📸 Dashboard previews are available in the /screenshots folder.

📈 Key Business Insights
* Ads generate strong awareness and engagement (high CTR and engagement rate).
* Lower-funnel conversion efficiency is weaker, indicating opportunity to improve landing pages and retargeting strategies.
* Females aged 18–30 form the highest-engagement audience segment.
* Video and Story formats outperform static creatives across most KPIs.
* Engagement peaks during afternoon and evening hours.
* High-potential geographies include India, the United States, Brazil, Germany, and the UK.

📄 Full analysis & recommendations:
/docs/Meta_Ads_Dashboard_Insights_Report.pdf

💡 Strategic Recommendations
 * Improve landing-page and checkout experience
 * Expand retargeting campaigns for high-intent users
 * Shift budget toward Video and Story ads
 * Prioritize high-performing audience segments
 * Optimize ad delivery by time-of-day
 * Run continuous A/B testing on creatives and offers

🛠️ Tools & Skills Demonstrated
 * Power BI
 * DAX measures & KPI engineering
 * Star schema data modeling
 * Marketing & funnel analytics
 * Audience segmentation

📂 Repository Structure
meta-ads-performance-dashboard/
│
├── Meta_Ads_Performance_Analytics.pbix
├── README.md
├── screenshots/
├── data/
└── docs/

🌐 Live Interactive Report
👉 Live dashboard link: https://app.powerbi.com/view?r=eyJrIjoiYTc5Y2QyOWQtODk3My00N2VkLWFmNzYtZjk5NTBjNzA0NjA1IiwidCI6ImZkM2YzMjMwLTE5YzQtNDAxNy1iMGNlLTBmZTJmYjU4OWQzOCJ9

