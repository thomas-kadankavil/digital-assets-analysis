myData <- Ch4_Q19_Data_File_1_
#Import the data file into a data frame (table) and label it myData

#creating frequency distribution

intervals <- seq(0, 600000, by=100000)

House_Value.cut<- cut(myData$House_Value, intervals, left=FALSE, right=TRUE)

House_Value.frequency<- table(House_Value.cut)

House_Value.frequency

View(House_Value.frequency)

#creating histogram

hist(myData$House_Value, breaks=intervals, right=TRUE, main="Histogram for the House_Value variable", xlab="Median House Value (in $)", col="blue")

library(readxl)

myData <- read_excel("C:/Users/thoma/Downloads/Ch4_Q19_Data_File (1).xlsx")

View(myData)
head(myData)
names(myData)

myData <- read_excel("C:/Users/thoma/Downloads/Ch4_Q22_Data_File (2).xlsx")







#Import the data file into a data frame (table) and label it myData

#creating frequency and relative distributions for the Salary variable

intervals <- seq(0, 250000, by=50000)

Salary.cut<- cut(myData$Salary, intervals, left=FALSE, right=TRUE)

Salary.frequency<- table(Salary.cut)

Salary.frequency

View(Salary.frequency)

Salary.prop<-prop.table(Salary.frequency)

Salary.prop

View(Salary.prop)

#creating frequency and relative distributions for the Experience variable

intervals <- seq(0, 30, by=6)

Experience.cut<- cut(myData$Experience, intervals, include.lowest = TRUE)

Experience.frequency<- table(Experience.cut)

Experience.frequency

View(Experience.frequency)

Experience.prop<-prop.table(Experience.frequency)

Experience.prop

View(Experience.prop)

myData <- read_excel("C:/Users/thoma/Downloads/Ch4_Q29_Data_File (1).xlsx")
myData <- read_excel("C:/Users/thoma/Downloads/Ch4_Q33_Data_File (2).xlsx")



View(myData)
head(myData)
names(myData)

#Import the data file into a data frame (table) and label it myData

#creating a contingency table

myTable <- table(myData$Age, myData$Brand)

myTable

#creating a stacked column chart

barplot(myTable, col=c('blue','red'), legend=rownames(myTable), ylab="Count", ylim=c(0,250))


#Import the data file into a data frame (table) and label it myData

#constructing a scatterplot

plot(myData$Consumption ~ myData$Income, main ="Scatterplot of Consumption against Income", xlab = "Income", ylab = "Consumption", col="chocolate", pch=16)


myData <- read_excel("C:/Users/thoma/Downloads/Ch4_Q39_Data_File (1).xlsx")

  # Import the data into a data frame (table) and label it myData.
  
  #obtaining bubble plot
  
  plot(myData$Writing ~ myData$Math, type="n")

symbols(myData$Writing ~ myData$Math, circles=myData$Test_Takers, inches=0.5, bg="blue", main="A bubble plot of Writing, Math, and Test_Takers", xlab = "Math Score", ylab ="Writing Score")

# obtaining scatterplot with categorical variable

plot(myData$Writing ~ myData$Math,pch=16, col=ifelse(myData$Type=="Private", 20, 26))

legend("bottomright", legend=c("Private","Public"), pch=16, col=c(20,26))

myData <- read_excel("C:/Users/thoma/Downloads/Ch4_Q41_Data_File (1).xlsx")
# Import the data file into a data frame (table) and label it myData.

#a. Constructing the contingency table showing Total.

myTable <- xtabs(Quantity~Color+Size, myData)

myTable
