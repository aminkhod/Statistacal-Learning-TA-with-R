
library(ISLR)

dataset=Smarket  #one of datasets in libarary ISLR
?Smarket
#it has a parameter (named "Direction") that shows stock market goes up or down
#we want to predict this parameter
fix(Smarket) #shows the data
pairs(Smarket,col=Smarket$Direction)#plots the scatterplot for each pairs of parameters in dataset and coloring the dots in scatterplot based on discrete parameter "Direction" (up direction values with red color and down vlues with black dots)
?pairs

?glm  #general linear model
attach(Smarket)

#######################  Logistic REgression ###########################
#To apply Logistic regression, use command "glm"
glm_fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,family=binomial)#family=binomial determines that Direction is a binomial variable so it maps "up"s to 1 and "down"s to 0.
summary(glm_fit)

glm_fit$residuals
pred_glm=predict(glm_fit,type='response')
pred_glm
# as we see here almost all predicted predictions are near to 0.5 which confirms that there is no significant regression between "Direction" and input parameters as we saw previously in "summary(glm_fit)"

# we want to assign all prediction with predicted value>0.5 to up and down otherwise 
pred_glm2=ifelse(pred_glm>0.5,'Up','Down')
pred_glm2

table(pred_glm2,Direction)#to see the table of: TP,FP in first row & FN,TN in the second row
mean(pred_glm2!=Smarket$Direction)#it equals to "accuracy"
#if accuracy is close to 0.5 it shows that our classifier is not significant and acts like random classifier
#here the classifier is very bad because the accuracy on train data is close to 0.5
#"Very bad" performance is due to two issues :1-accuracy close to 0.5 2- accuracy on training data (VS test data), because we expect high accuracy on training data and not high accuracuy on test data


######################  Disseminating train and test data   #################
train=Year<2005  # assign data with value of Yaer<20005 to train data
#we can refer to test data by Smarket[!train]
train
glm_fit3=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume,family=binomial,subset=train)#we use subset to define the subset of dataset which we use them for training
#Smarket[2,] means from dataset Smarket select second row 
#Smarket[,2] means from dataset Smarket select second column

#Smarket[train,] means from dataset Smarket select rows that their train value is "TRUE" (i.e. they are in train set)
pred_glm3=predict(glm_fit3,newdata=Smarket[!train,],type='response')#to calculate the prediction value on test data we should clarify 'newdata=Smarket[!train,]'
pred_glm4=ifelse(pred_glm3>0.5,'Up','Down')

table(pred_glm4,Direction[!train])#the size of pred_glm4,Direction are not equal and we should specify that we need just the Direction value for data in test by clarifying "Direction[!train]".
mean(pred_glm4==Smarket$Direction[!train])#same as previous command


par(mfrow=c(2,2))
plot(glm_fit) #same as command for ploting linear regression


library(MASS)

#LDA
?lda()
lda_fit=lda(Direction ~ Lag1+Lag2 ,data=Smarket ,subset =train)
lda_fit

smarket_2005=Smarket[!train,]
Direction_2005=smarket_2005$Direction

lda_pred=predict(lda_fit,  smarket_2005)
names(lda_pred)
lda_class=lda_pred$class

table(lda_class,Direction_2005)
mean(lda_class==Direction_2005)

#precision
106/(76+106)

#recall
106/(35+106)

#accuracy
(35+106)/(35+35+76+106)


lda_pred$posterior[1:20 ,2]
lda_pred$posterior[1:20 ,1]
lda_pred$posterior[1:20 ,]

sum(lda_pred$posterior[,1]>=.5)
sum(lda_pred$posterior[,1]<.5)
names(lda_pred$posterior[1,])

lda_class[1:20]
sum(lda_pred$posterior[,1]>.9)
summary(lda_pred$posterior)


#QDA
qda_fit=qda(Direction~Lag1+Lag2 ,data=Smarket ,subset =train)
qda_fit

qda_class=predict(qda_fit,smarket_2005)$class

table(qda_class,Direction_2005)
mean(qda_class==Direction_2005)

#precision
121/(81+121)

#recall
121/(20+121)

#accuracy
(30+121)/(121+20+30+81)


qda_pred= predict(qda_fit,smarket_2005)

sum(qda_pred$posterior[,1]>=.5)
sum(qda_pred$posterior[,1]<.5)

qda_pred$posterior[1:20 ,2]
qda_pred$posterior[1:20 ,1]
qda_pred$posterior[1:20 ,]

qda_class[1:20]
sum(qda_pred$posterior[,2]>.9)
summary(qda_pred$posterior)

#KNN
library(class)
train_X=cbind(Lag1,Lag2)[train,]
test_X=cbind(Lag1,Lag2)[!train,]
train_Direction=Direction[train]

set.seed(6161)
knn_pred=knn(train_X,test_X,train_Direction,k=1)
table(knn_pred,Direction_2005)
#Accuracy
(83+43)/252

knn_pred=knn(train_X,test_X,train_Direction,k=3)
table(knn_pred,Direction_2005)
mean(knn_pred==Direction_2005)
