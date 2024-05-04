library(DBI)
library(RMySQL)
library(dbplyr)

#to connect to the db, input ur own db info
con <- dbConnect(RMySQL::MySQL(), 
                 host = "localhost",
                 port = 3306,
                 user = "root",
                 password = "Leavemealone998.",
                 db = "layoff_data")

dbListTables(con)

dbListFields(con, "tech_layoffs")

dbSendQuery()