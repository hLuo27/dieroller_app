#' @title Die Roll
#' @description roll a die
#' @param die vector of object to roll
#' @param times number of rolls
#' @param p Vector of probabilities
#' @return Vector with roll results
roll <- function(die, times=1, p=rep(1/6,6)){
  sample(die, size = times, replace = TRUE, prob = p)
}

#' @tite Make Results Dataframe
#' @describeIn 
make_results_df <- function(rolls){
  
}