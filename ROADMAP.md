# ECHO — Project Roadmap

A phased build checklist. Work through each phase in order.

## Phase 0 — Setup & Environment
- [X] Create GitHub repo and clone locally in VSCode
- [X] Sign up for Databricks Community Edition
- [X] Install dbt: `pip install dbt-databricks`
- [X] Download Synthea sample data (100–1000 patients)
- [X] Set up virtual environment and install `requirements.txt`
- [X] Configure dbt profile pointing to Databricks
- [X] Push initial scaffold to GitHub ✅

## Phase 1 — Ingestion (Bronze Layer)
- [X] Write `ingestion/load_synthea.py`
- [X] Load patients, encounters, observations, conditions into Databricks Delta tables
- [X] Write bronze dbt models (stg_patients, stg_encounters, stg_conditions)
- [X] Run `dbt run` successfully for bronze models

## Phase 2 — Transformation (Silver Layer)
- [X] Write `silver/int_patient_encounters.sql`
- [X] Write `silver/int_patient_conditions.sql`
- [X] Write `silver/int_patient_timeline.sql`
- [X] Add dbt tests and run `dbt test`

## Phase 3 — Feature Engineering (Gold Layer)
- [X] Write `gold/fct_patient_features.sql` with recency, frequency, regularity, churn label
- [X] Validate feature distributions
- [X] Add dbt documentation and run `dbt docs generate`

## Phase 4 — Exploratory Data Analysis
- [X] `notebooks/01_eda.ipynb` — distributions, churn rate by age/conditions, correlation matrix
- [X] Export clean figures to `report/figures/`

## Phase 5 — Patient Segmentation
- [X] `notebooks/02_segmentation.ipynb` — K-Means + elbow curve + UMAP visualisation
- [X] Profile and name each cluster
- [X] Export figures

## Phase 6 — Churn Prediction
- [X] `notebooks/03_churn_model.ipynb` — LightGBM + AUC + SHAP
- [X] Export figures

## Phase 7 — LaTeX Report
- [ ] Two-column paper in `report/main.tex`
- [ ] Insert all figures, write all sections
- [ ] Compile to PDF and commit

## Phase 8 — Polish & Publish
- [ ] Clean up notebooks and README
- [ ] Tag release v1.0.0
- [ ] Add to CV and LinkedIn
