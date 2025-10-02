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
            local menu_cols = { { "label" }, { "kind_icon" }, { "kind" } }
            local menu_components = {
                kind_icon = {
                    text = function(ctx)
                        local icons = require "icons.lspkind"
                        local icon = (icons[ctx.kind] or "󰈚")

                        if ctx.source_name == "Path" then
                            local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                            if dev_icon then
                                icon = dev_icon
                            end
                        end
                        return icon
                    end,
                },
                kind = {
                    highlight = function(ctx)
                        return ctx.kind
                    end,
                },
            }
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
                            columns = menu_cols,
                            components = menu_components,
                        },
                        border = nil,
                    },
                    ghost_text = {
                        enabled = true,
                    },
                },
                sources = {
                    default = { "lsp", "path", "snippets", "buffer", "ripgrep" },
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
                },
            }
        end,
    },
}
