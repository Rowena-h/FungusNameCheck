#!/usr/bin/env Rscript
##Script to check a list of fungal species names for the most up to date classification in Index Fungorum##

message("\n-----------------------")
message("FungusNameCheck.R")
message("PID:", Sys.getpid())
message(Sys.time())
message("-----------------------\n")

args <- commandArgs(trailingOnly=TRUE)

#Test if the correct packages are installed
if (require(taxize) == FALSE) {
  stop("Please install the taxize package!", call.=FALSE)
} 

#Test if there is one argument: if not, return an error
if (length(args) != 1) {
  stop("\nOne argument must be supplied: input file containing a list of fungi species names with no header", call.=FALSE)
} 

list <- args[1]

#Read in species datasheet
species.df <- read.csv(list, header=FALSE)
#Remove whitespace
species.df$V1 <- trimws(species.df$V1)

message("\nCross-checking list of ", length(species.df$V1), " fungi from ", list, "\n")

#Make dataframe to collect results checking current names (replace with your own species dataframe/the combined tree dataframe)
species.check.df <- data.frame(input_name=unique(species.df$V1),
                               IF_current_name=NA)

#####INDEX FUNGORUM NAME CHECKING LOOP#######

#For each input name...
for (i in 1:length(species.check.df$input_name)) { 
  
  #Search for name
  result <- fg_name_search(species.check.df$input_name[i])
  
  #Check for successful search result
  if (length(result) > 0) {
    
    #Check for 'current name' column
    if ("current_name" %in% colnames(result)) {
      
      #Check for the first hit that is exact and has a 'current name'
      for (j in 1:length(result$name_of_fungus)) {
        
        if (result$name_of_fungus[j] == species.check.df$input_name[i] &
            !is.na(result$current_name[j]) &
            is.na(species.check.df$IF_current_name[i])) {
          
          species.check.df$IF_current_name[i] <- result$current_name[j]
        }  
        
        #Stop checking once the current name is found
        if (!is.na(species.check.df$IF_current_name[i])) break
        
      }
      
      #If no current name column (i.e. a single hit), check that the name hit is exact
    } else if (result$name_of_fungus[1] == species.check.df$input_name[i])
      
      species.check.df$IF_current_name[i] <- result$name_of_fungus[1]
    
  }
  
  #Print progress
  message("Checked ", i, " of ", length(species.check.df$input_name))

}

#Write results to file
write.csv(species.check.df, paste0("checked_names_PID", Sys.getpid(), ".csv"), row.names=FALSE, quote=FALSE)

message("\nResults saved in checked_names_PID", Sys.getpid(), ".csv")
