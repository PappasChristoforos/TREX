#example.data
#' Generate example TDM input data
#'
#' This returns a data.frame containing standard TDM (thermal dissipation method)
#'  measurements provided in two different formats. The data is obtain from \code{tdm.data}
#'  where \eqn{\Delta V} measurements are provide for i) Norway spruce (\emph{Picea abies} Karts.)
#'  growing in a valley in the Swiss Alps or ii) black spruce (\emph{Picea mariana} Mill. BSP)/eastern
#'  larch (\emph{Larix laricina} Du Roi K. Koch) growing at the southern limit of the boreal
#'  ecozone in central Canada.
#'
#' @usage example.data(type = "timestamp")
#'
#' @param type Character string, indicating whether the example data should be
#' displayed with a timestamp (default = “timestamp”)
#' or whether a separate day of day of year and hour column
#' are provided (“doy”).
#'
#'
#' @details This dataset can be applied for testing the functions provided in the package.
#'
#' @return A data.frame containing TDM measurements according to a specific type.
#' @export
#'
#' @examples
#'
#' # get example data
#' input_data <- example.data(type = "timestamp")
#' input_data <- example.data(type = "doy")
#' head(input_data)
#'
example.data <- function(type = "timestamp") {
  #t= test
  #type="timestamp"


  #d= default conditions
  if (missing(type)) {
    type = "timestamp"
  }


  #e= errors
  if (type != "timestamp" &
      type != "doy")
    stop(paste0("Unused argument, please use: timestamp|doy."))
  # if (species != "PCAB" &
  #     species != "PCMA")
  #   stop(paste0("Unused argument, please use: PCAB|PCMA."))


  species <- "PCAB"

  #p= processing
  #p1= data is loaded
  # proc.1 <- TREX:::tdm.input.txt
  # read.table("tdm.input.txt", header = TRUE, sep = "\t") #p1 data is loaded {CHANGE}
  # proc.1 <- TREX::tdm.data
  proc.1 <- getExportedValue('TREX', 'tdm.data')

  #p2= isolating of data according to criteria
  if (as.character(type) == "timestamp") {
    proc.2 <-
      proc.1[which(as.character(proc.1$species) == as.character(species)), c(1, 5)]
    proc.2[, 1] <- as.character(proc.2[, 1])
    proc.2[, 2] <- as.numeric(proc.2[, 2])
  } else{
    proc.2 <-
      proc.1[which(as.character(proc.1$species) == as.character(species)), c(2, 3, 4, 5)]
    proc.2[, 1] <- as.integer(proc.2[, 1])
    proc.2[, 2] <- as.integer(proc.2[, 2])
    proc.2[, 3] <- as.character(proc.2[, 3])
    proc.2[, 4] <- as.numeric(proc.2[, 4])
  }

  #o= output
  return(proc.2)
}

