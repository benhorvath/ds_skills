library(stringr)
library(dplyr)
library(tidyr)

#Getting a list if files in a Directory
RAW_DATA_DIR <- './data/raw/'
file_list <- list.files(RAW_DATA_DIR)

#Merging the Files into a Single Dataframe

for (file in file_list) {
    filepath <- paste(RAW_DATA_DIR, file, sep='')
    #If the merged dataset doesn't exist, create it
    if(!exists("dataset")){
        dataset <- read.table(filepath, header = TRUE, sep = "\t")
    }
    # If the merged dataset does exist, append it
    if(exists("dataset")) {
        temp_dataset <- read.table(filepath, header = TRUE, sep = "\t")
        dataset <- rbind(dataset, temp_dataset)
        rm(temp_dataset)
    }
    
}

# Remove NAs from the dataframe

na.omit(dataset, cols="title") #This code didn't work

#Identify soft skills within job postings
dataset$softskill_communication <- str_detect(dataset$description, "communication")
dataset$softskill_teamwork <- str_detect(dataset$description, "teamwork")
dataset$softskill_adaptability <- str_detect(dataset$description, "adaptability")
dataset$softskill_problem_solving <- str_detect(dataset$description, "p.+?solving")
dataset$softskill_interpersonal  <- str_detect(dataset$description, "interpersonal")
dataset$softskill_time_management  <- str_detect(dataset$description, "t.+?management")
dataset$softskill_leadership  <- str_detect(dataset$description, "leadership")
dataset$softskill_attention_to_detail  <- str_detect(dataset$description, "a.+?detail")
dataset$softskill_creativity <- str_detect(dataset$description, "creativity")
dataset$softskill_work_ethic <- str_detect(dataset$description, "w.+?ethic")

#Hard Skills required of data scientist
dataset$hardskill_HTML <- str_detect(dataset$description, "html")
dataset$hardskill_Analytics <- str_detect(dataset$description, "analytics")
dataset$hardskill_pivot_table <- str_detect(dataset$description, "pable")
dataset$hardskill_digital_communication <- str_detect(dataset$description, "digital communication")
dataset$hardskill_data_mining <- str_detect(dataset$description, "data mining")
dataset$hardskill_data_engineering <- str_detect(dataset$description, "data.+?engineering")
dataset$hardskill_database_management <- str_detect(dataset$description, "d,+?management")
dataset$hardskill_User_Interface_Design <- str_detect(dataset$description, "user.+?interface.+?design")
dataset$hardskill_Web_Architecture_and_Development_Framework <- str_detect(dataset$description, "web.+?architecture.+?development framework")
dataset$hardskill_risk_assessment <- str_detect(dataset$description, "risk.+?assessment")
dataset$hardskill_iOS_App_Development <- str_detect(dataset$description, "ios.+?development")

write.csv(dataset, './data/clean/clean.csv', row.names=FALSE)

#From wide to long
datalong <- gather(dataset, condition, skills,softskill_communication:hardskill_iOS_App_Development, factor_key = TRUE)

# Convert True to 1 and False to 0
datalong$skills[datalong$skills == "TRUE"] <- 1

#Convert NA to 0

datalong$skills[is.na(datalong$skills)] <- 0

#Count of soft and hard skills for job posting in Indeed
df <- datalong %>% group_by(condition) %>%
    summarise(count = sum(skills))