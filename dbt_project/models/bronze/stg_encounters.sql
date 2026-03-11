with source as (
    select * from workspace.default.encounters
),

renamed as (
    select
        Id                                          as encounter_id,
        START                                       as encounter_start,
        STOP                                        as encounter_stop,
        PATIENT                                     as patient_id,
        ORGANIZATION                                as organization_id,
        PROVIDER                                    as provider_id,
        ENCOUNTERCLASS                              as encounter_class,
        CODE                                        as encounter_code,
        DESCRIPTION                                 as encounter_description,
        BASE_ENCOUNTER_COST                         as base_encounter_cost,
        TOTAL_CLAIM_COST                            as total_claim_cost,
        PAYER_COVERAGE                              as payer_coverage,
        REASONCODE                                  as reason_code,
        REASONDESCRIPTION                           as reason_description
    from source
)

select * from renamed
