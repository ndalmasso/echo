with source as (
    select * from workspace.default.patients
),

renamed as (
    select
        Id                                          as patient_id,
        BIRTHDATE                                   as birth_date,
        DEATHDATE                                   as death_date,
        PREFIX                                      as prefix,
        FIRST                                       as first_name,
        LAST                                        as last_name,
        MARITAL                                     as marital_status,
        RACE                                        as race,
        ETHNICITY                                   as ethnicity,
        GENDER                                      as gender,
        CITY                                        as city,
        STATE                                       as state,
        HEALTHCARE_EXPENSES                         as healthcare_expenses,
        HEALTHCARE_COVERAGE                         as healthcare_coverage,
        INCOME                                      as income
    from source
)

select * from renamed
