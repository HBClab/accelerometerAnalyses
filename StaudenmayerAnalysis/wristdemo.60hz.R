# batch mode for left/right wrist @60hz
#modified by Rachel Clark, 12/14/15

# comments start with # sign
## double pound sign to mark original code

rm(list=ls())     	# clear work space

# load needed R libraries  (previously installed)
library(tree)
library(randomForest)
library(data.table)     # this library helps load big datasets faster (it's great)

# Show installed libraries
ip <- as.data.frame(installed.packages()[,c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority),1:2,drop=FALSE]
print(ip, row.names=FALSE)

# setwd sets working directory for your programs and data files
setwd("/Volumes/VossLab/Accelerometer/ActiGraph/Analysis/60hz")
getwd()    # show wd to confirm

# read csv file with filenames, date(s) & time(s) on/off
st= read.csv("specs.csv", header=TRUE, sep=',', stringsAsFactors= FALSE)
#st$start <- strptime(st$start,format="%d-%b-%Y %I:%M %p")
#st$stop  <- strptime(st$stop, format="%d-%b-%Y %I:%M %p")
print(st)
str(st)

# these are the models from the paper
load("mods.RData")

# these are functions to estimate features, load data, etclis
source("fuctions.for.models.60hz.R")

win.width <- 60     # width of "windows" to analyze in seconds aka EPOCH

#start of function to run in batch mode - similar to Macro in SAS
main <- function(id, file.1, start, stop, outfile) {
  # convert strings to datetime format
  start <- strptime(start,format="%d-%b-%Y %I:%M %p")
  stop  <- strptime(stop, format="%d-%b-%Y %I:%M %p")
  str(id)
  str(file.1)
  str(start)
  str(stop)
  str(outfile)
  # get start time & start date from csv file header section
  hertz = 60
  head.data <- readLines(paste(file.1),n=10)
  start.time <- head.data[3]
  start.time <- (strsplit(start.time,split=" ")[[1]][3])
  start.date <- head.data[4]
  start.date <- (strsplit(start.date,split=" ")[[1]][3])
  start.time <- as.POSIXlt(strptime(paste(start.date,start.time),"%m/%d/%Y %H:%M:%S"))
  n.to.skip = as.numeric(difftime(start,start.time,units="secs")*hertz)
  n.to.read = as.numeric(difftime(stop,start,units="secs")*hertz)
  # change fread data to ag.data as it is just duplicated later on for no reason (inefficient and memory hog)
  ##data <- fread(file.1,skip=10+n.to.skip,sep=",",header=F,colClasses=c("numeric","numeric","numeric"),showProgress=FALSE,nrows=n.to.read)
  ag.data <- fread(file.1,skip=10+n.to.skip,sep=",",header=F,colClasses=c("numeric","numeric","numeric"),showProgress=FALSE,nrows=n.to.read)
  n <- dim(ag.data)[1]
  # orignal line copys entire vector to new vector - memory hog
  ##ag.data <- data.frame(time = start + (0:(n-1))/hertz,data)
  # data.frame adds a new column with times
  ag.data <- data.frame(time = start + (0:(n-1))/hertz,ag.data)
  n <- dim(ag.data)[1]
  mins <- ceiling(n/(60*win.width)) 

  # compute statistics (features)
  ag.data$min <- rep(1:mins,each=win.width*60)[1:n]
  ag.data$vm <- sqrt(ag.data$V1^2+ag.data$V2^2+ag.data$V3^2)
  ag.data$v.ang <- 90*(asin(ag.data$V1/ag.data$vm)/(pi/2))
  ag.data.sum <- data.frame(mean.vm=tapply(ag.data$vm,ag.data$min,mean,na.rm=T),
  sd.vm=tapply(ag.data$vm,ag.data$min,sd,na.rm=T),
  mean.ang=tapply(ag.data$v.ang,ag.data$min,mean,na.rm=T),
  sd.ang=tapply(ag.data$v.ang,ag.data$min,sd,na.rm=T),
  p625=tapply(ag.data$vm,ag.data$min,pow.625),
  dfreq=tapply(ag.data$vm,ag.data$min,dom.freq),
  ratio.df=tapply(ag.data$vm,ag.data$min,frac.pow.dom.freq))

  # Next line can be slow... (there is a faster library, but I haven't implemented it yet.)
  ag.data.sum$start.time <- as.POSIXlt(tapply(ag.data$time,ag.data$min,min,na.rm=T),origin="1970-01-01 00:00.00 UTC")

  # apply the models (estimates are for each 15 second epoch)

  # MET estimates by random forest
  ag.data.sum$METs.rf <- predict(rf.met.model,newdata=ag.data.sum)
  ag.data.sum$METs.rf[ag.data.sum$sd.vm==0] <- 1

  # MET estimates by linear regression
  ag.data.sum$METs.lm <- predict(lm.met.model,newdata=ag.data.sum)
  ag.data.sum$METs.lm[ag.data.sum$sd.vm==0] <- 1

  # MET level estimates (rf and tree)
  ag.data.sum$MET.lev.rf <- predict(rf.met.level.model,newdata=ag.data.sum)
  ag.data.sum$MET.lev.tr <- predict(tr.met.level.model,newdata=ag.data.sum,type="class")

  # sedentary or not estimates (rf and tree)
  ag.data.sum$sed.rf <- predict(rf.sed.model,newdata=ag.data.sum)
  ag.data.sum$sed.tr <- predict(tr.sed.model,newdata=ag.data.sum,type="class")

  # locomotion or not estimates (rf and tree)
  ag.data.sum$loc.rf <- predict(rf.loc.model,newdata=ag.data.sum)
  ag.data.sum$loc.tr <- predict(tr.loc.model,newdata=ag.data.sum,type="class")

  # end of calculations
  print("Done with calculations")
  # export entire results vector (array) to .csv text file
  write.csv(ag.data.sum,outfile, row.names=FALSE, quote=FALSE)

# end of main function
}

# call function, args are by position, call by value in R
mapply(main, st$Id, st$file.1, st$start, st$stop, st$outfile)


# end of program
