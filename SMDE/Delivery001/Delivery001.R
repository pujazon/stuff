#First delivery
options(digits=2)
decathlonDS<-read.csv2("decathlon.csv", sep=",", dec=".")
###########################
#a)
boxplot(X100m~Competition, ylab="X100m", xlab="Competition", data=decathlonDS)
###########################
#b)
decathlonDS$x100mOlympic<- cut(decathlonDS$X100m,c(1,10.5,13))
levels(decathlonDS$x100mOlympic)<-c("NotOlympic","Olympic")
#Cross table
tab<-table(decathlonDS$x100mOlympic,decathlonDS$Competition)
tab
#So now we have to check if both Competition and x100mOlypmic are 
#independent or not. So let's see it using Chi-square test.
#But Olympic cateogry on Decastar has 0 runs, less than five, so
#we cannot Chi-square test won't be significant.

#Our hypothesis will be that are independent so,
#Ho: F = Fo
#Ha: F != Fo.
#knowing:
#Probab. pt<-prop.table(tab)
#Nº cases = margin.table(tab)
chisq.test(tab)
#There's a warning message about Chi-squared approximation may be incorrect
#So let's compute it by hand:
ntotal<-margin.table(tab)
sum<-matrix(0,2,1)
expectedTab<-matrix(0,2,2)
#for each competition
for(i in 1:2) {
  #get all runs cases (sum all races of all times)
  for(j in 1:2) {
    sum[i,1] <- (tab[j,i] + sum[i,1])
  }
}
#Expected values if they're independent (so same probability)
for(i in 1:2) {
  for(j in 1:2) {
    #We use 2 because we already know that each variable has 2 categories
    expectedTab[j,i] <- (sum[i,1]/2)
  }
}
expectedTab
tab
#Compute Chi-square
X2=0
for(i in 1:2) {
  for(j in 1:2) {
    #We use 2 because we already know that each variable has 2 categories
    X2 <- (X2 + (((tab[i,j]-expectedTab[i,j])^2)/expectedTab[i,j]))
  }
}
X2
#if we calculate p-value with computed Chi-square having 95%
#of accuracy with 1 degree 
#of freedom, it's 3.8 which is far far smaller than computed one,
#so we can

#Computed chi-square value is 0.8 being higher than 0.04 critical valuea
#So hypothesis will be rejected and the if runsare below the 11s is not
#independant of the competition.
#We work with 

###########################
#c)
#Plot dataand the similar normal distribution
#Use summary to know the mean
#N samples, in decathlon is 50. Used 30
#sd has changed empirically
summary(decathlonDS$X100m)
plot(density(decathlonDS$X100m))
theoDist<-rnorm(30, mean=11, sd=0.4)
lines(density(theoDist),col=2)

summary(decathlonDS$Long.jump)
plot(density(decathlonDS$Long.jump))
theoDist<-rnorm(30, mean=7.3, sd=0.3)
lines(density(theoDist),col=2)

summary(decathlonDS$Shot.put)
plot(density(decathlonDS$Shot.put))
theoDist<-rnorm(30, mean=14.5, sd=1)
lines(density(theoDist),col=2)

summary(decathlonDS$High.jump)
plot(density(decathlonDS$High.jump))
theoDist<-rnorm(30, mean=1.98, sd=0.1)
lines(density(theoDist),col=2)

summary(decathlonDS$X400m)
plot(density(decathlonDS$X400m))
theoDist<-rnorm(30, mean=50, sd=0.8)
lines(density(theoDist),col=2)

summary(decathlonDS$X110m.hurdle)
plot(density(decathlonDS$X110m.hurdle))
theoDist<-rnorm(30, mean=14.6, sd=0.6)
lines(density(theoDist),col=2)

summary(decathlonDS$Discus)
plot(density(decathlonDS$Discus))
theoDist<-rnorm(30, mean=44, sd=3.5)
lines(density(theoDist),col=2)

summary(decathlonDS$Pole.vault)
plot(density(decathlonDS$Pole.vault))
theoDist<-rnorm(30, mean=4.8, sd=0.4)
lines(density(theoDist),col=2)

summary(decathlonDS$Javeline)
plot(density(decathlonDS$Javeline))
theoDist<-rnorm(30, mean=58, sd=6)
lines(density(theoDist),col=2)

summary(decathlonDS$X1500m)
plot(density(decathlonDS$X1500m))
theoDist<-rnorm(30, mean=279, sd=12)
lines(density(theoDist),col=2)

summary(decathlonDS$Rank)
plot(density(decathlonDS$Rank))
theoDist<-rnorm(30, mean=11, sd=8)
lines(density(theoDist),col=2)

summary(decathlonDS$Points)
plot(density(decathlonDS$Points))
theoDist<-rnorm(30, mean=8005, sd=300)
lines(density(theoDist),col=2)
###########################
#d)
# First assignment, first exercice: Part d
vec_n1<-rnorm(50, mean=60, sd=10)
vec_n2<-rnorm(50, mean=60,sd=5)
vec_n3<-rnorm(50, mean=40, sd=10)   

plot(density(vec_n1),xlim=c(10,100),ylim=c(0,0.08), main="First assignment, first exercice: Part d)")
lines(density(vec_n2),col=2)
lines(density(vec_n3),col=3)

# We have to compare three means through t-test
# So we have to perform 3 hypothesis
# 1.) Ho: u1-u2 = 0; Ha: u1-u2 != 0
# We don't know variances so we must assume not equal
# Let's calc it manually and with t.test method
# By default confidence level is 95%, as we want.
(mean(vec_n1)-mean(vec_n2))/(sqrt(((sd(vec_n1)^2)/length(vec_n1))+((sd(vec_n2)^2)/length(vec_n2))))
t.test(vec_n1, vec_n2, alternative = "two.sided", var.equal = FALSE)
#Computed t-test is inside confidence interval, so hypothesis becomes true: Mean1 is equal to Mean2

# 1.) Ho: u1-u3 = 0
(mean(vec_n1)-mean(vec_n3))/(sqrt(((sd(vec_n1)^2)/length(vec_n1))+((sd(vec_n3)^2)/length(vec_n3))))
t.test(vec_n1, vec_n3, alternative = "two.sided", var.equal = FALSE)
#Computed t-test is outside confidence interval, so hypothesis becomes false: Mean1 is not equal to Mean3

# 1.) Ho: u2-u3 = 0
(mean(vec_n2)-mean(vec_n3))/(sqrt(((sd(vec_n2)^2)/length(vec_n2))+((sd(vec_n3)^2)/length(vec_n3))))
t.test(vec_n2, vec_n3, alternative = "two.sided", var.equal = FALSE)
#Computed t-test is outside confidence interval, so hypothesis becomes false: Mean2 is not equal to Mean3

###########################
#e) Let's see if there are differences between X400m and X100m
# We are going to se if X400m mean is equal to X100m mean
#So, Ho: uX100m-uX400m = 0
t.test(decathlonDS$X100m, decathlonDS$X400m, alternative = "two.sided", var.equal = FALSE)
#Computed t-test is outside confidence interval, so hypothesis becomes false:
#X400m mean is not equal to X100m mean

#Now let's see the if the variations are equal:
#So, Ho: sX100m-sX400m = 0
var.test(decathlonDS$X100m, decathlonDS$X400m, alternative = "two.sided")
#Computed F is inside confidence interval, so hypothesis becomes true:
#Variations are equals, so the behavior of runs in both X100m and X400m are equal.
###########################