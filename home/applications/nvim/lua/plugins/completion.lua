return {
    {
        "saghen/blink.cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = {
            "rafamadriz/friendly-snippets",
            "giuxtaposition/blink-cmp-copilot",
        },
        version = "*",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                preset = "none",
                ["<Tab>"] = { "select_next", "fallback" },
                ["<S-Tab>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "snippet_forward", "fallback" },
                ["<C-p>"] = { "snippet_backward", "fallback" },
                ["<CR>"] = { "accept", "fallback" },
            },
            completion = {
                list = { selection = { auto_insert = false } },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 0,
                },
                ghost_text = { enabled = true },
                menu = {
                    max_height = 15,
                    scrollbar = false,
                    draw = {
                        treesitter = { "lsp" },
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer", "copilot", "lazydev" },
                providers = {
                    copilot = {
                        name = "copilot",
                        module = "blink-cmp-copilot",
                        score_offset = 100,
                        async = true,
                    },
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
            cmdline = {
                keymap = {
                    preset = "none",
                    ["<Tab>"] = { "select_next" },
                    ["<S-Tab>"] = { "select_prev" },
                    ["<CR>"] = { "accept" },
                },
                completion = {
                    list = { selection = { auto_insert = false } },
                    menu = { auto_show = true },
                },
            },

            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
                filetypes = { markdown = true },
            })
        end,
    },
}
