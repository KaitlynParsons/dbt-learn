# DBT-LEARN
Tutorial following the [dbt Fundamentals](https://courses.getdbt.com/courses/fundamentals) course with a postgres database.
- learn directory is the dbt project.
- raw_data directory contains the sample data for the course.

## Running the Project
- Running the dev.sh script within the learn directory will compile the project, their is some commands in their with explanations.

## Requirements
- Python 3.9
- dbt 0.20.2
- postgres (I used pgadmin 4 as GUI).

## Helpful Information
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