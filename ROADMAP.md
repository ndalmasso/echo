# ECHO — Project Roadmap

A phased build checklist. Work through each phase in order.

## Phase 0 — Setup & Environment
- [ ] Create GitHub repo and clone locally in VSCode
- [ ] Sign up for Databricks Community Edition
- [ ] Install dbt: `pip install dbt-databricks`
- [ ] Download Synthea sample data (100–1000 patients)
- [ ] Set up virtual environment and install `requirements.txt`
- [ ] Configure dbt profile pointing to Databricks
- [ ] Push initial scaffold to GitHub ✅

## Phase 1 — Ingestion (Bronze Layer)
- [ ] Write `ingestion/load_synthea.py`
- [ ] Load patients, encounters, observations, conditions into Databricks Delta tables
- [ ] Write bronze dbt models (stg_patients, stg_encounters, stg_conditions)
- [ ] Run `dbt run` successfully for bronze models

## Phase 2 — Transformation (Silver Layer)
- [ ] Write `silver/int_patient_encounters.sql`
- [ ] Write `silver/int_patient_conditions.sql`
- [ ] Write `silver/int_patient_timeline.sql`
- [ ] Add dbt tests and run `dbt test`

## Phase 3 — Feature Engineering (Gold Layer)
- [ ] Write `gold/fct_patient_features.sql` with recency, frequency, regularity, churn label
- [ ] Validate feature distributions
- [ ] Add dbt documentation and run `dbt docs generate`

## Phase 4 — Exploratory Data Analysis
- [ ] `notebooks/01_eda.ipynb` — distributions, churn rate by age/conditions, correlation matrix
- [ ] Export clean figures to `report/figures/`

## Phase 5 — Patient Segmentation
- [ ] `notebooks/02_segmentation.ipynb` — K-Means + elbow curve + UMAP visualisation
- [ ] Profile and name each cluster
- [ ] Export figures

## Phase 6 — Churn Prediction
- [ ] `notebooks/03_churn_model.ipynb` — LightGBM + AUC + SHAP
- [ ] Export figures

## Phase 7 — LaTeX Report
- [ ] Two-column paper in `report/main.tex`
- [ ] Insert all figures, write all sections
- [ ] Compile to PDF and commit

## Phase 8 — Polish & Publish
- [ ] Clean up notebooks and README
- [ ] Tag release v1.0.0
- [ ] Add to CV and LinkedIn
