FROM python:3.10-slim-buster

RUN apt-get update \
    && apt-get install -y --no-install-recommends 
RUN apt-get -y install git

WORKDIR /usr/src/dbt/dbt_project

# Install the dbt Postgres adapter. This step will also install dbt-core
RUN pip install --upgrade pip
RUN pip install dbt-postgres==1.4.1
RUN pip install pytz

# Install dbt dependencies (as specified in packages.yml file)
# Build seeds, models and snapshots (and run tests wherever applicable)
CMD dbt deps && dbt debug --profiles-dir profiles && sleep infinity