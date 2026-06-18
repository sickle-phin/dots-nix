return {
    {
        "saghen/blink.cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        dependencies = {
            "rafamadriz/friendly-snippets",
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
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = true,
                    },
                },
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
                default = { "lsp", "path", "snippets", "buffer", "lazydev" },
                providers = {
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
                    ["<Tab>"] = { "select_next", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "fallback" },
                    ["<Right>"] = { "accept", "fallback" },
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
}
