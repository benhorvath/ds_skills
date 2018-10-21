/*
  indeed.sql

Create indeed db: sqlite3 indeed
*/
DROP TABLE IF EXISTS indeed;

CREATE TABLE indeed 
(
  ID text NOT NULL,
  url varchar(100),	
  title varchar(250),
  company_name varchar(100),
  company_score	varchar(100),
  `description` text,
  time_posted varchar(100),
  meta_data varchar(100),
  date_scraped date,
  city varchar(100),
  `page` varchar(100)
  );

SELECT * FROM indeed;

LOAD DATA INFILE 'c:/ProgramData/MySQL/MySQL Server 8.0/Uploads/indeed_data.csv' 
INTO TABLE Indeed
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
ESCAPED BY '('
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(ID, url, title, company_name, company_score, `description`, time_posted, meta_data, @date_scraped, city, `page`)
SET date_scraped = str_to_date(@date_scraped,'%m/%d/%Y');

SELECT * FROM indeed;



/*
  import clean data with additional hard skills
*/

DROP TABLE IF EXISTS indeed_clean;

CREATE TABLE indeed_clean
(
  url varchar(100), 
  title varchar(250),
  company_name varchar(100),
  company_score varchar(100),
  `description` text,
  time_posted varchar(100),
  metadata varchar(100),
  date_scraped date,
  city varchar(100),
  `page` varchar(100),
  softskill_communication boolean,
  softskill_teamwork boolean,
  softskill_adaptability boolean,
  softskill_problem_solving boolean,
  softskill_interpersonal boolean,
  softskill_time_management boolean,
  softskill_leadership boolean,
  softskill_attention_to_detail boolean,
  softskill_creativity boolean,
  softskill_work_ethic boolean,
  hardskill_HTML boolean,
  hardskill_Analytics boolean,
  hardskill_pivot_table boolean,
  hardskill_digital_communication boolean,
  hardskill_data_mining boolean,
  hardskill_data_engineering boolean,
  hardskill_database_management boolean,
  hardskill_User_Interface_Design boolean,
  hardskill_Web_Architecture_and_Development_Framework boolean,
  hardskill_risk_assessment boolean,
  hardskill_iOS_App_Development boolean,
  hardskill_python boolean,
  hardskill_r boolean,
  hardskill_hadoop boolean,
  hardskill_spark boolean,
  hardskill_c boolean,
  hardskill_java boolean,
  hardskill_aws boolean,
  hardskill_tensorflow boolean,
  hardskill_hive boolean,
  hardskill_pig boolean,
  hardskill_sql boolean,
  hardskill_bd boolean,
  hardskill_shell boolean
  );

/*
Ben's computer:
    sqlite> .mode tabs
    sqlite> .import /Users/benjaminhorvath/Dropbox/Documents/school/grad/607/ds_skills/data/clean/clean.tsv indeed_clean
*/
