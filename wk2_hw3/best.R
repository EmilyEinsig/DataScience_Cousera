best <- function(state, outcome){
	# state = two letter appreviation for US State
	# Outcome = 'heart attack', 'heart failure', or 'pneumonia'

	## read in data (as character)
	data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

	## Check state
	st_list <- unique(data$State)
	mat <- match(state,st_list)
	
	if(is.na(mat)) {
		stop("invalid state")
	}

	## covert data to numeric & Check outcome
	if(outcome == "heart attack") {
		data[,11] <- suppressWarnings(as.numeric(data[,11]))
	} else if(outcome == "heart failure") {
		data[,17] <- suppressWarnings(as.numeric(data[,17]))
	} else if(outcome == "pneumonia") {
		data[,23] <- suppressWarnings(as.numeric(data[,23]))
	} else {
		# Check that outcome is valid
		stop("invalid outcome")
	}

	# split data by state
	split_data <- split(data,data$State)

	m_data <- as.data.frame(split_data[state])

	
	# determine column number to search
	col_num <- NULL
	if(outcome == "heart attack") {
		col_num <- 11
	} else if(outcome == "heart failure") {
		col_num <- 17
	} else if(outcome == "pneumonia") {
		col_num <- 23
	}

	# remove NA rows
	na_vect <- is.na(m_data[,col_num])
	m_data <- m_data[!na_vect,]

	# Search for position of smallest mortality values
	pos_min <- which(m_data[,col_num] == min(m_data[,col_num]))

	if(length(pos_min) == 1) {
		#only one match found, return that name
		med_center <- m_data[pos_min,2]
	} else {
		# more than one match found. Need to find first one alphabetically
		name_list <- m_data[pos_min,2]
	
		# sort list $ return first value
		name_list_sort <- sort(name_list)
		
		med_center <- name_list_sort[1]
	}

	med_center	

}