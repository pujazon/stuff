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

#Donde with same mean says that's true. 

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

#Red and White Wine Quality
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


