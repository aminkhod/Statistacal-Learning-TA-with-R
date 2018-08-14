
library(ISLR)
library(MASS)

?Boston

# Simple linear regression
BostonDataset = Boston 
names(Boston)

plot(medv~lstat,BostonDataset)

fit1 = lm(medv~lstat , data = Boston)
fit1
summary(fit1)
?abline
abline(fit1 , col="red")

names(fit1)
?lm()
confint(fit1)


?predict(fit1,data.frame(lstat=Boston$lstat))

predict(fit1,data.frame(lstat = c(5,10,15)),interval = "confidence")
