library(DBI)
library(RMySQL)
library(dbplyr)
library(dplyr)
library(readxl)
library(lubridate)
library(tidyverse)
library(stringr)
library(mice)
library(VIM)

#reading excel file
tech_layoffs_df <- read_excel("C:/Users/Ken/Downloads/archive (4)/tech_layoffs.xlsx")

#learn more about the data like files, column names, value counts, N/A, etc.
str(tech_layoffs_df)
summary(tech_layoffs_df)
head(tech_layoffs_df)


gsub(" ", "", colnames(tech_layoffs_df))#Eliminate spaces from column names
colnames(tech_layoffs_df)[colnames(tech_layoffs_df)
                          == "Money_Raised_in_$_mil"] <- "Money_Raised_in_mil_dollars" #change column name

#drop unnecessary columns and convert column data types
tech_layoffs_df$lat = NULL #drop lat column
tech_layoffs_df$lng = NULL #drop long column
tech_layoffs_df$`#` = NULL #drop "#" column
tech_layoffs_df$Money_Raised_in_mil_dollars <- 
  str_replace_all(tech_layoffs_df$Money_Raised_in_mil_dollars, "\\$", "") # Remove dollar signs
tech_layoffs_df$Money_Raised_in_mil_dollars <- 
  str_replace_all(tech_layoffs_df$Money_Raised_in_mil_dollars, ",", "") # Remove commas
tech_layoffs_df$Money_Raised_in_mil_dollars <- 
  as.numeric(tech_layoffs_df$Money_Raised_in_mil_dollars) # Convert to numeric

Date_layoffs <- as.Date(tech_layoff_df_completed$Date_layoffs) # Convert to date

#Check for missing data
is.na(tech_layoffs_df)
colSums(is.na(tech_layoffs_df)) #show total missing data in each column
p <- function(x){sum((is.na(x))/length(x)*100)} # calculate percentage of missing data fields
apply(tech_layoffs_df, 2, p) #show the percentages in columns

#Impute using mice
impute <- mice(tech_layoffs_df, m=3, seed=12356778, diagnostics = FALSE , remove_collinear = FALSE, method = "cart")
print(impute)

#Complete data
tech_layoff_df_completed <- complete(impute)
summary(tech_layoff_df_completed)

#adding first calculated field which is retention rate
tech_layoffs_modified <- mutate(tech_layoff_df_completed, retention_rate = (Company_Size_after_layoffs / Company_Size_before_Layoffs) * 100)

# Assuming a reference date to calculate months since layoffs began
reference_date <- as.Date("2020-01-01")

# Calculate Months Since Reference
tech_layoffs_modified <-  mutate(tech_layoff_df_completed, Months_Since_Reference = interval(reference_date, Date_layoffs) / months(1))

# Calculate Monthly Layoff Rate
tech_layoffs_modified <- mutate(tech_layoffs_modified, Monthly_Layoff_Rate = Laid_Off / Months_Since_Reference)

# Calculate Financial Impact Ratio
tech_layoffs_modified <- tech_layoffs_modified %>% mutate(Financial_Impact_Ratio = (Laid_Off / Company_Size_before_Layoffs) * 
           (Money_Raised_in_mil_dollars * 1e6 / Company_Size_before_Layoffs))

# Calculate the number of quarters since the reference date to the layoff date
tech_layoffs_modified$Quarters_Since_Reference = as.integer(
  (year(tech_layoffs_modified$Date_layoffs) - year(reference_date)) * 4 +
    (quarter(tech_layoffs_modified$Date_layoffs) - quarter(reference_date))
)

# Calculate Quarterly Layoff Rate
tech_layoffs_modified <- layoffs_data %>%
  mutate(Quarterly_Layoff_Rate = Laid_Off / Quarters_Since_Reference)

# View the first few rows to confirm
head(tech_layoffs_modified)


#to connect to the db, input your own db info
con <- dbConnect(RMySQL::MySQL(), 
                 host = "localhost",
                 port = 3306,
                 user = "root",
                 password = "Leavemealone998.",
                 db = "layoff_data")


dbListTables(con)
#Write to DB
dbWriteTable(conn = con, name = "layoffs_data", value = tech_layoffs_modified, overwrite = TRUE, row.names = FALSE)
#Select first 5 to check
dbGetQuery(con, "SELECT * FROM layoffs_data LIMIT 5")


