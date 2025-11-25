Kurian Zacharia Vadakara, kurianva
Krish Puwar, krishpuw
David Pang, dpang3

Prof. Shamsad Parvin

11/25/2025

Phase 2: Data Source

We have created two files to ensure the database works properly. create.sql creates the tables for the database, along with their unique characteristics (primary keys and foreign keys). load.sql loads data from the .csv files into the newly created tables so queries can be performed on them.

The .csv files are populated with data using Python scripts. The script uses the Python package faker, which generates fake data and is randomized using Python’s random package. In the script, each table is assigned a set number of rows to generate in order to meet the requirement of at least 3000 entries in the database.

Python Libraries:
faker: https://pypi.org/project/Faker/