set -eux # e - exit immediately if returns non-zero status, u - unset variables & params as an error, x - prints a trace of simple commands
export DBT_PROFILES_DIR=.dbt

# dbt deps # installs dependences from the package.yml file

# dbt seed # loads csv files located in data directory

# dbt test # runs all tests

# dbt snapshot # runs snapshots located in snapshot directory

dbt run --full-refresh # compile sql model files against current target db

# dbt source snapshot-freshness # check the freshness of our source data

# dbt docs generate
# dbt docs serve --port 8001