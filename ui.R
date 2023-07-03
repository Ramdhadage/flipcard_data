library(shiny)
library(ggplot2)
source('Flipkart_updated.R')
ui <- fluidPage(
  navbarPage(
    "CA One App",
    id = "navpage",
    tabPanel(
      "Menu 1",
        mainPanel(
          # Main content for Menu 1
          tabsetPanel(
            tabPanel("Graphical representation of Data", fluidPage(
              h3("Barplot on the variable Type"),
              plotOutput("Menu1_Tab1_Plot1"),
              h3("Boxplot on the variable type and ratings of the earphone"),
              plotOutput("Menu1_Tab1_Plot2"),
              h3("Basic density plot in ggplot2"),
              plotOutput("Menu1_Tab1_Plot3"),
            )
            ),
            tabPanel("Everything about Rating",
                     fluidPage(
                       h3("Summary of Rating"),
                       verbatimTextOutput("summaryOutput"),
                       h3("variance of Rating"),
                       textOutput("varianceText"),
                       h3("SD of Rating"),
                       textOutput("SDText")

                     )

                     ),
            tabPanel("Chebyshev's", fluidPage(
              h1("Chebyshev's rule on Rating"),
              h3("Mean of Rating"),
              textOutput("MeanText"),
              h3("SQRT of Rating"),
              textOutput("SQRTText"),
              plotOutput("Menu1_Tab3_Plot1"),
            )
                     ),
            tabPanel("box-plot technique", fluidPage(
              h3("BoxPlot of Rating"),
              plotOutput("Menu1_Tab4_Plot1"),
              plotOutput("Menu1_Tab4_Plot2"),
            )
                     )
          )
      )
    ),
    tabPanel(
      "Menu 2",
        mainPanel(
          # Main content for Menu 2
          tabsetPanel(
            tabPanel("Tab a",h2("Regression model"), h4(" For each regression model, we can analyze the coefficients or parameter estimates to determine the direction and magnitude of the relationship between the independent variables and the corresponding response variable. Positive coefficients indicate a positive relationship, while negative coefficients indicate a negative relationship. the significance of the coefficients can be assessed using statistical tests, such as p-values or confidence intervals. A significant coefficient suggests that the corresponding variable has a statistically significant impact on the response variable. By quantifying the uncertainty associated with each variable, we can assess their relative importance in explaining the variability in the response. Variables with lower uncertainty indicate a higher level of confidence in their contribution to the model, while variables with higher uncertainty may have a less certain impact on the response.")),
            tabPanel("Tab b", fluidPage(
              h3("Estimate parameters"),
              verbatimTextOutput("MCText1")
              # h3("Model 2 coefficients"),
              # verbatimTextOutput("MCText2"),
              # h3("Model 3 coefficients"),
              # verbatimTextOutput("MCText3"),
              # h3("Model 4 coefficients"),
              # verbatimTextOutput("MCText4"),
            )
                     ),
            tabPanel("Tab c",
                     fluidPage(

                       h3("Predictive Analytics"),
                       verbatimTextOutput("myTable1")
#
#                        h3("Model 2 - Predicting the target variable"),
#                        DT::dataTableOutput("myTable2"),
#
#                        h3("Model 3 - Predicting the target variable"),
#                        DT::dataTableOutput("myTable3"),
#
#                        h3("Model 4 - Predicting the target variable"),
#                        DT::dataTableOutput("myTable4"),
                     )
                     ),

          )
        )
    ),
    tabPanel(
      "Menu 3",
        mainPanel(
          # Main content for Menu 3
          tabsetPanel(
            tabPanel("Tab a",
                     fluidPage(
                       h2("Hypothesis"),
                       h4("H0: attributes are independent"),
                       h4("H1: attributes are not independent"),
                       verbatimTextOutput("Menu4_Tab1"),
                       h4("p value is less than level of significance therefore we can conclude that attributes may not be independent.")
                               )

                     ),
            tabPanel("Tab b", fluidPage(
              h2("Goodness of fit"),
              verbatimTextOutput("Menu4_Tab2")
            )),
            tabPanel("Tab c", fluidPage(
              h2("Test of mean"),
              textInput(inputId = "mu_value", label = "Enter mu value:", value = "4"),
              verbatimTextOutput("Menu4_Tab3")
            )),
            # tabPanel("Tab d", h2("Content for Tab 4 in Menu 3"))
          )
      )
    )
  )
)

