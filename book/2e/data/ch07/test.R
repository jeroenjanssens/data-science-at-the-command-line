#!/usr/bin/env Rscript
library(ggplot2)
df <- janitor::clean_names(readr::read_delim(file("stdin", "rb", raw = TRUE), delim = ",", col_names = TRUE))
p <- qplot(x = bill, y = tip, margins = FALSE, geom = "auto", color = sex, data = df)
p + theme(legend.position = "bottom")
