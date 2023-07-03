#Read the data
data <- read.csv(file.path(getwd(), "flipkart_data.csv"), header=TRUE, stringsAsFactors=FALSE)
head(data)
attach(data)

#item 1
## tab a (graphical representation)

#barplot on the variable Type(which contains the type of the earphones)
ggplot(data, aes(x=type)) + geom_bar(fill="Red") + labs(x="Team")

#boxplot on the variable type and ratings of the earphone
ggplot(data, aes(x=type, y=ratings)) + geom_boxplot(fill='steelblue')


#people_review
library(tidyverse)
library(caret)

#Density plot on type and offer percentage on earphones

cols <- c("#F76D5E", "#FFFFBF", "#72D8FF", "#66CC99")
# Basic density plot in ggplot2
ggplot(data, aes(x = offer_percent, colour = type)) +
  geom_density(lwd = 1.2, linetype = 1) +
  scale_color_manual(values = cols)


## tab b
#Consider one of continous attributes, and compute central and variational measures

var1=ratings
summary(var1)

#variance
variance=var(var1)
variance

#standard deviation
std=sqrt(variance)
std

##tab c

#Chebychev's Rule :- It states that for any dataset, at least (1 - 1/k^2)
#of the data falls within k standard deviations of the mean, where k is any
#positive real number greater than 1. mu-+k*sigma

#To propose a one-sigma interval using Chebyshev's rule, we can set k = 1.
#In this case, at least (1 - 1/1^2) = 0% of the data falls within one standard
#deviation from the mean. Since this result is not meaningful, we use empirical
#method.

# Empirical Rule :- Calculate the mean (μ) and standard deviation (σ) of the variable in the dataset.
# The one-sigma interval would be [μ - σ, μ + σ].

var1=ratings
mn=mean(var1)
mn

vr1=var(var1)
std=sqrt(vr1)
std

ll=mn-std
ll
ul=mn+std
ul

plot(var1)
abline(h=ll,col='red')
abline(h=ul,col='red')


##tab d

#by boxplot
boxplot(var1)

#by procedure
q1=quantile(var1,0.25)
q1

q3=quantile(var1,0.75)
q3

iqr=q3-q1
ll=q1-1.5*iqr
ul=q3+1.5*iqr

plot(var1)
abline(h=ll,col='red')
abline(h=ul,col='red')



#Item2
#ratings, offer_percent, color, type

# Tab a: Propose model
#ratings: Uniform model
#offer...: Normal Model
#color: Multinomial Model
#type: Multinomial Model

# Tab b: Estimate parameters

ratings_min = min(ratings)
ratings_max = max(ratings)
offer_mean = mean(offer_percent, na.rm = TRUE)
offer_sd = sd(offer_percent, na.rm = TRUE)
color_probs = table(color) / nrow(data)
type_probs =table(type) / nrow(data)

est_param <- paste("Ratings: Minimum =", ratings_min, ", Maximum =", ratings_max,
      "Offer: mean =", offer_mean, ", standard deviation =", offer_sd,
      "Color: probabilities =", paste(color_probs, collapse = ", "),
      "Type: probability =", type_probs)

# Tab c: Predictive analytics

k1=unique(color)
k2=unique(type)

ratings_prediction = round(runif(1, min =ratings_min, max =ratings_max),1)
offer_prediction = rnorm(1, mean = offer_mean, sd = offer_sd)
color_prediction = sample(k1, size = 1, prob = color_probs)
type_prediction = sample(k2, size = 1, prob = type_probs)

pred <- paste("Ratings: prediction =", ratings_prediction,
      "Offer: prediction =", offer_prediction,
      "Color: prediction =", color_prediction,
      "Type: prediction =", type_prediction)


#item 3

## tab1
var1=company
var2=color

chisq.test(var1,var2)


##tab2

var2=color

n=length(unique(var2))
p1=rep(1/n,n)
length(p1)

k=as.matrix(table(var2))

chisq.test(k,p=rep(1/n,n))


##tab c

var1=ratings
mean1=4 #user input //s
t.test(var1,mu=mean1, conf.level = 0.95)




















