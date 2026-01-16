{1 "neovim/nvim-lspconfig"
 :dependencies ["mason-org/mason.nvim"
                "mason-org/mason-lspconfig.nvim"
                "hrsh7th/nvim-cmp"
                "hrsh7th/cmp-nvim-lsp"
                "hrsh7th/cmp-buffer"
                "hrsh7th/cmp-path"
                "hrsh7th/cmp-cmdline"
                "L3MON4D3/LuaSnip"
                "saadparwaiz1/cmp_luasnip"
                "j-hui/fidget.nvim"]
 :config (fn []
           (vim.lsp.config "lua_ls"
             {:settings {:Lua {:runtime {:version "LuaJIT"}
                               :diagnostics {:globals ["vim" "require" "it" "describe" "before_each" "after_each"]}}}})
           (vim.lsp.config "pyright"
             {:settings {:pyright {:disableOrganizeImports true}
                         :python {:analysis {:ignore ["*"]}}}})

           ((. (require "mason") :setup))
           ((. (require "mason-lspconfig") :setup)
            {:ensure_installed
                ["lua_ls"
                 "ts_ls"
                 "clojure_lsp"
                 "fennel_language_server"
                 "pyright"
                 "ruff"]})

           (let [cmp (require "cmp")
                 cmp_select {:behavior cmp.SelectBehavior.Select}]
             (cmp.setup
               {:snippet {:expand (fn [args]
                                    ((. (require "luasnip") :lsp_expand) args.body))}
                :mapping (cmp.mapping.preset.insert
                           {"<C-p>" (cmp.mapping.select_prev_item cmp_select)
                            "<C-n>" (cmp.mapping.select_next_item cmp_select)
                            "<C-y>" (cmp.mapping.confirm {:select true})
                            "<C-Space>" (cmp.mapping.complete)})
                :sources (cmp.config.sources
                           [{:name "nvim_lsp"}
                            {:name "luasnip"}]
                           [{:name "buffer"}])}))

           (vim.diagnostic.config
             {:float {:focusable false
                      :style "minimal"
                      :border "rounded"
                      :source "always"
                      :header ""
                      :prefix ""}}))}
