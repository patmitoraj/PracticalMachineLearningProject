download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv",
                            destfile="C:\\Users\\Pat Mitoraj\\Documents\\R Programming Course\\Practical Machine Learning\\Course Project")
download.file("https://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv",
                            destfile="C:\\Users\\Pat Mitoraj\\Documents\\R Programming Course\\Practical Machine Learning\\Course Project")
training<-read.csv(".\\Documents\\R Programming Course\\Practical Machine Learning\\Course Project\\pml-training.csv")
testing<-read.csv(".\\Documents\\R Programming Course\\Practical Machine Learning\\Course Project\\pml-testing.csv")
library(caret)
library(kernlab)
ncol(training)
ncol(testing)
summary(training)
training<-training[,-c(1:7,12:16,19,22,25,69:74,87:92,95,98,101,125:130,133,136,139)]
training<-training[,-c(5:21,35:44,54:62,66:71,73:82,95:100,102:111)]
summary(training)
testing<-testing[,-c(1:7,12:16,19,22,25,69:74,87:92,95,98,101,125:130,133,136,139)]
testing<-testing[,-c(5:21,35:44,54:62,66:71,73:82,95:100,102:111)]
train_control <- trainControl(method="cv", number=10, savePredictions = TRUE)
M<-abs(cor(training[,-53]))
diag(M)<-0
which(M>.8,arr.ind=T)
set.seed(2323)
modFit<-train(classe~.,training,method="rf",preProcess=c("pca"),
              trControl=train_control)
getTrainPerf(modFit)
predictions<-predict(modFit,testing)
predictions