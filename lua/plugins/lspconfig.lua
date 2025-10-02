return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "saghen/blink.cmp",
    },
    config = function()
        local lang_config = require("lang")
        require("mason").setup()
        vim.lsp.inlay_hint.enable(false)
        local x = vim.diagnostic.severity
        vim.diagnostic.config({
            virtual_text = { prefix = "" },
            signs = {
                text = {
                    [x.ERROR] = "󰅙",
                    [x.WARN] = "",
                    [x.INFO] = "󰋼",
                    [x.HINT] = "󰌵",
                },
            },
            underline = true,
            float = { border = "single" },
        })
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
        local on_init = function(client, _)
            if client:supports_method("textDocument/semanticTokens") then
                client.server_capabilities.semanticTokensProvider = nil
            end
        end
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local function opts(desc)
                    return { buffer = bufnr, desc = "LSP " .. desc }
                end
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to declaration"))
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to definition"))
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts("List workspace folders"))
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts("Go to type definition"))
                vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, opts("Rename"))
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover"))
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code action"))
            end,
        })
        vim.lsp.config("*", {
            capabilities = capabilities,
            on_init = on_init,
        })
        for server, config in pairs(lang_config.lsp_config) do
            local server_config = vim.tbl_deep_extend("force", {
                capabilities = capabilities,
                on_init = on_init,
            }, config)
            vim.lsp.config(server, server_config)
        end
        if #lang_config.lsp_servers > 0 then
            vim.lsp.enable(lang_config.lsp_servers)
        end

        -- Setup LSP Auto-Restart
        require("utils.lsp-restart")
    end,
}
