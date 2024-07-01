use role accountadmin;
create or replace role ht_tester;
create or replace warehouse ht_testing with 
    warehouse_size = 'XSmall' 
    auto_suspend = 60
    statement_queued_timeout_in_seconds = 1
    max_concurrency_level = 32
;
create or replace database ht_testing;
grant ownership on database ht_testing to role ht_tester;
grant ownership on warehouse ht_testing to role ht_tester;
grant role ht_tester to role accountadmin;

use role ht_tester;
use warehouse ht_testing;
create schema ht_testing.tests;
create or replace table ht_testing.tests.user_segments as
select 
    row_number() over (order by 1) as user_id,
    randstr(32, random()) as segment_1,
    randstr(32, random()) as segment_2,
    randstr(32, random()) as segment_3,
    randstr(32, random()) as segment_4,
    randstr(32, random()) as segment_5,
    randstr(32, random()) as segment_6
from table(generator(rowCount => 1000000))
order by user_id;

create or replace hybrid table ht_testing.tests.user_segments_hybrid (
    user_id integer primary key,
    segment_1 varchar,
    segment_2 varchar,
    segment_3 varchar,
    segment_4 varchar,
    segment_5 varchar,
    segment_6 varchar
);

insert into ht_testing.tests.user_segments_hybrid(
    user_id, 
    segment_1, 
    segment_2, 
    segment_3, 
    segment_4, 
    segment_5, 
    segment_6
) 
select 
    user_id, 
    segment_1,
    segment_2,
    segment_3,
    segment_4,
    segment_5,
    segment_6 
from ht_testing.tests.user_segments
;

-- select * from ht_testing.tests.user_segments_hybrid limit 10;
-- select * from ht_testing.tests.user_segments_hybrid where user_id = 5004;
-- select * from ht_testing.information_schema.tables limit 10;

