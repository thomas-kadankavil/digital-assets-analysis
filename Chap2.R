# Create a list of R packages that will be used in this document
list.of.packages = c("readxl","dplyr","rmarkdown")
# Identify which packages still need to be installed
new.packages = list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# Install the necessary packages
if(length(new.packages)) install.packages(new.packages)
# Load the necessary packages
library(readxl)
library(dplyr)
library(rmarkdown)

install.packages("dplyr")   # Run once only
library(dplyr)              # Run once per new R session

myData <- arrange(myData, x1, x2, x3)

myData = read_xlsx("Ch2_Q9_Data_File.xlsx")
gt30 = myData$x1>30
sum(gt30, na.rm=TRUE)

sortDataAsc = arrange(myData,x1,x2,x3)
sortDataAsc[1,]


sum(is.na(myData$x1))
sum(is.na(myData$x2))
sum(is.na(myData$x3))


myData = read_xlsx("Ch2_Q14_Data_File.xlsx")
myData$Sex = as.factor(myData$Sex)
myData$Married = as.factor(myData$Married)

count(myData,Sex)
table(myData$Sex)

summary(myData$Sex)

nmales = sum(myData$Sex=="M")
marmales = sum(myData$Sex=="M" & myData$Married=="Y")/nmales
round(marmales*100,2)

nfemales = sum(myData$Sex=="F")
marfemales = sum(myData$Sex=="F" & myData$Married=="Y")/nfemales
(marfemales*100) |> round(2)

sortDataInc = arrange(myData,-Income)
sum(sortDataInc$Sex[1:10]=="M" & sortDataInc$Married[1:10]=="Y")

males = myData[myData$Sex=="M",]
max(males$Income)

min(males$Income)
females = myData[myData$Sex=="F",]
max(females$Income)
min(females$Income)

marmales = myData[(myData$Sex=="M"&myData$Married=="Y"),]
max(marmales$Income)
min(marmales$Income)

unmarmales = myData[(myData$Sex=="M"&myData$Married=="N"),]
max(unmarmales$Income)

min(unmarmales$Income)

myData = data.frame(x1=c(248,124,150,196,NA),x2=c(3.5,3.8,NA,4.5,6.2),x3=c(NA,55,74,32,63))

omitData = myData[complete.cases(myData),]
nrow(omitData)

sum(is.na(myData))
impData = myData %>% mutate_all(~ifelse(is.na(.x), mean(.x, na.rm=TRUE), .x))
colMeans(impData)

myData = read_xlsx("Ch2_Q25_Data_File.xlsx")

largeData = myData[myData$`2018`>=5000000,]
smallData = myData[!(myData$`2018`>=5000000),]
nrow(largeData)

nrow(smallData)
finalData = largeData[largeData$`2018`<=10000000,]
sum(largeData$`2018`>10000000)

myData = read_xlsx("Ch2_Q29_Data_File.xlsx")

# Create index for outliers
idx = myData$TD<5 | myData$Int>20
# Remove those observations
cleanData = myData[!idx,]
# Count how many were removed
sum(idx,na.rm=TRUE)

# Who was removed?
myData$Player[idx]

impData = myData %>% mutate_all(~ifelse(is.na(.x), median(.x, na.rm=TRUE), .x))
round(colMeans(impData[,-(1:2)]),2)

myData = read_xlsx("Ch2_Q36_Data_File.xlsx")

x1Bins = quantile(myData$x1, probs=seq(0,1,by=1/3))
myData$Binned_x1 = cut(myData$x1, breaks=x1Bins, labels=c("1","2","3"), include.lowest=TRUE, right=TRUE)
count(myData,Binned_x1)

summary(myData$Binned_x1)
myData$Binned_x2 = cut(myData$x2, breaks=3, labels = c("1","2","3"), include.lowest=TRUE)
count(myData,Binned_x2)

x3Bins = c(-Inf,50000,100000,Inf)
myData$Binned_x3 = cut(myData$x3, breaks=x3Bins, labels=c("1","2","3"), include.lowest=TRUE)
count(myData,Binned_x3)
myData = read_xlsx("Ch2_Q45_Data_File.xlsx")
myData$Date = as.Date(myData$LastTransactionDate,format='%m-%d-%Y')

EndDate = as.Date("01/01/2022", format="%m/%d/%Y")
myData$DSL = abs(difftime(myData$Date,EndDate))
mean(myData$DSL)

# R Score
myData$DateReverse = as.numeric(myData$DSL * -1)
recencyBins = quantile(myData$DateReverse, probs=seq(0,1, by=1/5))
myData$Binned_Recency = cut(myData$DateReverse, breaks=recencyBins, labels=c("1","2","3","4","5"), include.lowest=TRUE, right=FALSE)
# F Score
FrequencyBins = quantile(myData$Frequency, probs=seq(0,1, by=1/5))
myData$Binned_Frequency = cut(myData$Frequency, breaks=FrequencyBins, labels=c("1","2","3","4","5"), include.lowest=TRUE, right=FALSE)
# M Score
MonetaryBins = quantile(myData$TotalSpending, probs=seq(0,1, by=1/5))
myData$Binned_Monetary = cut(myData$TotalSpending, breaks=MonetaryBins, labels=c("1","2","3","4","5"), include.lowest=TRUE, right=FALSE)
# RFM Score
myData$RFM = paste0(myData$Binned_Recency, myData$Binned_Frequency, myData$Binned_Monetary)
sum(myData$RFM=="555")

myData[myData$RFM=="555",]

myData$lSpending = log(myData$TotalSpending)
myData$Binned_Log = cut(myData$lSpending, breaks=5, labels=c("1","2","3","4","5"), include.lowest=TRUE)
count(myData,Binned_Log)

myData$AverageOrderSize = myData$TotalSpending/myData$Frequency
myData$Binned_AOS = cut(myData$AverageOrderSize, breaks=5, labels=c("1","2","3","4","5"), include.lowest=TRUE, right=FALSE)
count(myData,Binned_AOS)

myData = read_xlsx("Ch2_Q51_Data_File.xlsx")
count(myData,LoanDecision)
myData$Approve = myData$LoanDecision=="Approve"
myData$Reject = myData$LoanDecision=="Reject"

myData$LoanDecisionNew = ifelse(myData$LoanDecision=="Approve", "Approve", "Not approve")
count(myData,LoanDecisionNew)
