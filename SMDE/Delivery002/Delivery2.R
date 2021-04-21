#########################################################
#Red and White Wine Quality
#########################################################
#Libaries
library(RcmdrMisc)
library(lmtest)
library(car)

#Read DataSet
options(digits=2)
redDS<-read.csv2("winequality-red.csv", sep=";", dec=".")
rRows<-nrow(redDS)
redDS$ID<-(1:rRows)
redDS$Type<-c("Red")

whiteDS<-read.csv2("winequality-white.csv", sep=";", dec=".")
wRows<-nrow(whiteDS)
wIdIni<-(rRows+1)
wIdEnd<-(wIdIni+wRows-1)
whiteDS$ID<-(wIdIni:wIdEnd)
whiteDS$Type<-c("White")


RW=mergeRows(redDS, whiteDS, common.only=FALSE)
#RW <- rbind(redDS,whiteDS)
RW$WineQuality<- cut(RW$quality,c(1,4.99,6,10))
levels(RW$WineQuality)<-c("Low","Medium","High")

#Variables and constants
lastChemicIdx<-13
qualityIdx<-15
typeIdx<-14

for (chemic in 1:lastChemicIdx) {
  print("************************")
  print(paste0("1. Chemical prop: ", chemic))
  AnovaModel.1 <- aov(RW[,chemic]~RW[,qualityIdx], data=RW)

  print("Check Anova assumptions")
  #print(shapiro.test(RW[,chemic]))
  print(dwtest(AnovaModel.1,alternative="two.sided"))
  print(bptest(AnovaModel.1))
  
  
  print(summary(AnovaModel.1))
  print("************************")
}


for (chemic in 1:lastChemicIdx) {
  print("************************")
  print(paste0("2. Chemical prop: ", chemic))
  m1 <- aov(RW[,chemic]~RW[,typeIdx], data=RW)
  summary.aov(m1)
  
  print("Check Anova assumptions")
  if (length(residuals(AnovaModel.1)) < 3000) {
    print(shapiro.test(residuals(AnovaModel.1)))
  }
  print(leveneTest(RW[,chemic]~RW[,typeIdx],data=RW))
  print(bptest(AnovaModel.1))
  
  
  print(summary(AnovaModel.1))
  print("************************")
}