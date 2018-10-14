# Scrapes job postings for data scientists from Indeed.com, attempting to
# structure the HTML as highly as possible. Output is saved in a TSV file.
#
# Collects 100 data science job listings from five large American cities:
# New York, San Francisco, Chicago, Washington, D.C., and Seattle.

# IMPORT LIBRARIES
# =========

library(dplyr)
library(rvest)
library(stringr)



# DEFINE CUSTOM FUNCTIONS
# =======================

# Extracts job listing data, given an individual job listing's URL (as a 
# string). Returns a list containing A, B, and C, if available.
#
# Requires rvest library.
#
extract_listing_urls <- function(page_html) {
    
    listing_urls <- html_nodes(page_html, '.result')
    job_ids <- xml_attr(listing_urls, 'data-jk')
    
    base_url <- 'https://www.indeed.com/viewjob?jk'
    job_urls <- unlist(lapply(job_ids[1], function(x) paste(base_url, job_ids,
                                                            sep='=')))
    return(job_urls)
}


# Extracts data from an individual job listing, collecting as much as possible,
# returning as highly structured data as possible.
extract_listing_data <- function(page_url) {
    
}

# Produces an output file path, given city and page
create_output_filepath <- function(city, page, ext='tsv') {
    base <- './data/raw/listings'
    
    city_lower <- str_to_lower(city)
    city_decode <- str_remove(city_lower, '%2c')
    city_underscore <- str_replace_all(city_decode, '\\+', '\\_')
        
    path <- paste(base, city_underscore, page, sep='_')
    return(paste(path, ext, sep='.'))
}



# SCRAPE JOB PARAMETERS
# =====================

cities <- c('New+York%2C+NY', 'San+Francisco%2C+CA', 'Chicago%2C+IL',
            'Washington%2C+DC', 'Seattle%2C+WA')
n <- 100
base_url <- 'https://www.indeed.com/jobs?q=data+scientist'



# SCRAPE JOB!
# ===========

# Loop over cities
for (city in cities) {
    
    pages <- seq(0, n, 10)
    
    # Loop over pages
    for (page in pages) {
        city_q <- paste('l', city, sep='=')
        start_q <- paste('start', page, sep='=')
        results_url <- paste(base_url, city_q, start_q, sep='&')
        print(results_url)
        
        # *** Main data extraction! ***
        results_page_html <- read_html(results_url)
        job_listing_urls <- extract_listing_urls(results_page_html)
        page_listing_df <- sapply(job_listing_urls, extract_listing_data) 
        # %>%
        #    mutate('date_scraped'=Sys.Date(),
        #           'city'=city,
        #           'page'=page)
        
        # Save output as TSV
        output_filepath <- create_output_filepath(city, page)
        write.csv(output_filepath, sep='\t', row.names=FALSE)

    }
    
}



# FINISHED
# ========

print('Scrape job finished!')

