---@module "lazy"
return {
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets", event = "InsertEnter", },
        run = "make install_jsregexp",
        opts = {
            history = true,
            updateevents = "TextChanged,TextChangedI",
            delete_check_events = "TextChanged",
        },
        config = function(_, opts)
            -- vscode format
            require("luasnip.loaders.from_vscode").lazy_load { exclude = vim.g.vscode_snippets_exclude or {} }
            require("luasnip.loaders.from_vscode").lazy_load { paths = vim.g.vscode_snippets_path or "" }

            -- snipmate format
            require("luasnip.loaders.from_snipmate").load()
            require("luasnip.loaders.from_snipmate").lazy_load { paths = vim.g.snipmate_snippets_path or "" }

            -- lua format
            require("luasnip.loaders.from_lua").load()
            require("luasnip.loaders.from_lua").lazy_load { paths = vim.g.lua_snippets_path or "" }
        end,
    },
    {
        "saghen/blink.cmp",
        version = '1.*',
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "nvim-tree/nvim-web-devicons",
            {
                "mikavilpas/blink-ripgrep.nvim",
                version = "*",
            },
        },
        opts = function()
            return {
                snippets = {
                    preset = "luasnip"
                },
                appearance = {
                    nerd_font_variant = "mono",
                },
                keymap = {
                    preset = "enter",
                    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                    ["<C-y>"] = { "select_and_accept" },
                },
                completion = {
                    trigger = {
                        show_on_insert_on_trigger_character = true,
                    },
                    accept = {
                        auto_brackets = {
                            enabled = true,
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 200,
                    },
                    menu = {
                        scrollbar = false,
                        draw = {
                            treesitter = { "lsp" },
                            padding = { 1, 1 },
                            columns = { { "label" }, { "kind_icon" }, { "kind" } },
                            -- components = menu_components,
                        },
                        border = "single",
                    },
                    ghost_text = {
                        enabled = true,
                    },
                },
                sources = {
                    default = { "lsp", "snippets", "buffer", "ripgrep", "path" },
                    providers = {
                        lsp = {
                            score_offset = 10, -- Highest priority
                        },

                        snippets = {
                            score_offset = 5, -- Second priority (higher than default -1)
                        },

                        buffer = {
                            score_offset = 0, -- Third priority (neutral score)
                        },

                        ripgrep = {
                            module = "blink-ripgrep",
                            score_offset = -3, -- Fourth priority
                            fallbacks = {},
                            ---@module "blink-ripgrep"
                            opts = {},
                        },

                        path = {
                            score_offset = -5, -- Lowest priority
                        },
                    },
                },
                cmdline = {
                    enabled = true,
                    keymap = { preset = "cmdline" },
                    completion = {
                        list = { selection = { preselect = false } },
                        menu = {
                            auto_show = function(ctx)
                                return vim.fn.getcmdtype() == ":"
                            end,
                        },
                        ghost_text = { enabled = true },
                    },
                },
                fuzzy = {
                    implementation = "prefer_rust",
                    prebuilt_binaries = {
                        force_version = "v1.7.0",
                    },
                },
            }
        end,
    },
}
