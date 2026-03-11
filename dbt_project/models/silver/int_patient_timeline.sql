with encounters as (
    select * from workspace.default_bronze.stg_encounters
),

with_row_numbers as (
    select
        encounter_id,
        patient_id,
        encounter_start,
        encounter_stop,
        encounter_class,
        encounter_description,
        total_claim_cost,
        row_number() over (
            partition by patient_id
            order by encounter_start
        )                                           as encounter_number,
        lag(encounter_start) over (
            partition by patient_id
            order by encounter_start
        )                                           as previous_encounter_start,
        datediff(
            to_date(encounter_start),
            to_date(lag(encounter_start) over (
                partition by patient_id
                order by encounter_start
            ))
        )                                           as days_since_previous_encounter
    from encounters
)

select * from with_row_numbers
