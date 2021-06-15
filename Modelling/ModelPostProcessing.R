#Libraries
#validity <- c(28.841,35.965,31.219,37.090,38.734,30.923,30.443,32.175,30.683,28.745)
#varVal=var(validity)

#Open Dataset file
options(digits=3)
Dataset<-read.csv2("Simulation1.csv", sep=",", dec=".")
Dataset$X.10<-NULL
Dataset$X<-NULL
Means=rowMeans(Dataset)

variances<-matrix(0,32,1)
tmp <- c(0,0,0,0,0,0,0,0,0,0)
for(i in 1:32) {
  for(j in 1:10) {
    tmp[j]=Dataset[i,j]
  }
  variances[i]=sqrt(var(tmp))
}

#The t value from t-student has a alpha of 0.025 and we have 9 df, so value is 2,26
t=2.26
n=10
h<-matrix(0,32,1)
for(i in 1:32) {
  h[i]=(t*(variances[i]/(sqrt(n))))
}


for(i in 1:32) {
  print("**************************")
  print(paste0("Confidence interval of scenario: ", i))
  pos=Means[i]+h[i]
  neg=Means[i]-h[i]
  print(paste0("[", neg))
  print(paste0(pos))
  print("]")
  print("**************************")
}