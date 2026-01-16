{1 "HiPhish/rainbow-delimiters.nvim"
 :name "rainbow-delimiters"
 :config (fn []
           ((. (require "rainbow-delimiters.setup") :setup)
            {:strategy {"" "rainbow-delimiters.strategy.global"}
             :query {"" "rainbow-delimiters"}
             :highlight ["RainbowDelimiterRed" "RainbowDelimiterYellow" "RainbowDelimiterBlue" "RainbowDelimiterOrange" "RainbowDelimiterGreen" "RainbowDelimiterViolet" "RainbowDelimiterCyan"]
             :blacklist ["c" "cpp"]}))}
