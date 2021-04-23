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
A1 <- aov(x1 ~ x2, data=data)
summary(A1)

#Checking assumptions
qqnorm(residuals(A1))
plot(residuals(A1))
print(dwtest(A1,alternative="two.sided"))

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
RW$WineQuality<- cut(RW$quality,c(1,4.99,6,10))
levels(RW$WineQuality)<-c("Low","Medium","High")

#Variables and constants
lastChemicIdx<-12
qualityIdx<-15
typeIdx<-14

for (chemic in 1:lastChemicIdx) {
  print("************************")
  print(paste0("1. Chemical prop: ", chemic))
  AnovaModel.1 <- aov(RW[,chemic]~RW[,qualityIdx], data=RW)
  
  print("1. Datasets are too big, so probabilities are 
        too small, each value is significant")
  #print(shapiro.test(residuals(RW[,chemic])))
  #print(bptest(AnovaModel.1))
  print("1. Check Anova assumptions with plots")
  qqnorm(residuals(AnovaModel.1))
  plot(residuals(AnovaModel.1))
  print(dwtest(AnovaModel.1,alternative="two.sided"))
  
  print(summary(AnovaModel.1))
  print("************************")
}


for (chemic in 1:lastChemicIdx) {
  print("************************")
  print(paste0("2. Chemical prop: ", chemic))
  m1 <- aov(RW[,1]~RW[,15], data=RW)
  summary.aov(m1)

  print("2. Datasets are too big, so probabilities are 
        too small, each value is significant")
  print("2. Check Anova assumptions with plots")
  qqnorm(residuals(m1))
  plot(residuals(m1))
  print(dwtest(m1,alternative="two.sided"))
  
  print(summary(m1))
  print("************************")
}


### Alcohol affectance by type and quality
m3<-aov(alcohol~Type+WineQuality,data=RW)
summary(m3)
qqnorm(residuals(m3))
plot(residuals(m3))
print(dwtest(m3,alternative="two.sided"))

m6<-aov(alcohol~Type+WineQuality+Type*WineQuality,data=RW)
summary(m6)
qqnorm(residuals(m6))
plot(residuals(m6))
print(dwtest(m6,alternative="two.sided"))


### Fixed acidity affectance by type and quality
m4<-aov(fixed.acidity~Type+WineQuality,data=RW)
summary(m4)
qqnorm(residuals(m4))
plot(residuals(m4))
print(dwtest(m4,alternative="two.sided"))

m5<-aov(fixed.acidity~Type+WineQuality+Type*WineQuality,data=RW)
summary(m5)
qqnorm(residuals(m5))
plot(residuals(m5))
print(dwtest(m5,alternative="two.sided"))