# ECHO — Engagement & Churn Health Observatory

> *An end-to-end data engineering and machine learning pipeline for modelling patient retention and behavioural segmentation in digital health, built with Databricks, dbt, and Python.*

---

## Overview

Patient disengagement is a silent risk in digital health: unlike traditional clinical settings, there is no formal discharge event to signal that a patient has stopped engaging. ECHO addresses this by constructing a production-style feature pipeline on synthetic EHR data, delivering interpretable segmentation and churn risk outputs suitable for operational deployment.

The project demonstrates a full analytics workflow — from raw data ingestion through a validated medallion architecture to machine learning outputs — with an emphasis on reproducibility, code quality, and business interpretability.

## Research Questions

1. **Segmentation** — What distinct patient engagement profiles exist within a digital health cohort?
2. **Churn prediction** — Which patients are at risk of disengaging, and what are the primary drivers?

## Results

| Output | Result |
|---|---|
| Churn prevalence | 17.1% (20 / 117 patients) |
| Patient segments | 4 (K-Means, k=4) |
| Churn classifier AUC-ROC | 0.737 (LightGBM) |
| Top churn predictor | Age (SHAP) |

**Segment summary:**

| Segment | n | Age (yr) | Churn Rate | Profile |
|---|---|---|---|---|
| S0 Stable Users | 70 | 59.1 | 19% | Core retained cohort |
| S1 Healthy Engagers | 39 | 20.1 | 3% | Young, low-complexity, low risk |
| S2 Lost High-Need | 3 | 59.5 | 100% | Fully disengaged, high historical utilisation |
| S3 At-Risk Complex | 5 | 68.7 | 60% | Elderly, very high utilisation, priority outreach |

## Stack

| Layer | Tool |
|---|---|
| Data platform | Databricks Community Edition (Delta Lake) |
| Transformations | dbt (Bronze → Silver → Gold) |
| Ingestion | PySpark |
| Machine learning | LightGBM, scikit-learn, UMAP |
| Explainability | SHAP |
| Report | LaTeX |

## Pipeline Architecture

ECHO implements a medallion architecture across three layers, each materialised as a Delta table via dbt models.

```
Bronze   Raw Synthea CSVs → column aliasing and type casting
Silver   Patient–encounter joins, inter-visit intervals, condition aggregations
Gold     fct_patient_features — one row per patient, 9 features + churn label
```

**Gold features:** `age`, `total_encounters`, `avg_days_between_visits`, `condition_count`, `unique_condition_count`, `active_condition_count`, `encounter_type_diversity`, `avg_claim_cost`, `income`

## Repository Structure

```
echo/
├── ingestion/
│   └── load_synthea.py          # PySpark ingestion of Synthea CSV files
├── dbt_project/
│   ├── dbt_project.yml
│   └── models/
│       ├── bronze/              # stg_patients, stg_encounters, stg_conditions, stg_observations
│       ├── silver/              # int_patient_encounters, int_patient_timeline, int_patient_conditions
│       └── gold/                # fct_patient_features
├── notebooks/
│   ├── 01_eda.ipynb             # Exploratory analysis
│   ├── 02_segmentation.ipynb    # K-Means clustering
│   └── 03_churn_model.ipynb     # LightGBM + SHAP
└── report/
    ├── main.tex                 # LaTeX source
    └── figures/                 # Generated plots
```

## Data

Patient data is sourced from [Synthea](https://synthea.mitre.org), an open-source synthetic EHR generator by MITRE Corporation. No real patient information is used at any stage.

| Table | Rows |
|---|---|
| patients | 117 |
| encounters | 8,316 |
| conditions | 4,023 |
| observations | 86,634 |

## Running the Pipeline

### Prerequisites

- Databricks Community Edition account
- dbt-databricks adapter configured in `~/.dbt/profiles.yml`
- Python ≥ 3.9 with dependencies from `requirements.txt`

### Setup

```bash
git clone https://github.com/ndalmasso/echo.git
cd echo
python -m venv .venv && source .venv/bin/activate
pip install -r requirements.txt
```

### dbt

```bash
dbt run --project-dir dbt_project --profiles-dir ~/.dbt --select bronze
dbt run --project-dir dbt_project --profiles-dir ~/.dbt --select silver
dbt run --project-dir dbt_project --profiles-dir ~/.dbt --select gold
dbt test --project-dir dbt_project --profiles-dir ~/.dbt
```

### Notebooks

Run notebooks 01–03 in order within Databricks, against the `workspace.default_gold.fct_patient_features` table produced by the dbt pipeline.

## Report

A full write-up of the methodology and findings is available in [`report/main.tex`](report/main.tex). To compile locally:

```bash
cd report
pdflatex main.tex && pdflatex main.tex
```

---

*ECHO — because every disengaged patient left a signal before they went quiet.*
