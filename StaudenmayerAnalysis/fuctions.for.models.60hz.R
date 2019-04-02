pow.625 <- function(vm)
{
	mods <- Mod(fft(vm))
	mods <- mods[-1]	
	n <- length(mods)
	n <- floor(n/2)
	freq <- 60*(1:n)/(2*n)
	mods <- mods[1:n]
	inds <- (1:n)[(freq>0.6)&(freq<2.5)]
	pow625 <- sum(mods[inds])/sum(mods)
	mods[is.na(mods)] <- 0
	if (sd(vm)==0)
		pow625 <- 0
	return(pow625)
}

dom.freq <- function(vm)
{
	if(length(vm)==1)
		return(NA)
	mods <- Mod(fft(vm))
	mods <- mods[-1]	
	n <- length(mods)
	n <- floor(n/2)
	freq <- 60*(1:n)/(2*n)
	mods <- mods[1:n]
	dom.ind <- which.max(mods)
	d.f <- as.vector(freq[which.max(mods)])
	return(d.f)
}

frac.pow.dom.freq <- function(vm)
{
	mods <- Mod(fft(vm))
	mods <- mods[-1]	
	n <- length(mods)
	n <- floor(n/2)
	freq <- 60*(1:n)/(2*n)
	mods <- mods[1:n]
	rat <- max(mods)/sum(mods)
	mods[is.na(mods)] <- 0
	if (sd(vm)==0)
		rat <- 0
	return(rat)

}

read.act <- function(file.name.and.path)
{
  	head.data <- readLines(paste(file.name.and.path),n=10)
  	start.time <- head.data[3]
  	start.time <- (strsplit(start.time,split=" ")[[1]][3])
  	start.date <- head.data[4]
  	start.date <- (strsplit(start.date,split=" ")[[1]][3])
  	start.time <- as.POSIXlt(strptime(paste(start.date,start.time),"%m/%d/%Y %H:%M:%S"))
  	
  	
  	
	data <- fread(file.name.and.path,skip=11,sep=",",header=F,colClasses=c("numeric","numeric","numeric"),showProgress=FALSE)

	n <- dim(data)[1] # number of rows in data
  	
  	full.data <- 
    	data.frame(time = start.time + (0:(n-1))/60,
            	  data)
  
  	return(full.data)

}

read.act.2 <- function(file.name.and.path,start,stop)
{
  	head.data <- readLines(paste(file.name.and.path),n=10)
  	start.time <- head.data[3]
  	start.time <- (strsplit(start.time,split=" ")[[1]][3])
  	start.date <- head.data[4]
  	start.date <- (strsplit(start.date,split=" ")[[1]][3])
  	start.time <- as.POSIXlt(strptime(paste(start.date,start.time),"%m/%d/%Y %H:%M:%S"))
  	
  	diff.1 <- as.numeric(stop-start)
  	diff.2 <- as.numeric(stop-start.time)
	diff <- min(c(diff.2,diff.1))

	n.to.read <- diff*24*60*60*60
  	
	data <- fread(file.name.and.path,skip=11,sep=",",header=F,colClasses=c("numeric","numeric","numeric"),showProgress=FALSE,nrows=n.to.read)

	n <- dim(data)[1] # number of rows in data
  	
  	full.data <- 
    	data.frame(time = start.time + (0:(n-1))/60,
            	  data)
  
  	return(full.data)

}


read.actigraph.no.var.names <- function(file.name.and.path,start.time="12:00:00",start.date="8/18/2014") # start time & date are just placeholders
{
  # add start time (these could be read from he header automatically)
  start.time <- as.POSIXlt(strptime(paste(start.date,start.time),"%m/%d/%Y %H:%M:%S"))

	# read acceleration data
	data <- read.csv(file.name.and.path,header=F,skip=10)
	
  	n <- dim(data)[1] # number of rows in data
  	full.data <- 
    	data.frame(time = start.time + (0:(n-1))/60,
            	  data)
  
  return(full.data)
}

read.actigraph.with.var.names <- function(file.name.and.path,start.time="12:00:00",start.date="8/18/2014")
{


	# read header and start time
  start.time <- as.POSIXlt(strptime(paste(start.date,start.time),"%m/%d/%Y %H:%M:%S"))

	# read acceleration data
	data <- read.csv(file.name.and.path,header=F,skip=11)
	
  	n <- dim(data)[1] # number of rows in data
  	full.data <- 
    	data.frame(time = start.time + (0:(n-1))/60,
            	  data)
  
  return(full.data)
}
