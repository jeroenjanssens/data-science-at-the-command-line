library(magrittr)

sh <- function(.data, command) {
  temp_file <- tempfile()
  out_con <- fifo(temp_file, "w+")
  in_con <- pipe(paste0(command, " > ", temp_file))
  writeLines(as.character(.data), in_con)
  result <- readLines(out_con)
  close(out_con)
  close(in_con)
  unlink(temp_file)
  result
}

lines <- readLines("alice.txt")
words <- unlist(strsplit(lines, " "))

sh(words, "grep -i alice") %>%
  sh("wc -l") %>%
  sh("cowsay") %>%
  cli::cat_boxx()
