library(knitractive)
library(rexpect)
library(rlang)

engine <- start(name = "console",
          command = cmd_docker(image = "datasciencetoolbox/dsatcl2e",
                                volume = list2(!!here::here("images") := "/images",
                                              !!here::here("data") := "/data")),
          prompt = prompts$bash,
          session_width = 80,
          session_height = 16)

setup <- c("PS1='$ '",
            "export RIO_DPI=200",
            "function csvlook {",
            "    /usr/local/bin/csvlook \"$@\" |",
            "    trim |",
            "    sed 's/- | -/──┼──/g;s/| -/├──/g;s/- |/──┤/;s/|/│/g;2s/-/─/g'",
            "}",
            "alias trim='expand | trim'",
            "alias bat='batcat --paging never --decorations always --color never'")

send_lines(engine$session, setup, wait = TRUE)
engine$scroll(length(engine$session) - 1)
