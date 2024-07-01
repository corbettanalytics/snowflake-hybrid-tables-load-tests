# Snowflake Hybrid Tables load testing

A repository containing load testing scripts used to check the performance of Snowflake's Hybrid Tables.

## Setup

Install and activate python virtual environment.

```
python -m virtualenv .venv
source .venv/bin/active
```

Install the package dependencies.

```
pip install -r requirements.txt
```

Create a new Snowflake connection that has access to the accountadmin role. This is used to run the `sql/setup.sql` and `sql/cleanup.sql` scripts.

```
snow connection add -n default
```

Run the setup script.

```
snow sql -f sql/setup.sql
```

Create a new Snowflake connection with the Snowflake CLI. Make sure the name is `ht_testing`. The role needs permissions to create databases, warehouses, and roles inside your snowflake instance.

```
snow connections add -n ht_testing
```

## Running a load test

Start the python web app. This app will create a Snowflake connection and use it to perform point lookups against a Snowflake Hybrid table.

```
fastapi run
```

Start the locust load testing app. You can configure the parameters of the load test after it has started.

```
locust
```

## Cleaning up

Run the `sql/cleanup.sql` script.

```
snow sql -f sql/cleanup.sql
```
