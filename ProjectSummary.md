# NFL Rational Betting Project

## Overview

The purpose of this project is to test whether there is a _rational_ NFL betting scheme based on [FiveThirtyEight's NFL Predictions](http://projects.fivethirtyeight.com/2016-nfl-predictions/) which will make money over the long term. The project is based in part on the exceptional performance of user A_trizzle in Yahoo's [Pro Football Pick'em](http://football.fantasysports.yahoo.com/pickem?.tsrc=sun) using only FiveThirtyEight's NFL predictations as a basis for picks.

The general thesis is that FiveThirtyEight predictions are purely rational, whereas the Las Vegas betting lines - especially as kick-off approaches - are affected by the "popular vote" of expected and prior bets by the general population. Conveniently, FiveThirtyEight publishes (freely) game-by-game predictions in the same point-spread format as the Vegas betting lines.

In this analysis the Vegas betting lines are treated as a sort of implied prediction of the game outcome. Further, it is acknowledged that the rational betting scheme must not only out-perform the Vegas predictions, but it must out-perform by a sufficient margin to overcome the house advantage built in to a typical bet (i.e. bet $110 to win $100).

### Summary of Approach

- All analysis in R
- Training and testing on 2015 predictions; validation on 2016
- focus on difference between Elo point spread and Vegas point spread
- Examined different betting schemes which assume the option to bet on every game every week
- Two main: fixed bet whenever advantage is noted; or fixed betting budget per week where amount of bet per game is determined algorithmically 

### Included Files




## Data Wrangling

### FiveThirtyEight Predictions

While the FiveThirtyEight NFL Predictions are freely available on the web, there is no accomodation for direct download of the predictions data. For that reason we require web scraping capability to obtain the predictions for algorithm training and testing. 

The web scraping challenge is complicated by the fact that the [FiveThirtyEight NFL Predictions page](http://projects.fivethirtyeight.com/2016-nfl-predictions/) is an _interactive_ web page where the user must click to select a particular week of the season before the table of predictions for that week is displayed. Accordingly, a straightforward R-based scraping using say the 'readHTMLTable' command within the [XML package](https://cran.r-project.org/web/packages/XML/index.html) is not possible. In this project I have relied on the [RSelenium package](https://cran.r-project.org/web/packages/RSelenium/index.html) with dependencies on the [Java Development Kit](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html), [Selenium WebDriver](http://docs.seleniumhq.org/projects/webdriver/), and [ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver/) extension (particularly for use with the Google Chrome browser).

With this combination of tools, I was able to acquire the predictions data for each week in the 2015 and 2016 seasons. 

### NFL Game Results

Past NFL game results are available on numerous websites, often already in well organized tables. While there are sites and services to acquire (for fee) machine-readable results and/or query an API for specific results, I found it most convenient and cost-effective to simply cut and paste from a table rendered on a website. I used the site [www.scoreboard.com](http://www.scoreboard.com/nfl/) and pasted its results into Excel where I was able to massage into a clean, machine-readable format (see NFL_game_results_2015_2016.csv).

### Historical Betting Lines

While the FiveThirtyEight predictions might have been the most difficult data set to acquire from a technical standpoint, the historical betting lines were the most difficult to locate. 

As it turns out, there is no single official betting line per NFL game. Each sportsbook 
