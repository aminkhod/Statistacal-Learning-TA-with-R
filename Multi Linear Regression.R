#install.packages('ISLR')
#install.packages('MASS')

library(ISLR)
library(MASS)


#Multiple linear regression
fit1= lm(medv~lstat, data = Boston)
summary(fit1)

fit2= lm(medv~lstat+age,data = Boston)

summary(fit2)

names(Boston)

fit3= lm(medv~.,data = Boston)

summary(fit3)

par(mfrow=c(2,2))

# Ei vs Yi
plot(fit3)

par(mfrow= c(1,1))

?update()
fit4 = update(fit3,Boston$crim~.-crim+medv- age-chas)
summary(fit4)

fit5=lm(medv~lstat*age ,data = Boston)
summary(fit5)

fit51=lm(medv~lstat:age ,data = Boston)
summary(fit51)
bos=Boston
intract=bos$lstat*bos$age
plot(medv~intract,data = Boston)
abline(fit51,Boston,col="red")

points(intract,fitted(fit5),col="blue")

fit52=lm(medv~lstat^2 ,data = Boston)
summary(fit52)

I(c(2,3,3,6))
?I()

fit6 = lm(medv~lstat + I(lstat^2) ,Boston)
summary(fit6)

plot(medv~lstat,Boston)
points(Boston$lstat,fitted(fit6),col="red",pch=20,cex=1)

attach(Boston)

b=poly(Boston$lstat,4)
b

#pch
plot(1:20,1:20 ,pch=1:20 ,cex=3)

#d= Boston

par(mfrow=c(1,1))
plot(medv~lstat)
points(lstat,fitted(fit6),col="red",pch=20,cex=3)

fit7 = lm(medv~poly(lstat,2) )
summary(fit7)

points(lstat,fitted(fit7),col="blue",pch=20, cex=2)

#Qualitative predictators
?Carseats
fix(Carseats)
View(Carseats)
names(Carseats)
summary(Carseats)

plot(Carseats$Sales~.,Carseats)

attach(Carseats)

fit8= lm(Sales~.+Income:Advertising+Age:Price,data=Carseats)
summary(fit8)

fit9= lm(Sales~+Income*Advertising+Age*Price)
summary(fit9)

contrasts(Carseats$ShelveLoc)

par(mfrow = c(2,2))
plot(Sales~ .,Carseats)
pairs(Carseats)

par(mfrow = c(1,1))

#writting R functions
regplot1 = function(x,y){
  fit = lm(y~x)
  plot(x,y)
  abline(fit,col= "green")
}


regplot1(Price , Sales)


regplot2 = function(x,y ,...){
  fit = lm(y~x)
  plot(x,y ,...)
  abline(fit,col= "blue")
}

regplot2(Price,Sales,ylab="Sale",xlab="Price",col="black",pch=4)

