#Libraries
library(lmtest)
library(FactoMineR)

#Open Dataset file
options(digits=3)
Dataset<-read.csv2("Dataset.csv", sep=",", dec=".")
Dataset$X<-NULL

#Let's begin the PCA
pca<-PCA(Dataset[,-12])
pca$eig
plot(pca$eig[,1], type="o", main="Scree Plot")

#Do models for Answer
LRM2<-lm(Factor.10~Factor.1+Factor.2+Factor.3
         +Factor.4+Factor.5, data=Dataset)
summary(LRM2)


LRM4<-lm(Factor.10~Factor.0+Factor.1+Factor.2
         +Factor.3+Factor.4, data=Dataset)
summary(LRM4)

#FullFactory 2k max and min values for each factor
maxF1=max(Dataset[,1])
minF1=min(Dataset[,1])

maxF2=max(Dataset[,2])
minF2=min(Dataset[,2])

maxF3=max(Dataset[,3])
minF3=min(Dataset[,3])

maxF4=max(Dataset[,4])
minF4=min(Dataset[,4])

maxF5=max(Dataset[,5])
minF5=min(Dataset[,5])


### Test of Regression Assumptions ###
### 1. Normality of the Error Term ###
# Using QQ plot
qqnorm(residuals(LRM4))
# Since the values are taking part close to the diagonal, 
#the distribution is approximately normal.

### 2. Homogenity of Variance ###
# Residual Analysis #
plot(residuals(LRM4))
# Residuals have a rectangular pattern around the zero mean.
# There is no violation of this assumption.

##Breusch Pagan Test
bptest(LRM4)
# H0 is accepted (p>0.05).
# The homogenity of variances is provided.

### 3. The independence of errors ###
dwtest(LRM4, alternative = "two.sided")
# There is not an autocorrelaiton in the data set (p>0.05).
# The errors/observations are independent.
