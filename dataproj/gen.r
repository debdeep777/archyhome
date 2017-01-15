# Implement Pi chart
#Possibly increase categories and create subcatagory
# Create saving graph
# Print several individual graphs
# Weekly and monthly report (why?)
# List of transactions
# Write actual amounts

library(colorspace)
## Collect arguments
args <- commandArgs(TRUE)
 

filename <- "tran.csv"

# Weekly data or monthly data
timespan <- "week"
# legend format
legformat <- "%m-%d"
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

if(length(args) !=0){
	#args conditions
	if("month" %in% args){
		timespan <- "month"
		legformat <- "%y/%m"
	}
	if("year" %in% args){
		timespan <- "year"
		legformat <- "%y"
	}
	if("day" %in% args){
		timespan <- "day"
		legformat <- "%Y-%m-%d"
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
		personname <- c(args[match("person",args)+1])
	}
	if("2people" %in% args){ 	# Only one category for 2people
		twopcat <- c(args[match("2people",args)+1])
	}
	if("number" %in% args){
		shownum <- TRUE
	}

}

# Reading csv files
tran <- read.csv(filename, header=TRUE)

# Converting strings to dates if the format is known
tran$Date <- as.Date(tran$Date, format = "%Y-%m-%d")

# Most crucial step: assigning Month, Week etc to the data by crating a new frame variable
tran$timeS <- as.Date(cut(tran$Date, breaks = timespan))

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
i = 0
for (catname in cats){
	## If a person is specified
	#if( "oneperson_is_specified"){
	#tran <- subset(tran, Person == naemoftheperson)
	#}	
	# Picking the rows matching the category
	 tmp <- subset(tran, Category == catname)
	# Picking the columns matching Amount and Week 
	 tmp <- tmp[names(tmp) %in% c("Amount","timeS")]
	# Aggregating the Amount data by Week
	 tmp <- aggregate(Amount ~ timeS, tmp, sum)
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


# Replace all the NA's by zero
 tmp[is.na(tmp)] <- 0
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
text(x = xx, y=csum+5, label=csum, xpd=TRUE)
}
}


 # Add legend
 legend("topleft",legnames,pch=15, col=cols)

 #ending save
 dev.off()
