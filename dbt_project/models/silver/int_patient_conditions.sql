with conditions as (
    select
        patient_id,
        condition_code,
        condition_start,
        cast(condition_stop as string)              as condition_stop
    from workspace.default_bronze.stg_conditions
),

aggregated as (
    select
        patient_id,
        count(*)                                    as condition_count,
        count(distinct condition_code)              as unique_condition_count,
        min(condition_start)                        as first_condition_date,
        max(condition_start)                        as latest_condition_date,
        sum(case when condition_stop is null
            or condition_stop = ''
            then 1 else 0 end)                      as active_condition_count
    from conditions
    group by patient_id
)

select * from aggregated
