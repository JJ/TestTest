library("lubridate")
dates <- read.csv("iv-commits.csv")
dates$date <- parse_date_time(dates$date, orders = "a b d H M S Y z", locale='en_US.utf8')
