##########################  Packages    ####################################
######## Installing packages and import them to code################
#For viewing packages see packages tab in bottom right section
#For loading a package, choose your considered packages
#For installing a new package, press install Button, then You can choose repository.Repository by default is "Repository CRAN",
##then write the name of packge in the second boox for example "ISLR" then press "install".
#For installing a new package from "Repository CRAN " you need internet coonection.

#install.packages('readxl')# way to install package in the code script
#install.packages('WriteXLS')
library(readxl) # Way to load package in the code script
require(readxl) # Another way to load package in the code script.
#Works same as 'library(readxl)'
library(WriteXLS)
#library(xlsx)

### !!!notice that in addressing the files we should use '/' instead of '\'
t=read.table('student-por.txt',sep =';' ) #to read '.txt' files
View(t)
c=read.csv('Abalone/abalone.data.txt',sep = ',',header = 'Abalone/abalone.names.txt')  #to read '.csv' files
View(c)

values=read_excel("student-mat1.xlsx",sheet = "student-mat1")

#to change directory:
setwd("Put your repository address here")
summary(c$Fedu)
s=c$Fedu/
summary(s)
c$s=s
write.table(c,'normaledstudent.txt') #to write '.txt' files
write.csv(t,'y.csv') #to write '.csv' files

## writing and reading table and csv does not need to load package
## but for excel files we should install and load following packages:

f=write.table(Carseats,'carfile.txt')  #this will create a file in the directory
# f is true if the writing operation is done successfuly and is false otherwise.

g=write.csv()
write.xlsx(values,file = "js.xlsx",sheetName = 'sheet1',col.names = TRUE, row.names = TRUE)
