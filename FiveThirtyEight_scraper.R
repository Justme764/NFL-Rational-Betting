## Script to scrape NFL game score predictions by FiveThirtyEight and organize in a sensible table

# Before getting started, need to start a new Selenium Server
# In command window, revert to root directory and then issue the following commands:
#   cd /Library/Frameworks/R.framework/Versions/3.3/Resources/library/RSelenium/bin
#   java -jar selenium-server-standalone-3.0.1.jar
# (the second command starts a stand-alone Selenium Server "manually")
# Separarately, double-click the chromedriver executable at /Users/amulliken/Documents/WebDriver
# (Also has dependency to install most recent JDE)


library("rvest")
library("XML")
library("RSelenium")


FiveThirtyEight2015_url <- "http://projects.fivethirtyeight.com/2015-nfl-predictions/"

# Open a remote connection and navigate to the Five Thirty Eight NFL predictions page
remDr <- remoteDriver(browserName = "chrome")
remDr$open()
remDr$navigate(FiveThirtyEight2015_url)
# For troubleshooting, try remDr$getStatus()

# This will click on Week 5: !!!!
weekSelectorElement <- remDr$findElement(using = 'css selector', ".week:nth-child(5) .circle")
weekSelectorElement$clickElement()


# Want to loop through each of the weeks (using Rselenium commands to click), and download the table
# Use remDr$close to close the connection

## READ IN RELEVANT DATA FROM HTML
# Note: CSS codes for targeting page text learned from application of SelectorGadget

# test <- htmlParse(FiveThirtyEight2015_url)
# tables <- readHTMLTable(test)
# Five38_predictions <- as.data.frame(tables[2])


# page_data <- read_html(FiveThirtyEight2015_url)
# 
# away_teams <- html_text(html_nodes(page_data, ".team .away"))
# away_teams_prob <- html_text(html_nodes(page_data, "div.prob.away"))
# 
# home_teams <- html_text(html_nodes(page_data, ".team .home"))
# home_teams_prob <- html_text(html_nodes(page_data, "div.prob.home"))


## USE RSELENIUM TO "CLICK" TO THE NEXT WEEK'S DATA

# RSelenium::startServer()
# remDr <- remoteDriver(remoteServerAddr = "localhost", 
#                       version = "",
#                       browserName = "chrome",
#                       platform = "MAC")
# remDr$open()
# remDr$navigate(FiveThirtyEight2015_url)
# 
# webElems <- remDr$findElements(using = 'css selector', ".week:nth-child(5) .circle")
# webElem$clickElement()
# 




# good_nodes <- html_nodes(lego_movie, ".prob")
# 
# test <- html_nodes(lego_move, ".team .away")



# FiveThirtyEight2015 <- read_html(FiveThirtyEight2015_url)
# 
# test <- htmlParse(FiveThirtyEight2015_url)
# 
# 
# win_probs <- xpathApply(test,"//div[@class='prob']", xmlValue)
# elo_spread <- xpathApply(test,"//div[@class='spread home fav']", xmlValue)
# 
# teamnames <- xpathApply(test,"//td[@data-team]", xmlValue)


# <td data-team="SD" class="team home"><div class="winner">SD</div></td>
#   <td class="live"><div class="not-live"> </div></td>
#   </tr>
#   <tr>
#   <td class="day"></td>
#   <td data-team="NO" class="team away"><div class="loser">NO</div></td>
#   <td class="pct">
#   <div style="background-color:#aadaf1" class="prob">33%</div>
#   <div class="spread"> </div>
#   </td>
#   <td class="pct">
#   <div style="background-color:#56b5e3" class="prob">66%</div>
#   <div class="spread home fav">-5</div>
#   </td>
#   
#   <td data-team="ARI" class="team home"><div class="winner">ARI</div></td>
#   <td class="live"><div class="not-live"> </div></td>
#   </tr>
#   <tr>
#   <td class="day"></td>
#   <td data-team="BAL" class="team away"><div class="loser">BAL</div></td>
#   <td class="pct">
#   <div style="background-color:#9ed4ef" class="prob">38%</div>
#   <div class="spread"> </div>
#   </td>
# 
# id_or_class_xp <- "//p[@id='txt2']//text() | //div[@class='mystuff']//text()"
# xpathSApply( doc,id_or_class_xp,xmlValue)
# 
# [1] "Latine dictum" "\n    "        "sit altum"     "\n    "        "videtur"       "\n" 