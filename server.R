library(shiny)
library(ggplot2)
library(tidyverse)
library(caret)

server <- function(input, output, session) {
  data <- read.csv(file.path(getwd(), "flipkart_data.csv"), header=TRUE, stringsAsFactors=FALSE)
  attach(data)


  output$Menu1_Tab1_Plot1 <- renderPlot({
    ggplot(data, aes(x=type)) + geom_bar(fill="Red") + labs(x="Team")
  })
  output$Menu1_Tab1_Plot2 <- renderPlot({
    ggplot(data, aes(x=type, y=ratings)) + geom_boxplot(fill='steelblue')
  })

  cols <- c("#F76D5E", "#FFFFBF", "#72D8FF", "#66CC99")
  output$Menu1_Tab1_Plot3 <- renderPlot({
    ggplot(data, aes(x = offer_percent, colour = type)) +
      geom_density(lwd = 1.2, linetype = 1) +
      scale_color_manual(values = cols)
  })
  var1=ratings
  output$summaryOutput <- renderPrint({
    summary(var1)
  })

  variance=var(var1)
  output$varianceText <- renderText({
    variance
  })

  output$SDText <- renderText({
    std=sqrt(variance)
    std
  })

  var1=ratings
  mn=mean(var1)
  output$MeanText <- renderText({
    mn
  })

  vr1=var(var1)
  std=sqrt(vr1)

  output$SQRTText <- renderText({
    std
  })

  ll=mn-std
  ll
  ul=mn+std
  ul
  output$Menu1_Tab3_Plot1 <- renderPlot({
    plot(var1)
    abline(h=ll,col='red')
    abline(h=ul,col='red')
  })

  output$Menu1_Tab4_Plot1 <- renderPlot({
    boxplot(var1)
  })

  q1=quantile(var1,0.25)
  #q1

  q3=quantile(var1,0.75)
  #q3

  iqr=q3-q1
  ll=q1-1.5*iqr
  ul=q3+1.5*iqr

  output$Menu1_Tab4_Plot2 <- renderPlot({
    plot(var1)
    abline(h=ll,col='red')
    abline(h=ul,col='red')
  })

  set.seed(1)
  #use 70% of dataset as training set and 30% as test set
  sample <- sample(c(TRUE, FALSE), nrow(data), replace=TRUE, prob=c(0.7,0.3))
  train  <- data[sample, ]
  test   <- data[!sample, ]

  # Building the model

  #train the model by assigning ratings column as target variable and other as independent variables
  model_ratings = lm(ratings ~ people_review + offer_price + real_price,  data = train)

  output$MCText1 <- renderPrint({
    est_param
    # model_ratings$coefficients
  })

  # predicting the target variable
  model_ratings_pred <- predict(model_ratings, test)
  output$myTable1 <- renderPrint({
    pred
    # model_ratings$coefficients
  })
  # output$myTable1 <- DT::renderDataTable({
  #   data.frame( R2 = R2(model_ratings_pred, test $ ratings),
  #               RMSE = RMSE(model_ratings_pred, test $ ratings),
  #               MAE = MAE(model_ratings_pred, test $ ratings))
  # })


  #train the model by assigning people_review column as target variable and other as independent variables
  model_review = lm(people_review ~ ratings + offer_price + real_price,  data = train)
  output$MCText2 <- renderPrint({
    model_review$coefficients
  })
  # predicting the target variable
  model_review_pred <- predict(model_review, test)
  # computing model performance metrics
  output$myTable2 <- DT::renderDataTable({
    data.frame( R2 = R2(model_review_pred, test $ people_review),
                RMSE = RMSE(model_review_pred, test $ people_review),
                MAE = MAE(model_review_pred, test $ people_review))
  })



  #train the model by assigning offer_price column as target variable and other as independent variables
  model_offer = lm(offer_price ~ people_review + ratings + real_price,  data = train)
  output$MCText3 <- renderPrint({
    model_offer$coefficients
  })

  # predicting the target variable
  model_offer_pred <- predict(model_offer, test)
  # computing model performance metrics
  output$myTable3 <- DT::renderDataTable({
    data.frame( R2 = R2(model_offer_pred, test $ offer_price),
                RMSE = RMSE(model_offer_pred, test $ offer_price),
                MAE = MAE(model_offer_pred, test $ offer_price))
  })


  #train the model by assigning real_price column as target variable and other as independent variables
  model_real = lm(real_price ~ people_review + offer_price + ratings,  data = train)
  output$MCText4 <- renderPrint({
    model_real$coefficients
  })
  # predicting the target variable
  model_real_pred <- predict(model_real, test)
  # computing model performance metrics
  output$myTable4 <- DT::renderDataTable({
    data.frame( R2 = R2(model_real_pred, test $ real_price),
                RMSE = RMSE(model_real_pred, test $ real_price),
                MAE = MAE(model_real_pred, test $ real_price))
  })

  ## tab1
  var1=company
  var2=color

  output$Menu4_Tab1 <- renderPrint({
    chisq.test(var1,var2)
  })



  ##tab2

  var2=color

  n=length(unique(var2))
  p1=rep(1/n,n)
  length(p)

  k=as.matrix(table(var2))


  output$Menu4_Tab2 <- renderPrint({
    chisq.test(k,p=rep(1/n,n))
  })

  ##tab c

  var1=ratings
  mean1=4 #user input //s

  observeEvent(input$mu_value, {
    if(input$mu_value == ""){
      output$Menu4_Tab3 <- renderPrint({
        "Enter mu Value"
      })
    }else{
      mean1 <- as.numeric(input$mu_value)
      output$Menu4_Tab3 <- renderPrint({
        t.test(var1,mu=mean1, conf.level = 0.95)
      })
    }
  })





}
