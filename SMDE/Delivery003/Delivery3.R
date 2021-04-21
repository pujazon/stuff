#########################################################
#3rd Question: Decathlon linear regresion
#########################################################
library(car)
library(FactoMineR)
library(lmtest)

data(decathlon)
colnames(decathlon)[c(1,6)]<-c("x100m","x110m.hurdle")
colnames(decathlon)[c(5,10)]<-c("x400m","x1500")

j1500=10
lastNumericalVarIdx=12

for (numericalVarIdx in 1:lastNumericalVarIdx) {
  print(paste0("Check correlation between x1500 and ",
               numericalVarIdx))
  print(cor.test(decathlon[,j1500],decathlon[,numericalVarIdx]))
}

j400=5
#Model 001
model01<-lm(decathlon[,j1500]~decathlon[,j400],
            data=decathlon)
summary(model01)
scatterplot(decathlon[,j1500]~decathlon[,j400],regLine=model01,
            smooth=FALSE,data=decathlon)

#Model 001
model01<-lm(decathlon[,j1500]~decathlon[,j400],
          data=decathlon)
summary(model01)


### Test of Regression Assumptions ###
### 1. Normality of the Error Term ###
# Using QQ plot and histogram. It follows the qq plot follows a line
# while histogram also shows a kind of normal distribution. So accepted
qqnorm(residuals(model01))
hist(residuals(model01))

### 2. Homogenity of Variance ###
# Residual Analysis #
plot(residuals(model01))

### 3. The independence of errors ### 
dwtest(model01, alternative = "two.sided")
# There is not an autocorrelaiton in the data set (p>0.05).
# The errors/observations are independent.
