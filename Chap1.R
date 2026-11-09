# Create a list of R packages that will be used in this document
list.of.packages = c("readxl","rmarkdown")
# Identify which packages still need to be installed
new.packages = list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
# Install the necessary packages
if(length(new.packages)) install.packages(new.packages)
# Load the necessary packages
library(readxl)
library(rmarkdown)
library(rmarkdown)+
  

myData <- read_excel("C:/Users/thoma/Documents/UMSL/04_Fall2026/BusinessAnalytics6572/BA/Ch01_Q19_Data_File.xlsx")

myData
table(myData$Major)

summary(myData$Major)
myData$Major2 = factor(myData$Major)
table(myData$Major2)

summary(myData$Major2)
object.size(myData$Major)
object.size(myData$Major2)
summary(myData$Student)
table(myData$Student)
class(myData$Major)
class(myData$Major2)
class(myData$Student)

object.size(myData$Student)

myData$Student2 = as.integer(myData$Student)
object.size(myData$Student2)