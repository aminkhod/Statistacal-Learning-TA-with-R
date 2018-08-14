1+2 #press ctrl+enter when curor is on the head of line to run that line
(5*6/12)+8+sin(3)
mysr='hello' ## there is no difference between " and '   
## there is no need to define the type of a variable
5->x  # the operator "<-" and "->" and "=" works as the same
x<-4   # the priority of the operatorss "->" and "<-" are higher than "="
x=6
x
print(x)
cat(x,mysr)   # execting these three lines have the same output when you ask to print a varaible
# But when you want to print two variables with different type at the same time, you should use "cat"


############# Data Types #######################
x1=T
print(class(x1))
class(x1)

x2=12.5
class(x2)

x3=6L  # we should add "L" to the end of a number to define that it is an "integer", otherwise R consider it as "numeric" type.
class(x3)
x3

x4=2+3i
class(x4)

x5='csfdhar'
x5
class(x5)
x6="csfdhardh"
x6
class(x6)

x7=charToRaw('jdfv')  # it turns to its ascii code
class(x7)  # the type of Ascii code in R is "raw"
x7 #It shows Ascii code in 16-bit form, so a represents 10, b represents 11, etc.

x7=4
class(x7) # Type of a variable changes automatically by assigning

################ Data Structures ###############
#for removing a variable from environment use rm(variableName)

ls() #this returns all defined variables
rm(list=ls())

x=c("jsygf0",1,2,3)
x1=c(1,2,3) #use "c" function for constructing vector
class(x)
class(x1)

#vector
v=c(1,2,3)
v
v3=c(2:4)
v[2]
class(v[1])

w=c('s',1,TRUE) #its elements can be with different types
class(w)
w[1]

#list:
q=list(123,c(3,2,56),45,'yt',c(234,2,4,57,7)) #use "list" function for constructing list 
class(q)
##its elements can be vectors with different types and differnet size

q[[1]] # for accesing to a row of list
q[[2]]# for accesing to an element of list
q[[2]][3]
q[[4]][1]
q[[4]][2]

m=matrix(1:6,nrow=3,ncol=2,byrow=TRUE) 
m
n=matrix(1:6,nrow=3,ncol=2,byrow=FALSE)
n
b=matrix(1:6,nrow=3,ncol=2)
b

o=matrix(c(234,57,7,'s',1,TRUE),nrow=3,ncol=2,byrow=TRUE)
o
class(o)

o[1,2]
class(o[1,1])

#vectors are 1 dimensional
#lists and matrices are 2 dimentional
#arrays can be with higher dimensions


b=array(1:72,dim=c(2,3,4))
b


k=c(1,2,3,5,4,3,2,4,5,3,2,4,5)
k
k_factor=factor(k) #same as "unique func in Matlab
k_factor
nlevels(k_factor)
nlevels(k)
?nlevels # for giving help about functions,data, packages,etc. type "?" before its name
#Another example with character
ca <-c('red','blue','blue','green','red','blue','green','yellow','blue')
cafactor=factor(ca)
cafactor
nlevels(cafactor)


bmi=data.frame(
  age=c(14,20,40),
  gender=c('female','male','female'),
  height=c(150,180,175)
) # use dataframe for data with multiple features. each feature will show in a column. The size of columns should be the same.
View(bmi)
bmi
bmi$age  # for returning a column of dataframe
bmi$age[1] # for returning an element of dataframe

#press tab when typing a prefix of some command to complete it automatically

v1=c(1,34,4)
v3=c(1:3)
v3


#################################### Some math functions ########################
v1%%v3  #gives the mod(v1[i],v3[i])
v1%/%v3  #divide each elemnts of v1 to the elemnts of v3 and gives the floor of it
v4=c(23,0,45)
v1&v4 #calculate "and" of each elements
v1|v4
v1&&v4
v1||v4
5%in%v1
34%in%v1  #tells you wether there is ann element "34" is in v1 

v1%in%34

20%in%bmi  # An incorrect command for data structures
20%in%bmi$age  

v5=v1%*%v3  # An incorrect command for vector multiplication
class(v5)

v6=v1%*%t(v3)  # for vector or matrix multiplication. their dimention should agree
v6
class(v6)

#####################################loops################################################

if(T){}

for(i in 1:6){
  print(i)
  }

while(T){}
break()

repeat(
  next()
  break()
)  # it repeat its inner commands until it sees a break command
#break() will stop the execution of loop
#next will execute the next run of loop
#break()



########################################  Plot and histogram  ###########################

a=0 #just for defining "a"
for (i in 1:1000){
  a[i]=mean(runif(50,min=0,max=1)) # produce 1000 sample set each with 50 numbers unformly random from [0,1] interval
}
plot(a)  # place a dot for data in "a"
hist(a)   #draw a histogram for data 
#it partition the data in "a" by default intervals. To alter the intervals press ?hist to give help.
b=mean(a)  # the mean value of numbers in "a"
b
c=var(a)  #the variance of numbers in "a"
c
d=density(a)
plot(d)
polygon(d, col='red',border='blue')  # after drawing plot one can use polygon for adjusting colors of area and border line
