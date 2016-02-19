library(shiny)
library(plotly)

shinyUI(navbarPage(theme = "bootstrap.min.css", "World Holidays",
                   tabPanel("Map"),
                   tabPanel("Documentation",
                            p("India is multiconfessional country and respects
                              all the confessions. That is why there are 77
                              holydays in a year. This number is outlier.
                              However there are only 3 official holydays.
                              You can choose number of Indian holidays and
                              see how appearance of the map changes."),
                            p("Also you can see countries which celebrate 
                              Christmas or Prophet's Birthday or both."),
                            p("When you hover your cursor over the map, you
                              can see information about countries' holidays."),
                            p("Code can be found at ")
                            ),
                   tabPanel("Credits",
                            p("Thank team https://about.modeanalytics.com
                              and especially Benn for idea, data and help."))
))