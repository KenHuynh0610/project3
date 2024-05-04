library(DBI)
library(RMySQL)
library(dbplyr)

tech_layoffs_df <- read_excel("C:/Users/Ken/Downloads/archive (4)/tech_layoffs.xlsx")

tech_layoffs_df$retention_rate <- (tech_layoffs_df[, 10] / tech_layoffs_df[, 9]) * 100
tech_layoffs_df

#to connect to the db, input ur own db info
con <- dbConnect(RMySQL::MySQL(), 
                 host = "localhost",
                 port = 3306,
                 user = "root",
                 password = "",
                 db = "layoff_data")

db
dbListTables(con)
