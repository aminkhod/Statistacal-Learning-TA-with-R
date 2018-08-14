#install.packages('caTools')
library(caTools)
require(ISLR)
library(boot)
#install.packages('e1071')
library(e1071)
#install.packages('pROC')
library(pROC)
#install.packages('gplots')
library(gplots)
#install.packages('ROCR')
library(ROCR)

wineDataset = read.csv('wine.csv')
names(wineDataset)
#attach(wineDataset)
cor(wineDataset)

#pairs(wineDataset,col=cultivar)

#prepocess for define label
for (i in 1:178){
  if(wineDataset$cultivar[i]==1)wineDataset$cultivar[i]="C1"
  else if(wineDataset$cultivar[i]==2)wineDataset$cultivar[i]="C2"
    else    if(wineDataset$cultivar[i]==3)wineDataset$cultivar[i]="C3"
}

wineDataset$cultivar=as.factor(wineDataset$cultivar)

#make train and test set
?runif()
?floor()
set.seed(floor(runif(1,10,300)))
split <- sample.split(wineDataset$cultivar, SplitRatio = 0.8)

#get training and test data
winetrain <- subset(wineDataset, split)
winetest <- subset(wineDataset, !split)

x=NULL
x=data.frame(Alcohol=winetrain$Alcohol,Proline=winetrain$Proline)
y <- winetrain$cultivar
x_test=data.frame(Alcohol=winetest$Alcohol,Proline=winetest$Proline)
y_test= winetest$cultivar

#Train SVM model
svm_model=svm(cultivar~Alcohol+Proline,data=winetrain)
summary(svm_model)

#Plot SVM model
attach(winetrain)
dat=data.frame(x=x,y=y)
plot(svm_model,data=dat)

#Accuracy on training data
pred=predict(svm_model,x)
table(pred,y)
mean(pred==y)


#Accuracy on test data
predtest=predict(svm_model,x_test)
table(predtest,y_test)
mean(predtest==y_test)


#tuning (cost,degree,gamma,epsilon) for example tuning cost 
?tune()
tune_out<-tune(svm,cultivar~Proline+Alcohol,data=winetrain,
               kernel="linear",
               ranges=list(cost=c(0.001, 0.01, 0.1, 1,5,10,100)))
summary(tune_out)
bestmod=tune_out$best.model
summary(bestmod)
bestmod$cost
bestmod$degree
bestmod$gamma
bestmod$epsilon
plot(bestmod,dat)

#Accuracy of training data in tuning
pred1=predict(bestmod,x)
table(predict=pred1, truth=y)
mean(pred1==y)

#Accuracy of testing data in tuning
pred2=predict(bestmod,x_test)
table(predict=pred2, truth=y_test)
mean(pred2==y_test)

#Drow ROC plot for different SVM model and compare them
?roc()#pROC
roc1=roc(y~Proline,data=winetrain,percent=TRUE,
    # arguments for auc
    partial.auc=c(100, 90), partial.auc.correct=TRUE,
    partial.auc.focus="sens",
    # arguments for ci
    ci=TRUE, boot.n=100, ci.alpha=0.9, stratified=FALSE,
    # arguments for plot
    plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
    print.auc=TRUE, show.thres=TRUE)
roc2 <- roc(y~Alcohol,data=winetrain,
            plot=TRUE, add=TRUE, percent=roc1$percent)
?coords()#pROC
coords(roc1, "best", ret=c("threshold", "specificity", "1-npv"))
coords(roc2, "local maximas", ret=c("threshold", "sens", "spec", "ppv", "npv"))
?ci(roc2)#pROC
#roc1
sens.ci <- ci.se(roc1, specificities=seq(0, 100, 5))
plot(sens.ci, type="shape", col="lightblue")
plot(sens.ci, type="bars")

#roc2
sens.ci2 <- ci.se(roc2, specificities=seq(0, 100, 5))
plot(sens.ci2, type="shape", col="red")
plot(sens.ci2, type="bars")

plot(roc2, add=TRUE)
plot(roc1 ,add=TRUE)
plot(ci.thresholds(roc2))
## End

