return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason-org/mason.nvim", "saghen/blink.cmp" },
    config = function()
        local sev = vim.diagnostic.severity

        vim.diagnostic.config({
            severity_sort = true,
            virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
            signs = { text = { [sev.ERROR] = "󰅙", [sev.WARN] = "", [sev.INFO] = "󰋼", [sev.HINT] = "󰌵" } },
        })

        -- Neovim 0.11 already binds grn, gra, grr, gri, grt, gO, K, <C-s> and ]d/[d.
        -- These are the shorter aliases NvChad and LazyVim add on top of those.
        local keys = {
            { "gd", vim.lsp.buf.definition, "Go to definition" },
            { "gD", vim.lsp.buf.declaration, "Go to declaration" },
            { "gr", vim.lsp.buf.references, "References" },
            { "gI", vim.lsp.buf.implementation, "Go to implementation" },
            { "<leader>D", vim.lsp.buf.type_definition, "Go to type definition" },
            { "<leader>cs", vim.lsp.buf.document_symbol, "Document symbols" },
            { "<leader>cr", vim.lsp.buf.rename, "Rename symbol" },
            { "<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" } },
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local buf = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                for _, key in ipairs(keys) do
                    vim.keymap.set(key[4] or "n", key[1], key[2], { buffer = buf, desc = "LSP " .. key[3] })
                end

                if client:supports_method("textDocument/inlayHint") and vim.bo[buf].buftype == "" then
                    vim.lsp.inlay_hint.enable(true, { bufnr = buf })
                    vim.keymap.set("n", "<leader>ch", function()
                        local on = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
                        vim.lsp.inlay_hint.enable(not on, { bufnr = buf })
                    end, { buffer = buf, desc = "LSP Toggle inlay hints" })
                end

                -- Prefer the server's own fold ranges over treesitter's.
                if client:supports_method("textDocument/foldingRange") then
                    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
                        vim.wo[win].foldexpr = "v:lua.vim.lsp.foldexpr()"
                    end
                end
            end,
        })

        vim.lsp.config("*", {
            capabilities = vim.tbl_deep_extend("force", require("blink.cmp").get_lsp_capabilities({}, false), {
                workspace = { fileOperations = { didRename = true, willRename = true } },
            }),
            on_init = function(client)
                client.server_capabilities.semanticTokensProvider = nil
                if client.name == "ruff" then
                    client.server_capabilities.hoverProvider = false -- pyright's is better
                end
            end,
        })

        local lang = require("lang")
        for server, config in pairs(lang.lsp_config) do
            vim.lsp.config(server, config)
        end
        vim.lsp.enable(lang.lsp_servers)
    end,
}
