library(ISLR)
library(MASS)
install.packages("cvTools")
library(cvTools) #run the above line if you don't have this library

############### read Dataset ##############
wineDataset = read.csv('wine.csv')
names(wineDataset)
attach(wineDataset)
cor(wineDataset)
cor.test(Alcohol,Proline)

pairs(wineDataset,col=cultivar)

#Create dummy variables
# Becuse cultivar variable has 3 amount otherwise we have 3 class and logistic regression 
#can have two class
wineDataset$cultivar_1=ifelse(cultivar==1,1,0)
wineDataset$cultivar_2=ifelse(cultivar==2,1,0)
wineDataset$cultivar_3=ifelse(cultivar==3,1,0)

k <- 10 #the number of folds
#make 10 folds
?cvFolds()
folds <- cvFolds(NROW(wineDataset), K=k)
#?cvFolds

folds$subsets
folds$which

#Applying logistic regression on k=10 folds of dataset k=10 times 
Missclassification=0
minMiss=18
maxMiss=0
for(i in 1:k){
  train <- wineDataset[folds$subsets[folds$which != i] , ] #Set the training set
  validation <- wineDataset[folds$subsets[folds$which == i], ] #Set the validation set
  
  glm_logit = glm(formula = cultivar_1 ~ Proline + Flavanoids +
                    Alcohol + AlcalinityOfAsh + 
                   Ash + OD280.OD315OfDilutedWines+
                    Proanthocyanins , data =train)
  glm_probs=predict(glm_logit,
                    data.frame(AlcalinityOfAsh=validation$AlcalinityOfAsh,
                               Alcohol=validation$Alcohol,
                               OD280.OD315OfDilutedWines=validation$OD280.OD315OfDilutedWines,
                               Proline=validation$Proline,
                               Flavanoids=validation$Flavanoids,
                               Ash=validation$Ash,
                               Proanthocyanins=validation$Proanthocyanins),
                     type = "response")
  glm_probs
  pred=ifelse(glm_probs>0.5 ,1 ,0)
  table(pred ,validation$cultivar_1)
  
  minMiss=min(mean(pred!=validation$cultivar_1),minMiss)
  maxMiss=max(mean(pred!=validation$cultivar_1),maxMiss)
  Missclassification= Missclassification+ mean(pred!=validation$cultivar_1)
  
}
#mean Missclassification for k=10 flod
meanMissclassification=Missclassification/k
maxMiss
minMiss
