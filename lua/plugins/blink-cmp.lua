---@module "lazy"

-- Strict completion order, regardless of fuzzy score: real LSP items, then
-- snippets, then words from open buffers, then the project-wide fallbacks.
local provider_rank = { lsp = 1, snippets = 2, buffer = 3, ripgrep = 4, path = 5 }

-- Sources that are never a good enough reason to pop the menu open on their
-- own -- they match almost any prefix. <C-space> still summons them.
local noisy_sources = { buffer = true, ripgrep = true }

return {
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        dependencies = { "rafamadriz/friendly-snippets" },
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()

            for ft, extends in pairs(require("lang").luasnip_extends or {}) do
                require("luasnip").filetype_extend(ft, extends)
            end
        end,
    },
    {
        "saghen/blink.cmp",
        event = "InsertEnter",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "nvim-tree/nvim-web-devicons",
            { "mikavilpas/blink-ripgrep.nvim", version = "*" },
        },
        version = "1.*",
        opts = {
            snippets = { preset = "luasnip" },
            keymap = {
                preset = "enter",
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<C-y>"] = { "select_and_accept" },
            },
            completion = {
                -- auto_show defaults to false
                documentation = {
                    auto_show = true,
                    window = { border = "rounded" },
                },
                menu = {
                    scrollbar = false,
                    border = "rounded",
                    -- Stay closed when buffer/ripgrep words are all that matched.
                    auto_show = function(_, items)
                        for _, item in ipairs(items) do
                            if not noisy_sources[item.source_id] then
                                return true
                            end
                        end
                        return false
                    end,
                    draw = {
                        treesitter = { "lsp", "snippets", "buffer", "ripgrep", "path" },
                        columns = { { "label" }, { "kind_icon" }, { "kind" } },
                    },
                },
                -- ghost_text defaults to disabled
                ghost_text = { enabled = true },
            },
            sources = {
                default = { "lsp", "snippets", "buffer", "ripgrep", "path" },
                -- A single character is never enough context. Trigger characters
                -- (".", "/", ...) and <C-space> bypass this.
                min_keyword_length = 2,
                providers = {
                    -- Ordering lives in fuzzy.sorts below, so no score_offset here.
                    snippets = { min_keyword_length = 2 },
                    buffer = { min_keyword_length = 3 },
                    ripgrep = {
                        module = "blink-ripgrep",
                        min_keyword_length = 4,
                        fallbacks = {},
                        opts = { prefix_min_len = 4 },
                    },
                },
            },
            fuzzy = {
                -- "rust" errors if the prebuilt binary is unavailable; the default
                -- "prefer_rust_with_warning" would silently fall back to Lua.
                implementation = "rust",
                sorts = {
                    -- Group by source. Move "exact" above this to let an exact
                    -- buffer word outrank a fuzzy LSP match.
                    function(a, b)
                        local ra = provider_rank[a.source_id] or 99
                        local rb = provider_rank[b.source_id] or 99
                        if ra ~= rb then
                            return ra < rb
                        end
                    end,
                    "exact",
                    "score",
                    "sort_text",
                    "label",
                    "kind",
                },
            },
        },
    },
}
