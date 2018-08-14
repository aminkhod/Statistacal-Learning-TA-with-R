
##################### Change R's prompt#######################
?option()
options(prompt = ">SBU:")

############################ Plot continue #############################
plot(1:20,1:20,pch=1:20,cex=3)  # plots y=x for x in (1,20) and y in (1,20) with multiple signs for points
#pch:(sign codes in range(1,20)  for example: 1 stands for circle, 2 means triangle,...
#cex: and size of each sign is 3)

plot(1:20,1:20,pch=2,cex=5,col='red') # Put red triangle for each point
polygon(1:20,1:20,border='blue') #Sometimes comes with plot command, this command draw a line in addition to points.


################################## function ########################################
#f=function("argument1,argument2,..,argumentn"){ Some code to write here }
f1=function(a,d){
  j=c(a*d,a-d) #for returning multiple variables
  return(j)
}

f1(1,24)

f2=function(a,d,b=3){ #for having arbitrary inputs use 
  j=c(a*b,a-d) 
  
  return(j)
}

f2(1,234,4)
f2(3,5)

f4=function(y,x){
    y=2*y
    x=(x-4)
    plot(x,y)
}

y=1:50
x=19:68 
f4(y,x)


f5=function(y,x,xlab = 'x',ylab='y',pch=16,cex=1,col='black'){
  plot(x,y,xlab = xlab, ylab=ylab, pch=pch, cex=cex, col=col)
}

f5(x,y, xlab = 'gg')
f5(x,y, xlab = 'rate',ylab='salary',pch=6,cex=3,col='red')

#Tamrin: fibonachi function stream
#khodamoradi1992@gmail.com subject: E.SAT96-97(fibonachi)
#telegram: @amin92kh
