#!/usr/bin/env Rscript
cycle_of_15 <- c("fizzbuzz", NA, NA, "fizz", NA,
                 "buzz", "fizz", NA, NA, "fizz",
                 "buzz", NA, "fizz", NA, NA)

fizz_buzz <- function(n) {
  word <- cycle_of_15[as.integer(n) %% 15 + 1]
  ifelse(is.na(word), n, word)
}

f <- file("stdin")
open(f)
while(length(n <- readLines(f, n = 1)) > 0) {
  write(fizz_buzz(n), stdout())
}
close(f)
