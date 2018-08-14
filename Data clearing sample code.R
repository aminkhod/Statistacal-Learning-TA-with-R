#install.packages('readxl') # CRAN version
#install.packages('WriteXLS')
#install.packages('e1071')
library(e1071)
require(readxl)
library(WriteXLS)
#----Reading Dataset----
#GAP_saccade=read_excel('khodamoradi/overlap/GAP_saccade.xlsx' ,sheet = "GAP saccade" )
GAP_saccade=read.csv('GAP saccade1.csv',sep =",")
# removing missing values in end of data.(removed row = 8980)

GAP_saccade=GAP_saccade[-c(10145:18924),]

#==Just number 1 of all trials (removed rows=5823)
GAP_saccade= GAP_saccade[GAP_saccade$Number==1,]

#=====Compute Sacade Amplitude=====
x1 = GAP_saccade$StartPosition.X
y1 = GAP_saccade$StartPosition.Y
x2 = GAP_saccade$EndPosition.X
y2 = GAP_saccade$EndPosition.Y
z2=(x2-x1)/sqrt((y2-y1)^2+(x2-x1)^2)
summary(z2)
z=acos(z2)
summary(z)
amplitude = 180*z/pi
#amplitude = amplitude%%180

summary(amplitude)
GAP_saccade$`Amplitude [F]` = amplitude

#removing NAN rows(removed rows=2)
na=is.na(GAP_saccade$`Amplitude [F]`)
z= c(0,0)
c=1
summary(GAP_saccade$`Amplitude [F]`)
summary(na)
for(i in 1:length(na)){
  if(na[i]==TRUE){
    z[c]=i
    c=c+1
  }
}
GAP_saccade=GAP_saccade[-c(z[1],z[2]),]

#=======Compute Direction=======
Direction=0
for(i in 1:length(GAP_saccade$`Amplitude [F]`)){
  if(GAP_saccade$`Amplitude [F]`[i]>90)
    Direction[i] = 1
  if(GAP_saccade$`Amplitude [F]`[i]<90)
    Direction[i] = 0
}
GAP_saccade$Direction = Direction

#=====Compute Sacade Length=====we got error
sacad_length = sqrt((GAP_saccade$EndPosition.Y-GAP_saccade$StartPosition.Y)^2+(GAP_saccade$EndPosition.X-GAP_saccade$StartPosition.X)^2)
GAP_saccade$sacad_length = sacad_length

#we need to know how should compute velocity
#=========Compute velocity=========
GAP_saccade$Velocity..Average..F.s. =
  ((GAP_saccade$Amplitude..F.%%90)*1000) / GAP_saccade$Saccade.Duration..ms.

#= We just use amplitudes as this fomula ((3<amp<45) or (135<amp177)
#(removed rows = 2741 66% so much!!!)
GAP_saccade = GAP_saccade[
((GAP_saccade$Amplitude..F. >=0) &
  GAP_saccade$Amplitude..F. <=45|
 (GAP_saccade$Amplitude..F. >= 135 &
  GAP_saccade$Amplitude..F. <=180)),]

#==saccade latency >80 (removed rows = 110)
GAP_saccade = GAP_saccade[
  (GAP_saccade$Saccade.Start..ms. >= 80),]

#velocity<30 latency< 80 (removed rows = 908 71% so much again!!!)
GAP_saccade = GAP_saccade[
  (GAP_saccade$Velocity..Average..F.s.>=30 ),]

#===compute Gain and adding gain column to data===
#amplitude y = 49
Gain = GAP_saccade$Amplitude..F./10
GAP_saccade$Gain = Gain

#===classification====

attach(GAP_saccade)
#GAP_saccade$code=factor(GAP_saccade$code)
set.seed(123)
index <- sample(1:nrow(GAP_saccade), nrow(GAP_saccade)/10)
train=GAP_saccade[-index,]

test=GAP_saccade[index,]
m <- svm(train$code~Saccade.Start..ms.+Velocity..Average..F.s.+
           Gain+Saccade.Duration..ms.+Direction+
           sacad_length , data = train)
pred <- predict(m, test, decision.values = TRUE, probability = TRUE)
plot( data=train, code ~ Amplitude..F.)
plot(m$fitted, data=train )

install.packages('leaps')
library(leaps)
?regsubsets()
regsubsets.out <-
  regsubsets(train$code~Saccade.Start..ms.+Velocity..Average..F.s.+
               Gain+Saccade.Duration..ms.+Direction+
               sacad_length ,
             data = train,
             nbest = 1,       # 1 best model for each number of predictors
             nvmax = NULL,    # NULL for no limit on number of variables
             force.in = NULL, force.out = NULL,
             method = "exhaustive")
 summary(regsubsets.out)
as.data.frame(summary.out$outmat)

mf=1
m3=0
m2=0
m1=0
for(i in 1:length(pred)){
  if(pred[i]>=2.5){
  mf[i]=3
  m3=m3+1
}
  if((pred[i]>=1.5 && pred[i]<2.5)){
    mf[i]=2
    m2=m2+1
}
  if(pred[i]<1.5){
 mf[i]=1
 m1=m1+1
  }
}

table(mf,test$code)
mean(mf==test$code)

#===Wtite first version===
setwd("neuroscience/khodamoradi/overlap/")
f=WriteXLS(GAP_saccade,"GAP saccade1.xlsx")
