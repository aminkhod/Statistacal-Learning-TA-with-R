options(prompt="HM>")

data("iris")
head(iris)
str(iris)
iris$Species

#shufle
set.seed(98)
g<- runif(nrow(iris))
g
order(g)
irisr <- iris[order(g), ]
irisr$Species

trainIRIS=irisr[1:120,]
testIRIS=irisr[121:150,]


#DT
#install.packages('tree')
library(tree)


tree_model<- tree(trainIRIS$Species~.,data = trainIRIS)
summary(tree_model)
plot(tree_model)
text(tree_model,pretty = 0)

pred_tree= predict(tree_model,newdata = testIRIS,type = "class")

plot(pred_tree)

table(pred_tree ,testIRIS$Species )
mean(pred_tree == testIRIS$Species )

?cv.tree()
cv_iris=cv.tree(tree_model,FUN = prune.misclass)
cv_iris
plot(cv_iris)
?prune.misclass()
prune_tree_model=prune.misclass(tree_model,best = "4")
plot(prune_tree_model); text(tree_model,pretty = 0)

pred_prunedtree= predict(prune_tree_model,newdata = testIRIS,type = "class")
plot(pred_prunedtree)

table(pred_prunedtree ,testIRIS$Species )


#C4.5
#install.packages("C50")
library("C50")
C50_model<- C5.0(irisr[1:100 , -5] , irisr[1:100, 5])
plot(C50_model)
summary(C50_model)
pred_C50= predict(C50_model, irisr[101:150 ,])
table(pred_C50 ,irisr[101:150 , 5] )
#accuracy
(17+15+16)/50



#rpart
#install.packages("rpart")
#install.packages("rpart.plot")
library("rpart")
library("rpart.plot")

rpart_model <- rpart(Species~. , irisr[1:100,] , method = "class")
rpart.plot(rpart_model)
rpart.plot(rpart_model , type =4  , extra = 101 , fallen.leaves = F)
summary(rpart_model)
pred_rpart = predict(rpart_model , irisr[101:150, ] , type = "class")
table(pred_rpart , irisr[101:150, 5])
 # 
mean(pred_rpart== irisr[101:150 , 5])

#RAndom Forest
