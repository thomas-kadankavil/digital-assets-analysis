# Create a list of R packages that will be used in this document
list.of.packages = c("readxl","dplyr","moments","ggplot2","rmarkdown")
# Identify which packages still need to be installed
new.packages = list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# Install the necessary packages
if(length(new.packages)) install.packages(new.packages)
library(readxl)
library(dplyr)
library(ggplot2)
library(moments)
library(rmarkdown)

myData = read_xlsx("Ch3_Q3_Data_File.xlsx")
mean(myData$Expenditures) |> round(digits=0)
median(myData$Expenditures) %>% round(digits=0)
summary(myData$Expenditures)

myData = read_xlsx("Ch3_Q17_Data_File.xlsx")
mean(myData$Canada) %>% round(digits=2)
mean(myData$Latin_America) %>% round(digits=2)
sd(myData$Canada) %>% round(digits=2)
sd(myData$Latin_America) %>% round(digits=2)

rf = 2
((mean(myData$Canada)-rf)/sd(myData$Canada)) %>% round(digits=2)
((mean(myData$Latin_America)-rf)/sd(myData$Latin_America)) %>% round(digits=2)

myData = read_xlsx("Ch3_Q20_Data_File.xlsx")
range(myData$Income)
range(myData$Income)[2]-range(myData$Income)[1]

range(myData$Value)
range(myData$Value)[2]-range(myData$Value)[1]

mu_inc = mean(myData$Income)
mu_val = mean(myData$Value)
mean(abs(myData$Income-mu_inc)) %>% round(digits=2)

sd(myData$Income) %>% round(digits=2)
mean(abs(myData$Value-mu_val)) %>% round(digits=2)
sd(myData$Value) %>% round(digits=2)
cor(myData$Income,myData$Value) %>% round(digits=3)

myData = read_xlsx("Ch3_Q31_Data_File.xlsx")
ggplot(myData,aes(Expenditures)) +
  geom_boxplot() +
  stat_boxplot(geom='errorbar') +
  xlab("Annual Expenditures (in $)") +
  ylim(-1,1) +
  ggtitle("Boxplot for Expenditures")

((min(myData$Expenditures)-mean(myData$Expenditures))/sd(myData$Expenditures)) %>% round(digits=2)

((max(myData$Expenditures)-mean(myData$Expenditures))/sd(myData$Expenditures)) %>% round(digits=2)
scale(myData$Expenditures) %>% min() %>% round(digits=2)
scale(myData$Expenditures) %>% max() %>% round(digits=2)


skewness(myData$Expenditures)
hist(myData$Expenditures)
ggplot(myData,aes(Expenditures)) +
  geom_histogram()

myData = read_xlsx("Ch3_Q33_Data_File.xlsx")

ggplot(myData,aes(Price)) +
  geom_boxplot() +
  stat_boxplot(geom='errorbar') +
  xlab("Gas Price (in $)") +
  ylim(-1,1) +
  ggtitle("Boxplot for Gas Prices Across 50 States")

mu = mean(myData$Price)
mu |> round(digits=2)

((min(myData$Price)-mu)/sd(myData$Price)) %>% round(digits=2)
((max(myData$Price)-mu)/sd(myData$Price)) %>% round(digits=2)
scale(myData$Price) %>% min() %>% round(digits=2)

scale(myData$Price) %>% max() %>% round(digits=2)

myData$Price[myData$Price==max(myData$Price)] = NA
mean(myData$Price, na.rm=TRUE) |> round(digits=2)

skewness(myData$Price, na.rm=TRUE)
hist(myData$Price)

ggplot(myData,aes(Price)) +
  geom_histogram()

# Inspect the column type and summary
str(myData$Price)
summary(myData$Price)

# Count missing and non-finite values
sum(is.na(myData$Price))
sum(!is.finite(myData$Price))

myData[!is.finite(myData$Price), ]

myData$Price[myData$State == "Hawaii" & is.na(myData$Price)] <- 33
myData[myData$State == "Hawaii", ]
sum(is.na(myData$Price))

myData %>%
  filter(!is.finite(Price))
sum(!is.finite(myData$Price))
myData$Price[myData$State == "STATE_NAME"] <- 33
myData %>%
  filter(is.infinite(Price) | is.nan(Price) | is.na(Price))
sum(!is.finite(myData$Price))
ggplot(myData, aes(x = Price)) +
  geom_histogram(binwidth = 0.10, na.rm = TRUE)


myData$Price[myData$State == "California"] <- 3.35
myData$Price[myData$State == "Hawaii"] <- 2.08

myData %>%
  filter(!is.finite(Price))

sum(!is.finite(myData$Price))

ggplot(myData, aes(x = Price)) +
  geom_histogram(binwidth = 0.10)

library(readxl)

myData <- read_excel("Ch3_Q33_Data_File.xlsx")

summary(myData$Price)
sum(is.na(myData$Price))
