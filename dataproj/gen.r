# Implement Pi chart
#Possibly increase categories and create subcatagory
# Print several individual graphs
# Weekly and monthly report (why?)
# List of transactions
#Print the main in plot
# What day of week is usual for grocery shopping?
# Better png generation, accommodting
# SHould I order data with date before printing or is it automatic?

library(colorspace)
## Collect arguments
args <- commandArgs(TRUE)
 

filename <- "tran.csv"

# Weekly data or monthly data
timespan <- "week"
# legend format
legformat <- "%b %d"
# Plot side by side or not
besideval <- FALSE
# Exclude variable
excludevar <- c("Income","Bill")
# Include variable
includevar <- vector()
# budget line
addline <- FALSE
# Show number on top of bars
shownum <- FALSE
# Single person mode
singleperson <- FALSE
# Manysum !!
manysum <- FALSE
# Current week/month/week
current <- FALSE
# From a specific date
fromdate <- 0
# Populate data with empty values
populate <- FALSE


# many user mode
manyuser <- FALSE

if(length(args) !=0){
	#args conditions
	if("month" %in% args){
		timespan <- "month"
		legformat <- "%y %b"
	}
	if("year" %in% args){
		timespan <- "year"
		legformat <- "%y"
	}
	if("day" %in% args){
		timespan <- "day"
		legformat <- "%b %d"
	}
	if("beside" %in% args){
		besideval <- TRUE
	}
	if("budget" %in% args){
		addline <- TRUE
		bamount <- as.numeric(c(args[match("budget",args)+1]))
		# If the string after budget is non-numeric, set is to default value

		if ( (is.numeric(bamount) == FALSE) || is.na(bamount) ){
			bamount <- 100
		}	
	}
	if("no" %in% args){
		# match(vector, string) returns only FIRST matching place
		# which( string %in% vector) returns all, order of writing is opposite
		excludevar <- c(args[which(args %in% "no")+1])
	}
	# Only has precedence over no
	if("only" %in% args){
		# match(vector, string) returns only FIRST matching place
		# which( string %in% vector) returns all, order of writing is opposite
		includevar <- c(args[which(args %in% "only")+1])
	}
	if("person" %in% args){
		# A category name must follow after person
		personname <- c(args[match("person",args)+1])
		singleperson <- TRUE
	}
	if("manyuser" %in% args){ 	# Only one category for 2people
		manypcat <- c(args[match("manyuser",args)+1])
		manyuser <- TRUE
	}
	if("manysum" %in% args){ 	# Only one category for 2people
		manysum <- TRUE	
	}
	if("number" %in% args){
		shownum <- TRUE
	}

	if("this" %in% args){
		current <- TRUE
		thisspan <- c(args[match("this",args)+1])
	}
	if("from" %in% args){
		startingdate <- TRUE
		fromdate <- c(args[match("from",args)+1])
		today <- Sys.Date()
		if(fromdate == "thisweek"){
			fromdate <- cut(today, breaks="week")
		} else if ( fromdate == "thismonth"){
			fromdate <- cut(today, breaks="month")
		} else if ( fromdate == "thisyear"){
			fromdate <- cut(today, breaks="year")
		} 
		# cut gives you a data, not a date, so we need to convert
		fromdate <- as.Date(fromdate, format="%Y-%m-%d")

		fromdate
	}
	if("populate" %in% args){
				populate <- TRUE
	}




}

# Reading csv files
tran <- read.csv(filename, header=TRUE)

# Converting strings to dates if the format is known
# the default format of as.Date is "%Y-%m-%d"
tran$Date <- as.Date(tran$Date, format = "%Y-%m-%d")

# Applying date filter if any
if( fromdate > 0){	# works but need a better comparison 
	tran <- subset(tran, Date >= fromdate)
}


# handling empty data
# Might appear somewhere else
# Need better handling
if (nrow(tran) == 0){
	stop("empty dataset")
	## should be starting date though
	#tran["Date"][1,1] <- Sys.Date()
	#tran[is.na(tran)] <- 0

}



# Most crucial step: assigning Month, Week etc to the data by crating a new frame variable
tran$timeS <- as.Date(cut(tran$Date, breaks = timespan))
sprintf("hi")

# cats is the name of all categories
cats <- levels(tran$Category)

# If there are variables to exclude or include
if("only" %in% args){
	excludevar <- setdiff(cats,includevar)
}
cats <- setdiff(cats,excludevar)

#color choosing
cols <- rainbow_hcl(length(cats))


# According to http://stackoverflow.com/questions/17075529/subset-based-on-variable-column-name
#subset(data, frame_var == "string") is useless because frame_var cannot be used as a variable.
# So, use the matrix-like extraction technique, where frame_var is a variable now, maybe a string
# data[data[,frame_var] == 'string',]


# If a person is specified
if(singleperson){
	# Change Transaction.Type to Person
	tran <- subset(tran, Transaction.Type == personname)
}

# Suspend this functionality for now
if(manyuser){
	# reducing the data to a single category
	tran <- subset(tran, Category == manypcat)
	# Change Transaction.Type to Person
	# cats will now contain all the names of users
	cats <- levels(tran$Transaction.Type)
}


if(manysum){
	# Change Transaction.Type to Person
	userlist <- levels(tran$Transaction.Type)
	k = 0
	for (user in userlist){
		j = 0
		for(catname in cats){
			# create len(userlist) tables, which is 2
			tmp <- subset(tran, Category == catname)
			tmp <- subset(tran, Transaction.Type == user)
			# Picking the columns matching Amount and Week 
			tmp <- tmp[names(tmp) %in% c("Amount","timeS")]
			# Aggregating the Amount data by Week
			 if (nrow(tmp) != 0){
				 # Error occurs trying to aggregate empty matrix
				 tmp <- aggregate(Amount ~ timeS, tmp, sum)
			 } else {
				 tmp <- data.frame(timeS=as.Date(character()), Amount=double())
			 }
			# Renaming the last column (Amount) by its category name
			 names(tmp)[length(tmp)] <- catname
			# If it is the initial loop, don't do merging
			 if (j != 0){
				 # Merge the new with old. The order is important
				 tmp <- merge(old, tmp, by="timeS", all=TRUE)
				 }
			# Dump the new into the old
			 old <- tmp
			# Make sure the next iteration is not the initial one
			 j <- j+1
		}
		# Replace all the NA's by zero
		tmp[is.na(tmp)] <- 0

		# Adding all the categories to one
		tempUserSum <- tmp[,1:2]
		tempUserSum[,2] <- rowSums(tmp[,2:length(tmp)])
		# renaming the total column by the user name
		names(tempUserSum)[2] <- user
		

		# Now we need to merge these tempUSerSums, same idea
		# rename the last column by user name
		outertmp <- tempUserSum

		#Change here
		if (k != 0){
			 # Merge the new with old. The order is important
			 outertmp <- merge(outerold, outertmp, by="timeS", all=TRUE)
			 }

		dump <- outertmp
		# Dump the new into the old
		 outerold <- outertmp
		# Make sure the next iteration is not the initial one
		 k <- k+1
	}


# reverting the name of outertmp to tmp again
# so that te rest of the code need no change
tmp <- outertmp




} else {

	i = 0
	for (catname in cats){
		if(manyuser){
			# Change this to Person
		 tmp <- subset(tran, Transaction.Type == catname)
		} else {
		# Picking the rows matching the category
		 tmp <- subset(tran, Category == catname)
		}
		# Picking the columns matching Amount and Week 
		 tmp <- tmp[names(tmp) %in% c("Amount","timeS")]
		# Aggregating the Amount data by Week
		 if (nrow(tmp) != 0){
			 # Error occurs trying to aggregate empty matrix
			 tmp <- aggregate(Amount ~ timeS, tmp, sum)
		 } else {
			 tmp <- data.frame(timeS=as.Date(character()), Amount=double())
		 }

		# Renaming the last column (Amount) by its category name
		 names(tmp)[length(tmp)] <- catname
		# If it is the initial loop, don't do merging
		 if (i != 0){
			 # Merge the new with old. The order is important
			 tmp <- merge(old, tmp, by="timeS", all=TRUE)
			 }
		# Dump the new into the old
		 old <- tmp
		# Make sure the next iteration is not the initial one
		 i <- i+1
	}


}


# Polulating data with empty values for consistency
# Get initial span
if(populate){
	listeddates <- tmp[,1]
	# populate can be used without from 
       # and there might be no span values corresponding to few initial spans	
	# so setting a fromdate will add a few
	if( fromdate == 0){
		# Get the first span value here
		firstspan <- min(tmp[,1])
	}
	# union of these two data will not work because other fields won't be tracked
	firstspan <- as.Date(cut(fromdate, breaks=timespan))
	lastspan  <- as.Date(cut(Sys.Date(), breaks= timespan))
	# Create a seq of date
	fullseq <- seq.Date(firstspan, lastspan, by=timespan)
	# converting to char because setdiff function cannot handle dates!!
	fullseq <- as.character(fullseq)
	
	# Must convert the first column of the frame to a vector. This is how
	tmpvec = as.character(listeddates)

	# converting back to date
	emptycols <- as.Date(setdiff(fullseq, tmpvec))

	# Adding dates with empty values
	tmp[(nrow(tmp)+1):(nrow(tmp)+length(emptycols)),1] <- emptycols
}


# Replace all the NA's by zero
tmp[is.na(tmp)] <- 0
# Ordering the columns by date
tmp <- tmp[order(tmp$timeS),]


# Taking all columns except the first one, then take the transpose t(matrix)
final <- t(tmp[,2:length(tmp)])
# For legend
legnames <- names(tmp)[2:length(names(tmp))]
# These are the names of xlabels for Week at least. Need to transpose (t()) because we use it as a row vector while ploting
xlabels <- t(format(tmp[1], format=legformat))

# Saving to png
png("Rscr.png")

# Bar plotting the data
xx <- barplot(final, beside=besideval, names.arg=xlabels, las=2, col=cols)
if( addline == TRUE){
 # Drawing a horizontal line though a bar plot, lty is the style of the line
 abline( h = bamount, lty = 5)
 text(x=0, y= bamount+5, label=paste("Budget:",bamount),xpd=TRUE)
}
# To write the total on top of each bar
# xpd=T allows you to write outside the graph boundary, does;t cut it out
if(shownum){
if(besideval){
	text(x = xx, y=final+5, label=final, xpd=TRUE)
} else {
csum <- colSums(final)
#text(x = xx, y=csum+5, label=csum, xpd=TRUE)
text(x = xx, y=csum+1, label=csum, xpd=TRUE)
}
}


 # Add legend
 legend("topleft",legnames,pch=15, col=cols)

 #ending save
 dev.off()
