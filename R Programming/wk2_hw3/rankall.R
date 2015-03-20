rankall <- function(outcome, num = "best") {

	# outcome = 'heart attack', 'heart failure', or 'pneumonia'
	# num = rank of hosiptal for outcome. Lower is better

	## read in data (as character)
	data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

	## create state list
	st_list <- unique(data$State)
	n_st <- length(st_list)


	## assign col_num, covert data to numeric, & Check outcome
	col_num <- NULL
	if(outcome == "heart attack") {
		col_num <- 11
	} else if(outcome == "heart failure") {
		col_num <- 17
	} else if(outcome == "pneumonia") {
		col_num <- 23
	} else {
		# Check that outcome is valid
		stop("invalid outcome")
	}
	data[,col_num] <- suppressWarnings(as.numeric(data[,col_num]))

	# initialize vectors
	v_name <- vector("numeric",length = n_st)
	v_state <- vector("character",length = n_st)

	# split data by state
	split_data <- split(data,data$State)

	#loop through data frames for each state
	for(i in 1:n_st){
		m_data <- as.data.frame(split_data[st_list[i]])

		# remove NA rows
		na_vect <- is.na(m_data[,col_num])
		m_data <- m_data[!na_vect,]

		# sort matrix
		m_data <- m_data[order(m_data[,col_num],m_data[,2]),]

		# return name based on num
		if(is.numeric(num)) {
			#is a number, return name for that row if able
			if(num > nrow(m_data)) {
				# rank bigger than list, return NA
				med_center <- NA
			} else {
				# rank is apporpriate, return value
				med_center <- m_data[num,2]
			}
		} else if(num == "best") {
			#want best center, return first row
			med_center <- m_data[1,2]
		} else if (num == "worst") {
			#want last row
			last_row <- nrow(m_data)
			med_center <- m_data[last_row,2]
		} else {
			# error, return NA
			med_center <- NA
		}
	
	v_name[i] <- med_center
	v_state[i] <- st_list[i]

	}

	df_out <- data.frame(v_name,v_state)
	colnames(df_out) <- c("hospital","state")
	rownames(df_out) <- v_state


	df_out <- df_out[order(df_out$state),]


}