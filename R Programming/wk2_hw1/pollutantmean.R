pollutantmean <- function(directory, pollutant, id = 1:332){

	# 'directory' = character vector for location of csv files
	# 'pollutant' = 'sulfate' or 'nitrate'
	# 'id' = integer array indicating what files to use

	## Return the mean of the pollutant across all ids (ignoring NA values)
	# Add leading zeros to integer ids
	id_num <- sprintf("%03i",id)
	data_c = NULL	

	for(i in 1:length(id_num)){ 	#loop through ids
		#create filename
		filename <- paste(directory,"/",id_num[i],".csv",sep="")

		#read *.csv file
		tmp_data <- read.csv(filename)

		#save applicable column to vector
		if(pollutant=="sulfate") {
			data <- tmp_data$sulfate
		} else if(pollutant=="nitrate"){
			data <- tmp_data$nitrate
		}
		
		#append data to combined vector
		data_c <- c(data_c,data)
	}

	mean(data_c,na.rm = TRUE)


}