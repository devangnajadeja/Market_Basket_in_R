getwd()

# Load the libraries
library(Matrix)
library(arules)
library(grid)
library(arulesViz)

data <- read.csv("Bakery.csv")
colnames(data)
str(data)
is.null(data)
head(data)

## Since we are using 'arules' package, the data must be in the form of
## transaction data

tran <- as(split(data[,"Items"],data[,"TransactionNo"]),"transactions")
tran

## 9465 transaction data was obtained from 20507 obs and 94 items

## Frequency of purchased items
itemFrequencyPlot(tran, type="absolute", topN=10)

## Most purchased - Coffee
## Least purchased - Brownie

## Sample of item purchased
table <- crossTable(tran, sort=TRUE)
table[1:5,1:5]

summary(tran)

## support - 0.01
## confidence - 0.5

rules <- apriori(tran ,parameter = list(supp=0.01,conf=0.5))
rules

## result of association rules
inspect(sort(rules))

crossTable(tran,measure='lift',sort=T)[1:5,1:5]

## Visualization
plot(sort(rules,by="lift"),method="graph",control=list(type="items"))

## larger circle - support value is higher
## darker circle - relationship between the two items is getting stronger

