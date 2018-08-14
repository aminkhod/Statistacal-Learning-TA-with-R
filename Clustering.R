options(prompt="Clus>")

library(cluster)
data=iris[,-5]
plot(data)

##Principal Components Analysis
?prcomp()
pca.out=prcomp(data,scale. = T)
pca.out
x=pca.out$x
names(pca.out)
biplot(pca.out,scale = 1)


##Kmeans
km=kmeans(data,centers = 4,nstart = 10)
km
plot(data,col=km$cluster)
km$centers
km$cluster
km$size

km1=kmeans(data[,1:2],centers = 4,nstart = 10)
plot(data[,1:2],col=km1$cluster)
plot(data[,1:2],col=iris[,5])

km1$centers
points(km1$centers,pch=3,cex=2,col="black")
text(km$centers,labels=c("a","b","c","d"),pos=2)


##Hierarchical Clustering
#compute distance
#complete method
d=dist(data[1:20],method="manhattan")
d
?hclust()
hc=hclust(d, method = "complete")
hc$height
plot(hc)
rect.hclust(hc, k=4,border="red")

#single method
d=dist(data,method="manhattan")
d
hc=hclust(d, method = "single")
plot(hc)
rect.hclust(hc, k=4,border="red")

##Model-Based Clustering
#install.packages('mclust')
library(mclust)
?Mclust()
mc=Mclust(data)
summary(mc)
mc$classification
plot(mc,what = "classification")

mc1=Mclust(data,G=3)
summary(mc1)
plot(mc1,what = "classification")

