with queries as (
select
    query_id,
    start_time,
    end_time,
    timediff(MILLISECONDS, start_time, end_time) as duration
from snowflake.account_usage.query_history
where query_tag = 'LOAD_TEST_HT_C'
)

select
    time_slice(start_time::timestamp, 5, 'SECOND') as bucket,
    row_number() over (order by bucket asc) as window,
    round(count(1) / 5) as queries_per_second,
    round(min(duration)) min_ms,
    round(percentile_cont(0.25) within group (order by duration)) as pct_25,
    round(percentile_cont(0.50) within group (order by duration)) as pct_50,
    round(percentile_cont(0.75) within group (order by duration)) as pct_75,
    round(percentile_cont(0.95) within group (order by duration)) as pct_95,
    round(percentile_cont(0.99) within group (order by duration)) as pct_99,
    round(max(duration)) max_ms
from queries
group by 1
order by 1 desc