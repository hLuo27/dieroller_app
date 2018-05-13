#' @title roll
#' @description roll a die
#' @param die vector of object to roll
#' @param times number of rolls
#' @param p Vector of probabilities
#' @return Vector with roll results
roll <- function(die, times=1, p=rep(1/6,6)){
  sample(die, size = times, replace = TRUE, prob = p)
}

#' @tite make_results_df
#' @description Makes dataframe of results from die rolls
#' @param rolls Vector with roll results
make_results_df <- function(rolls){
  rolls_df = data.frame(table(rolls))
  names(rolls_df) = c("Side","Frequency")
  rolls_df
}