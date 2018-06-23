library(httr)
library(jsonlite)

getUserData <- function(user, network, apiKey) {
  
  network <- tolower(network)
  
  # If the user inputs an invalid network name give them
  # the list of valid networks
  if (!network %in% c("xb1", "psn", "pc")) {
    warning("Please select a valid network. 
            Valid networks are xb1, psn, and pc.")
  }
  
  # This is the base url for the Fortnite API
  url <- 'https://api.fortnitetracker.com/v1/profile'
  
  # Create the header to be sent with the API call
  header <- c(`TRN-Api-Key` = as.character(apiKey))
  
  # Concatenate the base url with given user and network
  apiUrl <- paste(url, "/", network, "/", user, sep = "")
  
  # Make the call to the API using the concatenated url
  response <- GET(apiUrl, add_headers(header))
  
  # Return the content of the response
  return(response)
}
