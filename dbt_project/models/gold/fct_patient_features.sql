with encounters as (
    select * from workspace.default_bronze.stg_encounters
),

conditions as (
    select * from workspace.default_silver.int_patient_conditions
),

patients as (
    select * from workspace.default_bronze.stg_patients
),

-- latest encounter date per patient
encounter_stats as (
    select
        patient_id,
        count(*)                                    as total_encounters,
        min(to_date(encounter_start))               as first_encounter_date,
        max(to_date(encounter_start))               as last_encounter_date,
        datediff(
            max(to_date(encounter_start)),
            min(to_date(encounter_start))
        )                                           as days_active,
        count(distinct encounter_class)             as encounter_type_diversity,
        avg(total_claim_cost)                       as avg_claim_cost,
        sum(total_claim_cost)                       as total_claim_cost
    from encounters
    group by patient_id
),

-- days since last encounter (recency)
recency as (
    select
        patient_id,
        datediff(
            current_date(),
            max(to_date(encounter_start))
        )                                           as days_since_last_encounter
    from encounters
    group by patient_id
),

-- avg days between visits (regularity)
regularity as (
    select
        patient_id,
        avg(days_since_previous_encounter)          as avg_days_between_visits
    from workspace.default_silver.int_patient_timeline
    where days_since_previous_encounter is not null
    group by patient_id
),

-- final feature table
final as (
    select
        p.patient_id,
        p.gender,
        p.race,
        p.ethnicity,
        p.income,
        datediff(current_date(), to_date(p.birth_date)) / 365   as age,
        es.total_encounters,
        es.first_encounter_date,
        es.last_encounter_date,
        es.days_active,
        es.encounter_type_diversity,
        es.avg_claim_cost,
        es.total_claim_cost,
        r.days_since_last_encounter,
        coalesce(reg.avg_days_between_visits, 0)    as avg_days_between_visits,
        coalesce(c.condition_count, 0)              as condition_count,
        coalesce(c.unique_condition_count, 0)       as unique_condition_count,
        coalesce(c.active_condition_count, 0)       as active_condition_count,
        -- churn label: no visit in last 365 days
        case when r.days_since_last_encounter > 365
            then 1 else 0 end                       as is_churned
    from patients p
    left join encounter_stats es on p.patient_id = es.patient_id
    left join recency r on p.patient_id = r.patient_id
    left join regularity reg on p.patient_id = reg.patient_id
    left join conditions c on p.patient_id = c.patient_id
)

select * from final
