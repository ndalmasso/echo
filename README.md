# ECHO — Engagement & Churn Health Observatory

> *Modelling patient retention and behavioural segmentation in digital health — an end-to-end data pipeline and ML analysis built with Databricks, dbt, and Python.*

## The Problem
Digital health companies depend on sustained patient engagement to deliver outcomes. ECHO builds a production-style feature pipeline and ML analysis on synthetic EHR data, answering two questions:
1. **Segmentation:** What distinct patient engagement profiles exist?
2. **Churn prediction:** Which patients are at risk of disengaging?

## Stack
| Layer | Tool |
|---|---|
| Data platform | Databricks Community Edition |
| Transformations | dbt |
| ML | LightGBM, scikit-learn, SHAP, UMAP |
| Report | LaTeX |

## Structure
```
echo/
├── ingestion/        # Load Synthea data into Databricks
├── dbt_project/      # Bronze → Silver → Gold models
├── notebooks/        # EDA, clustering, churn model
└── report/           # LaTeX research report
```

*ECHO — because every disengaged patient left a signal before they went quiet.*
