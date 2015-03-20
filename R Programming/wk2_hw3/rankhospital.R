rankhospital <- function(state, outcome, num = "best") {

	# state = two letter appreviation for US State
	# outcome = 'heart attack', 'heart failure', or 'pneumonia'
	# num = rank of hosiptal for outcome. Lower is better

	## read in data (as character)
	data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

	## Check state
	st_list <- unique(data$State)
	mat <- match(state,st_list)
	if(is.na(mat)) {
		stop("invalid state")
	}

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

	# split data by state
	split_data <- split(data,data$State)
	m_data <- as.data.frame(split_data[state])

	# remove NA rows
	na_vect <- is.na(m_data[,col_num])
	m_data <- m_data[!na_vect,]

	# sort matrix
	m_data <- m_data[order(m_data[,col_num],m_data[,2]),]

	# return name based on num
	if(is.numeric(num)) {
		#is a number, return name for that row
		med_center <- m_data[num,2]
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

	med_center


}