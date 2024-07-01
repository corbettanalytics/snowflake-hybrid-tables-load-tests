import random
import snowflake.connector
from fastapi import FastAPI


app = FastAPI()
db = snowflake.connector.connect(connection_name='ht_testing')


db.cursor().execute('alter session set query_tag = \'LOAD_TEST_HT_C\'')


@app.get('/segments')
def segments():
    user_id = random.randint(1, 1_000_000)
    cursor = db.cursor(snowflake.connector.DictCursor)
    cursor.execute('select * from ht_testing.tests.user_segments where user_id = %s', [user_id])
    resp = cursor.fetchone()
    cursor.close()
    return resp

    