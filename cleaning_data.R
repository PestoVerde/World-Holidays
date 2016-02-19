setwd("/Users/scherkasov/Documents/OneDrive/r_working_d/FUN/World Holidays")

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

#Let us assign country codes to country names, we can not use maps without those codes
library(countrycode)
noh$code <- countrycode(noh$Var1, "country.name", "iso3c")
noh <- noh[!is.na(noh$code),]

library(plotly)

#Let us build map
l <- list(color = toRGB("grey"), width = 0.5)

g <- list(
    showframe = FALSE,
    showcoastlines = FALSE,
    plot_bgcolor = "black",
    projection = list(type = 'Mercator')
)

plot_ly(noh, z = Freq, text = Var1, locations = code, type = 'choropleth', 
        color = Freq, colors = 'Greens', marker = list(line = l), 
        colorbar = list(title = 'Number of holidays')) %>% layout(geo = g)









