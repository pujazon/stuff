# First assignment, first exercice: Part d
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
#The observations within each sample must be independent.
dwtest(AnovaModel.1, alternative ="two.sided")
#The populations from which the samples are selected must be normal.
shapiro.test(residuals(AnovaModel.1))
#The populations from which the samples are selected must have equal variances (homogeneity of variance)
bptest(AnovaModel.1)

#########################################################
#Red and White Wine Quality
#########################################################
#Libaries
library(RcmdrMisc)
library(lmtest)

#Read DataSet
options(digits=2)
redDS<-read.csv2("winequality-red.csv", sep=",", dec=".")
rRows<-nrow(redDS)
redDS$ID<-(1:rRows)
redDS$Type<-c("Red")

whiteDS<-read.csv2("winequality-white.csv", sep=";", dec=".")
wRows<-nrow(whiteDS)
wIdIni<-(rRows+1)
wIdEnd<-(wIdIni+wRows-1)
whiteDS$ID<-(wIdIni:wIdEnd)
whiteDS$Type<-c("White")

RW <- rbind(redDS,whiteDS)
RW$WineQuality<- cut(RW$quality,c(1,5,6,10))
levels(RW$WineQuality)<-c("Low","Medium","High")

#Variables and constants
qualityGroups=3
iLowData=1
iMedData=2
iHighData=3
iRedData=1
iWhiteData=2
jFirstContVar=1
jLastContVar=13
jType=14
jQuality=15
jlast=15
DataArray<-matrix(0,qualityGroups,wIdEnd)

print("************************")
print("Ex 1) Quality")
print("************************")
for (chemic in 1:1) {
  print("************************")
  print(paste0("See if it's influenced by: ", chemic))
  
  #Clean idx var
  DataArray<-matrix(0,qualityGroups,wIdEnd)
  lastLowData=1
  lastMedData=1
  lastHighData=1
  
  for (id in 1:wIdEnd) {
    iQuality<-RW[id,jQuality]
    if(iQuality == "Low") {
      DataArray[iLowData,lastLowData]<-RW[id,chemic]
      lastLowData<-(lastLowData+1)
    } else if (iQuality == "Medium") {
      DataArray[iMedData,lastMedData]<-RW[id,chemic]
      lastMedData<-(lastMedData+1)
    } else if (iQuality == "High") {
      DataArray[iHighData,lastHighData]<-RW[id,chemic]
      lastHighData<-(lastHighData+1)
    } else {
      print("Error")
      exit()
    }
  }

  dfL=data.frame(x1=DataArray[iLowData,], x2="Low")
  dfM=data.frame(x1=DataArray[iMedData,], x2="Medium")
  dfH=data.frame(x1=DataArray[iHighData,], x2="High")
  data=mergeRows(dfL, dfM, common.only=FALSE)
  data=mergeRows(as.data.frame(data), dfH, common.only=FALSE)
   
  print(paste0("Anova result: ", chemic))
  AnovaModel.1 <- aov(x1 ~ x2, data=data)
  print(summary(AnovaModel.1))
    
  print(paste0("Check Anova assumptions: ", chemic))
  print(dwtest(AnovaModel.1, alternative ="two.sided"))
  #shapiro.test(residuals(AnovaModel.1))
  print(bptest(AnovaModel.1))
}

print("************************")
print("Ex 2) Type")
print("************************")
for (chemic in 1:jLastContVar) {
  print("************************")
  print(paste0("See if it's influenced by: ", chemic))
  
  #Clean idx var
  DataArray<-matrix(0,qualityGroups,wIdEnd)
  lastRedData=1
  lastWhiteData=1
  
  for (id in 1:wIdEnd) {
    iType<-RW[id,jType]
    if(iType == "Red") {
      DataArray[iRedData,lastRedData]<-RW[id,chemic]
      lastRedData<-(lastRedData+1)
    } else if (iType == "White") {
      DataArray[iWhiteData,lastWhiteData]<-RW[id,chemic]
      lastWhiteData<-(lastWhiteData+1)
    } else {
      print("Error")
      exit()
    }
  }
  
  dfR=data.frame(x1=DataArray[iRedData,], x2="Red")
  dfW=data.frame(x1=DataArray[iWhiteData,], x2="White")
  data=mergeRows(dfR, dfW, common.only=FALSE)
  
  print(paste0("Anova result: ", chemic))
  AnovaModel.1 <- aov(x1 ~ x2, data=data)
  print(summary(AnovaModel.1))
  
  print(paste0("Check Anova assumptions: ", chemic))
  print(dwtest(AnovaModel.1, alternative ="two.sided"))
  ks.test(x=residuals(AnovaModel.1),y='pnorm',alternative='two.sided')
  print(bptest(AnovaModel.1))
}
