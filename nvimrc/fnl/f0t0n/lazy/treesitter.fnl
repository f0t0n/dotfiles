{1 "nvim-treesitter/nvim-treesitter"
 :name "nvim-treesitter"
 :branch "master"
 :build ":TSUpdate"
 :config (fn []
           ((. (require "nvim-treesitter.configs") :setup)
            {:ensure_installed ["c" "cpp" "go" "lua" "python" "rust" "tsx" "typescript" "javascript" "vim" "vimdoc" "query" "markdown" "markdown_inline" "bash" "html" "css" "fennel" "clojure"]
             :sync_install false
             :auto_install true
             :highlight {:enable true
                         :disable (fn [lang buf]
                                     (let [max_filesize (* 100 1024)
                                           (ok stats) (pcall vim.loop.fs_stat (vim.api.nvim_buf_get_name buf))]
                                       (if (and ok stats (> stats.size max_filesize))
                                           true)))
                         :additional_vim_regex_highlighting false}}))}
