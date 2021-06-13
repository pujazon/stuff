#Open Dataset file
options(digits=3)
Dataset<-read.csv2("Dataset.csv", sep=",", dec=".")
Dataset$X<-NULL

#Let's begin the PCA
pca<-PCA(Dataset[,-12])
pca$eig
plot(pca$eig[,1], type="o", main="Scree Plot")

#Do model

LRM2<-lm(Factor.10~Factor.1+Factor.2+Factor.3
        +Factor.4+Factor.5, data=Dataset)
summary(LRM2)

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