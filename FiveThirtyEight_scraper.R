## Script to scrape NFL game score predictions by FiveThirtyEight and organize in a sensible data 
## frame

# Before getting started, need to start a new Selenium Server
# In command window, revert to root directory and then issue the following commands:
#   cd /Library/Frameworks/R.framework/Versions/3.3/Resources/library/RSelenium/bin
#   java -jar selenium-server-standalone-3.0.1.jar
# (the second command starts a stand-alone Selenium Server "manually")
# Separarately, double-click the chromedriver executable at /Users/amulliken/Documents/WebDriver
# (Also has dependency to install most recent JDE)

# Libraries
library("rvest")
library("XML")
library("RSelenium")

# Working Directory
workingDir <- "/Users/amulliken/Google Drive/R/NFL-Rational-Betting"
setwd(workingDir)

# Input - Required URLs
FiveThirtyEight2015_url <- "http://projects.fivethirtyeight.com/2015-nfl-predictions/"
FiveThirtyEight2016_url <- "http://projects.fivethirtyeight.com/2016-nfl-predictions/"

# Open a remote connection and navigate to the Five Thirty Eight NFL predictions page
remDr <- remoteDriver(browserName = "chrome")
remDr$open()
remDr$navigate(FiveThirtyEight2016_url) # change between *2015_url and *2016_url, as well as 
                                        # season number at line 98
# For troubleshooting, try remDr$getStatus()



## LOOP THROUGH WEEK PAGES AND EXTRACT DATA FROM HTML

master_df <- data.frame()
for(j in 1:17){

  # for some reason this isnt working
  week_idx <- as.integer(j)
  
  # Select the week you are interested in by issuing Rselenium commands to virtually click
  findElementString <- paste(".week:nth-child(",toString(week_idx),") .circle",sep="")
  weekSelectorElement <- remDr$findElement(using = 'css selector', findElementString)
  weekSelectorElement$clickElement()
  
  # Get all of the page data
  page_data <- htmlParse(remDr$getPageSource()[[1]])
  table_data_raw <- readHTMLTable(page_data, stringsAsFactors=FALSE)
  table_data <- table_data_raw[[2]]
  
  # Save the data we need
  awayteam_name <- table_data$V2
  hometeam_name <- table_data$V5
  
  # initialize vectors with 538 predictions
  awayteam_winPct <- numeric(nrow(table_data))
  awayteam_line <- numeric(nrow(table_data))
  hometeam_winPct <- numeric(nrow(table_data))
  hometeam_line <- numeric(nrow(table_data))
  
  for(i in 1:nrow(table_data)){
    
    rawAwayString <- table_data$V3[i]
    testSplit <- unlist(strsplit(rawAwayString,"\n"))
    if(length(testSplit)>1){
      testSplit[2] <- trimws(testSplit[2],which="both")
      awayteam_winPct[i]<-as.numeric(gsub("%","",testSplit[1]))
      if(testSplit[2]!="PK"){
        awayteam_line[i]<-as.numeric(testSplit[2])
      }
      # else we want to leave as 0 - a pick em line
      hometeam_line[i]<-(-1*awayteam_line[i])
    }else{
      awayteam_winPct[i]<-as.numeric(gsub("%","",testSplit))
    }
    
    rm(testSplit)
    
    rawHomeString <- table_data$V4[i]
    testSplit <- unlist(strsplit(rawHomeString,"\n"))
    if(length(testSplit)>1){
      testSplit[2] <- trimws(testSplit[2],which="both")
      hometeam_winPct[i]<-as.numeric(gsub("%","",testSplit[1]))
      if(testSplit[2]!="PK"){
        hometeam_line[i]<-as.numeric(testSplit[2])
      }
      # else we want to leave as 0 - a pick em line
      awayteam_line[i]<-(-1*hometeam_line[i])
    }else{
      hometeam_winPct[i]<-as.numeric(gsub("%","",testSplit))
    }
    
  }
  
  
  # Create season, week, and week-game vectors to include in data frame
  season <- rep(2016,times=nrow(table_data))
  week <- rep(week_idx,times=nrow(table_data))
  week_game <- seq(from=1,to=nrow((table_data)),by=1)
  
  week_df <- data.frame(season,week,week_game,awayteam_name,awayteam_winPct,awayteam_line,
                        hometeam_name,hometeam_winPct,hometeam_line)
  
  # Combine into one master data frame
  if(week_idx==1){
    master_df<-week_df
  } else {
    master_df<-rbind(master_df,week_df)
  }

} # loop over all weeks

# Save data frame into .Rdata and .csv 
saveRDS(master_df, "FiveThirtyEight_predictions.Rdata")
write.csv(master_df, file="FiveThirtyEight_predictions.csv",row.names=FALSE)

remDr$close


