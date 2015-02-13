corr <- function(directory, threshold = 0){

	# 'directory' = character vector for location of csv files
	# 'threshold' = numeric vector for the num of complete obs 
	# required to compute correlatetion btw nitrate and sulfate

	## Return numeric vector of correlations
	# Call complete function
	sink("unwanteddata.txt")	#supress complete function output
	arrComp <- complete(directory)
	sink()				#unsuppress output

	# Find entries above threshold
	thres <- arrComp[,2]>=threshold
	arrComp_thres <- arrComp[thres,]

	num_ent <- nrow(arrComp_thres)

	arrCorr <- vector(mode = "numeric",length=0)
	
	k <- 0

	#Check for case of num_ent = 0
	if(num_ent == 0) {
		# Do nothing
		arrCorr <- vector(mode = "numeric",length=0)
	} else {
		# for each file, calculate cor between sulfate & nitrate 

		for(i in 1:num_ent){
			if(arrComp_thres[i,2]==0){	#if num_matches is zero, skip
				#do nothing
			} else {
				k <- k+1
				# Add leading zeros to integer ids
				id_num <- sprintf("%03i",arrComp_thres[i,1])
		
				#create filename
				filename <- paste(directory,"/",id_num,".csv",sep="")

				#read *.csv file
				tmp_data <- read.csv(filename)

				#determine number of complete entries
				good <- complete.cases(tmp_data)
				data <- tmp_data[good,]

				data_1 <- data$sulfate
				data_2 <- data$nitrate

				arrCorr[k] <- cor(data_1,data_2)
			}
		}
	}

	arrCorr
}