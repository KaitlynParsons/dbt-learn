# DBT-LEARN
[dbt Fundamentals](https://courses.getdbt.com/courses/fundamentals) course with a postgres database.
- learn directory is the dbt project.
- raw_data directory contains the sample data for the course.

## Running the Project
- Running the dev.sh script within the learn directory will compile the project, their is some commands in their with explanations.

## Requirements
- Python 3.9
- dbt 0.20.2
- postgres (I used pgadmin 4 as GUI).

## Helpful dbt Information

### Materializations
- tables
  - Built as tables in the database.
  - Data is Stored on disk.
  - Slower to build.
  - Faster to query.
- views
  - Built as views in the database.
  - Query is stored on disk.
  - Faster to build.
  - Slower to query.
- ephemeral
  - Does not exist in the database
  - Reusable code snippet
  - Interpolated as CTE in a model that refs this model
  - Cannot query directly.
- incremental
  - Built as table in the database
  - On the first run, builds entire table
  - On subsequent runs, only appends new records*
  - Faster to build because you are only adding new records
  - Does not capture 100% of the data all the tim
  - Thinking for incremental:
    - Start with view
    - When it takes too long to query, switch to table
    - When it takes too long to build, switch to incremental
    - Truly Big Data - Always rebuild last 3 days, completely ignore late arrivals.
    - Always replace data at the partition level.
    - Ideal for immuntable event streams: tall + skinny table, append-only, no updates.
    - Ideal if their are any updates, a reliable updated_at field.
    - Approximately correct.
    - Level of code complexity.
    - Prioritize correectness can negate performance gains from incrementality.
    - An upgrade, not a starting point!
- snapshots
  - Built as a table in the database, usually in a dedicated schema.
  - On the first run, builds entire table and adds four columns: dbt_scd_id, dbt_updated_at, dbt_valid_from, and dbt_valid_to
  - In future runs, dbt will scan the underlying data and append new records based on the configuration that is made.
  - This allows you to capture historical data
### Model Naming Convetions
- Sources
  - Raw data that has already been loaded
- Staging
  - Clean and standardize the data
  - One to one with source tables
- Intermediate
  - Models between staging and final models
  - Always built on staging models
- Fact
  - Things that are occuring or have occurred
  - Events, clicks, votes
- Dimension
  - people, place or thing
  - users, companies, products, customers

### Testing in dbt
- Schema tests shipped with dbt: unique, not null, relationships, accepted values
- Data Tests (specific)
- Schema Tests (generalized)
- Custom Schema Tests (require Jinja + Macros)

### Analyses
  - Analyses are .sql files that live in the analyses folder.
  - Analyses will not be run with dbt run like models. However, you can still compile these from Jinja-SQL to pure SQL using dbt compile. These will compile to the target folder.
  - Analyses are useful for training queries, one-off queries, and audits

### Seeds
  - Seeds are .csv files that live in the data folder.
  - When executing dbt run, seeds will be built in your Data Warehouse as tables. Seeds can be references using the ref macro - just like models!
  - ✅ Seeds should be used for data that doesn't change frequently.
  - ⛔️ Seeds should not be the process for uploading data that changes frequently
  - Seed are useful for loading country codes, employee emails, or employee account IDs
    - Note: If you have a rapidly growing or large company, this may be better addressed through an orchestrated loading solution.
