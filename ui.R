library(shiny)
library(plotly)

shinyUI(navbarPage(theme = "bootstrap.min.css", "World Holidays",
                   tabPanel("Map",
                            bootstrapPage(radioButtons("radio", 
                                                       label = h4("Options",
                                                                  h6("see Documentation & Credits tab for details")),
                                                       choices = list("All Indian holidays" = 1,
                                                                      "National Indian holidays" = 2),
                                                       selected = 1),#radioButtons
                                          plotlyOutput('trendPlot')
                            )#bootstrapPage
                   ),#tabPanel(Map)
                   
                   tabPanel("Christmas / Ramadan", 
                            fluidRow(
                                column(12, plotOutput("distPlot"))
                            )
                   ),
                   
                   tabPanel("Data Set", 
                            dataTableOutput("table1")
                   ),#tabPanel(Data Set)
                   
                   tabPanel("Documentation & Credits",
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
                            p("Code can be found at", a("GitHub",
                                                        href="https://github.com/PestoVerde/World-Holidays")),
                            p("Thank team of", 
                              a("ModelAnalytic", 
                                href="https://about.modeanalytics.com"),
                              "for idea and data. Special thanks Benn for help."))
))