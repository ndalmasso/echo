with source as (
    select * from workspace.default.conditions
),

renamed as (
    select
        START                                       as condition_start,
        STOP                                        as condition_stop,
        PATIENT                                     as patient_id,
        ENCOUNTER                                   as encounter_id,
        CODE                                        as condition_code,
        DESCRIPTION                                 as condition_description
    from source
)

select * from renamed
