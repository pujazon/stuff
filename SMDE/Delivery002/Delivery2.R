#########################################################
#ANOVA example
#########################################################
d1<-rnorm(50, mean=8, sd=1)
d2<-rnorm(50, mean=9,sd=0.7)
d3<-rnorm(50, mean=8, sd=0.3)   

plot(density(d1),xlim=c(5,15),ylim=c(0,2), main="3 distributions")
lines(density(d2),col=2)
lines(density(d3),col=3)

k <- 3
Nd <- 50
#Each group has same name of samples
N<-Nd*k

m <- matrix(0,k,1)
tmp <- matrix(0,k,1)
m[1,1] <- mean(d1)
m[2,1] <- mean(d2)
m[3,1] <- mean(d3)
mG <- ((m[1,1]+m[2,1]+m[3,1])/k)

for(i in 1:k) {
  tmp[1,1] = ((m[i,1]-mG)^2)+tmp[1,1]
}
SSB = tmp[1,1]*Nd
tmp[1,1]<-0
SSB

for(j in 1:Nd) {
  tmp[1,1] <- ((d1[j]-m[1,1])^2)+tmp[1,1]
  tmp[2,1] <- ((d2[j]-m[2,1])^2)+tmp[2,1]
  tmp[3,1] <- ((d3[j]-m[3,1])^2)+tmp[3,1]
}
SSE<-tmp[1,1]+tmp[2,1]+tmp[3,1]

MSE<-(SSE/(N-k))

Ftest<-(SSB/(MSE*(k-1)))
Ftest

critcalV<-qf(.95, df1=k-1, df2=N-k)
critcalV

if (Ftest > critcalV){
  cat("Null hypothesis false.\n")
} else {
  cat("Null hypothesis true\n")
}

#Also check it through AnovaModel
df1=data.frame(x1=d1, x2="d1")
df2=data.frame(x1=d2, x2="d2")
df3=data.frame(x1=d3, x2="d3")

data=mergeRows(df1, df2, common.only=FALSE)
data=mergeRows(as.data.frame(data), df3, common.only=FALSE)

### ANOVA on simulated data ####
AnovaModel.1 <- aov(x1 ~ x2, data=data)
summary(AnovaModel.1)

#Checking assumptions
dwtest(AnovaModel.1, alternative ="two.sided")
shapiro.test(residuals(AnovaModel.1))
bptest(AnovaModel.1)

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
  
  print("1. Datasets are too big, so probabilities are 
        too small, each value is significant")
  #print(shapiro.test(residuals(RW[,chemic])))
  #print(dwtest(AnovaModel.1,alternative="two.sided"))
  #print(bptest(AnovaModel.1))
  print("1. Check Anova assumptions with plots")
  #Normality
  #hist(residuals(AnovaModel.1))
  #Homogenity of variance
  #plot(residuals(AnovaModel.1))
  
  print(summary(AnovaModel.1))
  print("************************")
}


for (chemic in 1:lastChemicIdx) {
  print("************************")
  print(paste0("2. Chemical prop: ", chemic))
  m1 <- aov(RW[,chemic]~RW[,typeIdx], data=RW)
  summary.aov(m1)

  print("2. Datasets are too big, so probabilities are 
        too small, each value is significant")
  #print(shapiro.test(residuals(RW[,chemic])))
  #print(dwtest(AnovaModel.1,alternative="two.sided"))
  #print(bptest(AnovaModel.1))
  print("2. Check Anova assumptions with plots")
  #print(leveneTest(RW[,chemic]~RW[,typeIdx],data=RW))
  #print(bptest(AnovaModel.1))
  #qqnorm(residuals(AnovaModel.1))
  
  print(summary(AnovaModel.1))
  print("************************")
}