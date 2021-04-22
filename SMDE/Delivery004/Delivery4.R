#########################################################
#4th Question: Decathlon Primary Component Analisis
#########################################################
library(car)
library(FactoMineR)
library(lmtest)
library(RcmdrMisc)
library(psych)

data(decathlon)
colnames(decathlon)[c(1,6)]<-c("x100m","x110m.hurdle")
colnames(decathlon)[c(5,10)]<-c("x400m","x1500")

### TEST OF FACTORABILITY ##
###### Bartlett's Test of Spherecity####
## Bartlett test requires the computation of the correlation matrix R and the number of observations.
## The correlation matrix of food prices ##
R<-cor(decathlon[,1:12])
print(R)
n<-nrow(decathlon)

## Bartlett tests if the correlation matrix is an identity matrix. 
#### (H0:R=I) ##
### If we reject the null hypothesis the variables are correlated.
cortest.bartlett(R,n)
## The p-value of Bartlett test is 0.001 < 0.05. 
## Then the null hypothesis is rejected. The variables are correlated.

###### Kaiser-Meyer-Olkin (KMO) Test ###
kmo <- function(x)
{
  x <- subset(x, complete.cases(x))       # Omit missing values
  r <- cor(x)                             # Correlation matrix
  r2 <- r^2                               # Squared correlation coefficients
  i <- solve(r)                           # Inverse matrix of correlation matrix
  d <- diag(i)                            # Diagonal elements of inverse matrix
  p2 <- (-i/sqrt(outer(d, d)))^2          # Squared partial correlation coefficients
  diag(r2) <- diag(p2) <- 0               # Delete diagonal elements
  KMO <- sum(r2)/(sum(r2)+sum(p2))
  MSA <- colSums(r2)/(colSums(r2)+colSums(p2))
  return(list(KMO=KMO, MSA=MSA))
}

#KMO index
kmo(decathlon[,1:12])
#This data is not factorable !?