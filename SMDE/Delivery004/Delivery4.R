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


decathlon$x100m<- max(decathlon$x100m) - decathlon$x100m
decathlon$x400m<- max(decathlon$x400m) - decathlon$x400m
decathlon$x100m.hurdle<- max(decathlon$x100m.hurdle) - decathlon$x100m.hurdle
decathlon$x1500<- max(decathlon$x1500) - decathlon$x1500

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

##PCA
pca<-PCA(decathlon[,-13])
pca$eig
plot(pca$eig[,1], type="o", main="Scree Plot")

#Other way
#pca<-princomp(decathlon[,1:12],cor=TRUE,scores=TRUE) #,cutoff=0.01)
#summary(pca)
#summary(pca)$loadings
#plot(pca,type="line")
#biplot(pca)

######################

pPoints <- which(colnames(decathlon) == "Points")
nRank<-which(colnames(decathlon) == "Rank")
nComp<-which(colnames(decathlon) == "Competition")
tmp<-decathlon[,-nComp]
#plot(tmp[,-nRank])
par(mar=rep(2, 4))

cor(tmp[,-nRank])

#Do model
reg_model1<-lm(Points~., data=decathlon)
summary(reg_model1)
reg_model2<-lm(Points~x100m+Long.jump+Shot.put+High.jump+x400m+x110m.hurdle+Discus+Pole.vault+Javeline+x1500, data=decathlon)
summary(reg_model2)

#Test
shapiro.test(residuals(reg_model2))
bptest(reg_model2)
dwtest(reg_model2, alternative = "two.sided")

### decathlon$PC1<-pca$ind$coord[,1]
decathlon$PC2<-pca$ind$coord[,2]
decathlon$PC3<-pca$ind$coord[,3]
reg_pc<-lm(Points~PC1 + PC2 + PC3, data=decathlon)
summary(reg_pc)
### Let's do new model based on Principal 
### Component Regression ###
