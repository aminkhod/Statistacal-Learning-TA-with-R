#install.packages('caTools')
library(caTools)
require(ISLR)
#library(boot)
wineDataset = read.csv('wine.csv')
names(wineDataset)
attach(wineDataset)
cor(wineDataset)

pairs(wineDataset,col=cultivar)

#Create dummy variables
# Becuse cultivar variable has 3 amount otherwise we have 3 class and logistic regression 
#can have two class
wineDataset$cultivar_1=ifelse(cultivar==1,1,0)
wineDataset$cultivar_2=ifelse(cultivar==2,1,0)

#make train and test set
set.seed(88)
split <- sample.split(wineDataset$cultivar_1, SplitRatio = 0.8)
#get training and test data
split
winetrain <- subset(wineDataset, split)
winetest <- subset(wineDataset, !split)
#Subset selection for logistic regression
#y=B0
glm_null=glm(cultivar_1~1,data = winetrain)
summary(glm_null)

glm_full=glm(cultivar_1~ . - cultivar- cultivar_2,data=winetrain)
summary(glm_full)

stepwize=step(glm_null,
     scope = list(upper=glm_full),
     direction="both",
     test="Chisq",
     data=winetrain)
summary(stepwize)
#fitting selected subset model 

glm_selectedSubset = glm(cultivar_1 ~ Proline + Flavanoids + 
                           Alcohol + AlcalinityOfAsh + 
                           Ash + OD280.OD315OfDilutedWines + 
                           MalicAcid + TotalPhenols, data = winetrain)

summary(glm_selectedSubset)
#predition
glm_probs2=predict(glm_selectedSubset ,newdata=winetest,
                   type = "response")
glm_probs2
glm_pred2=ifelse(glm_probs2>0.5 ,1 ,0)

table(glm_pred2 ,winetest$cultivar_1)
mean(glm_pred2==winetest$cultivar_1)
