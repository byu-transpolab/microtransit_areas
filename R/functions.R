# This is where you write functions that can be called from 
# _targets
# 
# 

#' Summarize a mean value
#' 
#' @param dataset A data frame or tibble with an `x` variable.
summ <- function(dataset) {
  summarize(dataset, mean_x = mean(x))
}

#' Read the data
#' 
#' @param eventsCSV A path to an events .csv
read_data <- function(eventsCSV){
  
  #set column types
  eventCols <- read_csv("R/eventHandler/eventCols.csv", col_names = F)
  coltypes <- set_names(pull(eventCols, 2), pull(eventCols ,1))
  
  #read full events
  fullEvents <- read_csv(eventsCSV, col_types = coltypes)
  
  eventCols <- c("person",
                 "time",
                 "type",
                 "mode",
                 "legMode",
                 "vehicleType",
                 "vehicle",
                 "arrivalTime",
                 "departureTime",
                 "departTime",
                 "length",
                 "numPassengers",
                 "actType",
                 "personalVehicleAvailable"
  )
  fullEvents %<>% relocate(all_of(eventCols))
  
  #select and add columns of interest
  events <- fullEvents %>% select(all_of(eventCols))
  events %<>% mutate(
    travelTime = arrivalTime - departureTime,
    avgSpeed = length / travelTime
  )
  events %<>%
    {as.data.table(.)[order(person,time)]} %>%
    as_tibble()
  events
}

#' Count events
#' 
#' @param events Events tibble
count_events <- function(events){
  
  countEvents <- events %>%
    group_by(type) %>%
    summarize(n = n())
  
  countEvents %>%
    my_kbl(align = 'lr')
}