#' Control whether standard output should be captured or not
#'
#' @usage fassignment \%conditions\% capture
#'
#' @inheritParams multiprocess
#' 
#' @param fassignment The future assignment, e.g.
#'        \code{x \%<-\% \{ expr \}}.
#'
#' @param capture If TRUE, the standard output will be captured, otherwise not.
#'
#' @export
`%conditions%` <- function(fassignment, capture) {
  fassignment <- substitute(fassignment)
  envir <- parent.frame(1)

  ## Temporarily set 'lazy' argument
  args <- getOption("future.disposable", list())
  args["conditions"] <- list(capture)
  options(future.disposable = args)

  eval(fassignment, envir = envir, enclos = baseenv())
}
