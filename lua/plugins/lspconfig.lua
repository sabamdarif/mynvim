return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "mason-org/mason.nvim",
        "saghen/blink.cmp",
    },
    opts = function()
        local x = vim.diagnostic.severity

        -- Base capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        -- Merge blink.cmp capabilities
        capabilities = vim.tbl_deep_extend(
            "force",
            capabilities,
            require("blink.cmp").get_lsp_capabilities({}, false)
        )

        -- Merge custom capabilities: folding range + workspace file operations
        capabilities = vim.tbl_deep_extend("force", capabilities, {
            textDocument = {
                foldingRange = {
                    dynamicRegistration = false,
                    lineFoldingOnly = true,
                },
            },
            workspace = {
                fileOperations = {
                    didRename = true,
                    willRename = true,
                },
            },
        })

        ---@class PluginLspOpts
        local ret = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
                signs = {
                    text = {
                        [x.ERROR] = "󰅙",
                        [x.WARN] = "",
                        [x.INFO] = "󰋼",
                        [x.HINT] = "󰌵",
                    },
                },
            },
            inlay_hints = {
                enabled = true,
                exclude = { "vue" },
            },
            codelens = { enabled = false },
            folds = { enabled = true },
            capabilities = capabilities,
            format = {
                formatting_options = nil,
                timeout_ms = nil,
            },
            setup = {},
        }
        return ret
    end,
    config = function(_, opts)
        -- Apply diagnostic settings
        vim.diagnostic.config(opts.diagnostics)

        local lang_config = require("lang")

        -- Define on_init function to disable semanticTokensProvider
        local on_init = function(client, _)
            if client:supports_method("textDocument/semanticTokens") then
                client.server_capabilities.semanticTokensProvider = nil
            end
        end

        -- Setup keymaps on LspAttach
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                local function map_opts(desc)
                    return { buffer = bufnr, desc = "LSP " .. desc }
                end

                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, map_opts("Go to declaration"))
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, map_opts("Go to definition"))
                vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, map_opts("Add workspace folder"))
                vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder,
                    map_opts("Remove workspace folder"))
                vim.keymap.set("n", "<leader>wl", function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, map_opts("List workspace folders"))
                vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, map_opts("Go to type definition"))
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, map_opts("Rename"))
                vim.keymap.set("n", "K", vim.lsp.buf.hover, map_opts("Hover"))
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, map_opts("Code action"))

                -- Inlay hints
                if opts.inlay_hints.enabled and client:supports_method("textDocument/inlayHint") then
                    if vim.api.nvim_buf_is_valid(bufnr)
                        and vim.bo[bufnr].buftype == ""
                        and not vim.tbl_contains(opts.inlay_hints.exclude, vim.bo[bufnr].filetype)
                    then
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end

                -- Folding
                if opts.folds.enabled and client:supports_method("textDocument/foldingRange") then
                    vim.opt_local.foldmethod = "expr"
                    vim.opt_local.foldexpr = "v:lua.vim.lsp.foldexpr()"
                end

                -- Code lens
                if opts.codelens.enabled and vim.lsp.codelens and client:supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.refresh()
                    vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
                        buffer = bufnr,
                        callback = vim.lsp.codelens.refresh,
                    })
                end
            end,
        })

        -- Apply global capabilities and on_init
        vim.lsp.config("*", {
            capabilities = opts.capabilities,
            on_init = on_init,
        })

        -- Register configs for each LSP server with capabilities and on_init
        for server, config in pairs(lang_config.lsp_config) do
            local server_config = vim.tbl_deep_extend("force", {
                capabilities = opts.capabilities,
                on_init = on_init,
            }, config)
            vim.lsp.config(server, server_config)
        end

        -- Enable LSP servers listed in lang_config
        if #lang_config.lsp_servers > 0 then
            vim.lsp.enable(lang_config.lsp_servers)
        end

        -- Setup LSP Auto-Restart
        require("utils.lsp-restart")
    end,
}
