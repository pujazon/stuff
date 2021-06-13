#Open Dataset file
options(digits=3)
Dataset<-read.csv2("Dataset.csv", sep=",", dec=".")
Dataset$X<-NULL

#Let's begin the PCA
pca<-PCA(Dataset[,-12])
pca$eig
plot(pca$eig[,1], type="o", main="Scree Plot")

#Do model
LRM<-lm(Factor.10~Factor.1+Factor.2+Factor.3
               +Factor.4+Factor.5+Factor.6+Factor.7
               +Factor.8+Factor.9, data=Dataset)
summary(LRM)

LRM2<-lm(Factor.10~Factor.1+Factor.2+Factor.3
        +Factor.4+Factor.5, data=Dataset)
summary(LRM2)

LRM3<-lm(Factor.10~Factor.1+Factor.2+Factor.3
         +Factor.4, data=Dataset)
summary(LRM3)


LRM4<-lm(Factor.10~Factor.6+Factor.7
        +Factor.8+Factor.9, data=Dataset)
summary(LRM4)

