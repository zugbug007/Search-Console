## A script to download and archive Google search analytics
##
## Demo of searchConsoleR R package.
##
## Version 1 - 10th August 2015
##
## Mark Edmondson (http://markedmondson.me)

library(searchConsoleR)
scr_auth()
## change this to the website you want to download data for. Include http

## Authorize script with Search Console.  
## First time you will need to login to Google,
## but should auto-refresh after that so can be put in 
## Authorize script with an account that has access to website.

website <- "https://www.nationaltrust.org.uk"

## data is in search console reliably 3 days ago, so we donwnload from then
## today - 3 days
start <- Sys.Date() - 90
## one days data, but change it as needed
end <- Sys.Date() - 1

## what to download, choose between date, query, page, device, country
download_dimensions <- c('query')

## what type of Google search, choose between 'web', 'video' or 'image'
type <- c('web')

## other options available, check out ?search_analytics in the R console

## first time stop here and wait for authorisation
#dfe = c("device==DESKTOP","country==GBR", "page!=/home", "query~~outdoors")
dfe = c("query~~nature")
## get the search analytics data
data <- search_analytics(siteURL = website, 
                         startDate = start, 
                         endDate = end, 
                         dimensions = download_dimensions, 
                         searchType = type,
                         dimensionFilterExp = dfe)

## do stuff to the data
## combine with Google Analytics, filter, apply other stats etc.

## write a csv to a nice filename
filename <- paste("search_analytics",
                  Sys.Date(),
                  paste(download_dimensions, collapse = "",sep=""),
                  type,".csv",sep="-")

write.csv(data, filename)

