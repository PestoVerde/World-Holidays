setwd("/Users/scherkasov/Documents/OneDrive/r_working_d/World-Holidays")

#Data is from https://modeanalytics.com/reference_lookups/tables/holidays_by_country
#with quiery request "SELECT * FROM reference_lookups.holidays_by_country"

a <- read.csv("untitled-report-92da12e929b5-2016-02-11-07-46-03.csv", 
              stringsAsFactors = F)

### Here we remove all the strange looking symbols
t <- a[1,1]
s <- substr(t, 1,1)
s <- unique(grep(s, a[,1], value = T))
a[which(a$country == s[1]), 1] <- "Aland"
a[which(a$country == s[2]), 1] <- "Benin"
a[which(a$country == s[3]), 1] <- "Cote d'Ivoire"
a[which(a$country == s[4]), 1] <- "Curacao"
a[which(a$country == s[5]), 1] <- "French Polynesia"
a[which(a$country == s[6]), 1] <- "Central African Republic"
a[which(a$country == s[7]), 1] <- "Reunion"
a[which(a$country == s[8]), 1] <- "Saint Barthelemy"
a[which(a$country == s[9]), 1] <- "Senegal"

#One row is empty, let us remove it
a <- a[-which(a$country == ""),]

#Now let us calculate number of holidays
noh <- as.data.frame(table(a$country))
names(noh) <- c("Country", "Number.of.Holidays")

#Let us assign country codes to country names, we can not use maps without those codes
library(countrycode)
noh$code <- countrycode(noh$Country, "country.name", "iso3c")
noh <- noh[!is.na(noh$code),]

#Here we add new column. All numbers of holydays are the same but only goverment
#holydays are counted for India (3 instead of 77)
noh$Freq1 <- noh$Number.of.Holidays
noh$Freq1[which(noh$Country == "India")] <- 3

#Now let us creat row with Christmas, Ramadam or Both
a$notes <- ""
a$notes[grep("Christmas", a$holiday)] <- "Christmas"
a$notes[grep("Ramadan", a$holiday)] <- "Ramadan"
a <- a[which(a$notes != ""),]
a <- a[, -c(2:5)]

library(reshape2)
a <- recast(a, country ~ notes, id.var = c("country", "notes"))
a$notes <- ifelse(a$Christmas > 0 & a$Ramadan == 0, "Christmas", 
                  ifelse(a$Christmas == 0 & a$Ramadan > 0, "Ramadan", "Both"))
a <- a[,-c(2:3)]
names(a)[1] <- "Country"
library(dplyr)
noh <- left_join(noh, a, by = "Country")
noh$notes[is.na(noh$notes)] <- "None"

noh$rel <- ifelse(noh$notes == "Christmas", 1, 
                  ifelse(noh$notes == "Ramadan", 2,
                         ifelse(noh$notes == "Both", 3, 4)))

save(noh, file = "noh.Rdata")