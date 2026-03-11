with patients as (
    select * from workspace.default_bronze.stg_patients
),

encounters as (
    select * from workspace.default_bronze.stg_encounters
),

joined as (
    select
        e.encounter_id,
        e.patient_id,
        e.encounter_start,
        e.encounter_stop,
        e.encounter_class,
        e.encounter_description,
        e.total_claim_cost,
        e.reason_description,
        p.birth_date,
        p.gender,
        p.race,
        p.ethnicity,
        p.city,
        p.state,
        p.income,
        datediff(
            to_date(e.encounter_start),
            to_date(p.birth_date)
        ) / 365                                     as age_at_encounter
    from encounters e
    left join patients p
        on e.patient_id = p.patient_id
)

select * from joined
