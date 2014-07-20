if(!file.exists('s3.zip') & !file.exists('UCI HAR Datast')){
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip','s3.zip')
}
if(!file.exists('UCI HAR Dataset')){
  unzip('s3.zip')
}
#features to column labels:
feat=read.delim('UCI HAR Dataset//features.txt',strings=F,head=F)
cnames=make.names(sub('^\\d+ ','',feat[,1]))
cnames=sub('[.]{2,}','.',cnames)

#test features (x) and targets (y)
testx=read.table('UCI HAR Dataset//test//X_test.txt',head=F)
testy=read.table('UCI HAR Dataset//test//y_test.txt',head=F)
tests=read.table('UCI HAR Dataset//test//subject_test.txt',head=F)

#train features (x) and targets (y)
trainx=read.table('UCI HAR Dataset//train//X_train.txt',head=F)
trainy=read.table('UCI HAR Dataset//train//y_train.txt',head=F)
trains=read.table('UCI HAR Dataset//train//subject_train.txt',head=F)

#merge test and train

colnames(testx)=colnames(trainx)=cnames
x=rbind(testx,trainx)
y=rbind(testy,trainy)
s=rbind(tests,trains)

#subset columns to mean and sd only
mnsd=grepl('(mean\\(\\))|(std\\(\\))',feat[,1])
xsub=x[,mnsd]

#activity labels:
acts=read.table('UCI HAR Dataset//activity_labels.txt',strings=F,head=F)
ystr=acts[y[,1],2]

#tidy yet?
sum(is.na(x))

#'tidy' dataset with mean and sd feature, concatenated with target activtity (activity) and subject as first two columns
dat=cbind(ystr,s,xsub)
colnames(dat)[1:2]=c('activity','subject')
write.table(dat,file='tidy.txt',sep='\t',quote=F,row.names=F)

#summarize data by mean of activity & subject
library(data.table)
dt=data.table(dat)
setkeyv(dt,c('activity','subject'))
mndt=dt[,lapply(.SD,mean),by=key(dt)]
write.table(mndt,file='tidy_means.txt',sep='\t',quote=F,row.names=F)