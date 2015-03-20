complete <- function(directory, id = 1:332){
	# 'directory' = character vector for location of csv files
	# 'id' = integer array indicating what files to use

	##Calculate nobs per file
	# Add leading zeros to integer ids
	id_num <- sprintf("%03i",id)
	data_c = NULL	
	tab_out <- matrix(nrow = length(id_num),ncol = 2)
	tab_rn <- 1:length(id_num)

	#tab_out[1,1] = "
	#tab_out[1,2]

	for(i in 1:length(id_num)){ 	#loop through ids
		#create filename
		filename <- paste(directory,"/",id_num[i],".csv",sep="")

		#read *.csv file
		tmp_data <- read.csv(filename)

		#determine number of complete entries
		good <- complete.cases(tmp_data)

		tab_out[i,1] <- id[i]
		tab_out[i,2] <- nrow(tmp_data[good,])
	
	}
	
	colnames(tab_out) <- c("id","nobs")
	rownames(tab_out) <- tab_rn

	tab_out_df <-as.data.frame(tab_out)

	tab_out_df
}