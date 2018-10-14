# Valuing Data Science Skills

## Purpose

Answer the question, "Which are the most valued data science skills?"

Will need to determine a way to value skills, and compare across different job descriptions.

## Repo Structure

All data is stored in the data directory; raw, freshly scraped data in the raw directory, and clean data in the clean directory.

The end result of this process is an Rmarkdown document describing it and our analysis, all files relating to this stored in the report directory.

Code files

1. scrape.R -- scrapes X data science job postings from Indeed.com
2. create_db.sql -- Creates database and necessary tables
3. [R script to clean scraped data, normalize, and input into SQL tables]
4. [Rmarkdown in report directory containing summary, methodology, findings, and conclusion]

## Prelim

* My github ID is benhorvath, yours is joelgokool1 -- will create Sunday

## Data Sources

* Indeed.com
	* easier because clear query string and pagination!

## Schedule & Tasks

1. Ben: Write R script to scrape pages -- put results in CSV or text file, taking advantage of Indeed.com's easy query string format  -- finish Tuesday night
2. Joel: Bring text into R to clean, and then save results to SQL database with normalized tables (Joel)
3. Thursday night: Video chat to discuss idea for analysis
4. Saturday: Rough draft finished
5. Sunday: Edit and submit!