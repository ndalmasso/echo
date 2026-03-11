with source as (
    select * from workspace.default.observations
),

renamed as (
    select
        DATE                                        as observation_date,
        PATIENT                                     as patient_id,
        ENCOUNTER                                   as encounter_id,
        CATEGORY                                    as category,
        CODE                                        as observation_code,
        DESCRIPTION                                 as observation_description,
        VALUE                                       as value,
        UNITS                                       as units,
        TYPE                                        as observation_type
    from source
)

select * from renamed
