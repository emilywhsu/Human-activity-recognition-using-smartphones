setwd("/Users/emilyhsu/CourseEra/")
library(data.table)
fileurl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destination<-"getdata_Dataset.zip"
download.file(fileurl,destfile=destination,method="curl")
unzip("getdata_Dataset.zip")

testx<-read.table("/Users/emilyhsu/CourseEra/UCI HAR Dataset/test/X_test.txt")
testy<-read.table("/Users/emilyhsu/CourseEra/UCI HAR Dataset/test/y_test.txt")
testsubject<-read.table("/Users/emilyhsu/CourseEra/UCI HAR Dataset/test/subject_test.txt")
trainx<-read.table("/Users/emilyhsu/CourseEra/UCI HAR Dataset/train/X_train.txt")
trainy<-read.table("/Users/emilyhsu/CourseEra/UCI HAR Dataset/train/y_train.txt")
trainsubject<-read.table("/Users/emilyhsu/CourseEra/UCI HAR Dataset/train/subject_train.txt")

activity<-read.table("/Users/emilyhsu/CourseEra/UCI HAR Dataset/activity_labels.txt",colClasses="character")
features<-read.table("/Users/emilyhsu/CourseEra/UCI HAR Dataset/features.txt",colClasses="character")
testy$V1<-factor(testy$V1,levels=activity$V1,labels=activity$V2)
trainy$V1<-factor(trainy$V1,levels=activity$V1,labels=activity$V2)
colnames(testx)<-features$V2
colnames(trainx)<-features$V2
colnames(testy)<-c("Activity")
colnames(trainy)<-c("Activity")
colnames(testsubject)<-c("Subject")
colnames(trainsubject)<-c("Subject")

testdata<-cbind(testx,testy)
testdata<-cbind(testdata,testsubject)
traindata<-cbind(trainx,trainy)
traindata<-cbind(traindata,trainsubject)
overallData<-rbind(testdata,traindata)
overallDatamean<-sapply(overallData,mean)
overallDatastandard<-sapply(overallData,sd)

dataset<-data.table(overallData)
dataset<-dataset[,lapply(.SD,mean),by="Activity,Subject"]
write.table(dataset,file="variable_average.txt",sep=",",row.names=FALSE)
