local lspconfig = require("lspconfig")
local servers_mod = require("custom.language-servers")

local M = {}
-- ===================================================================
-- Diagnostic keymaps
-- ===================================================================
M.on_attach = function(client, bufnr)
	local diag_hover_enabled = false -- off by default
	local group = vim.api.nvim_create_augroup("LspDiagnosticsFloat", { clear = false })

	local function enable_diagnostic_hover()
		vim.api.nvim_create_autocmd("CursorHold", {
			group = group,
			buffer = bufnr,
			callback = function()
				vim.diagnostic.open_float(nil, { focusable = false, border = "rounded" })
			end,
			desc = "LSP floating diagnostic",
		})
	end

	local function disable_diagnostic_hover()
		vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
	end

	disable_diagnostic_hover()

	local map = vim.keymap.set

	map({ "n", "o" }, "<leader>dg", function()
		if diag_hover_enabled then
			disable_diagnostic_hover()
			vim.notify("Diagnostic hover disabled")
		else
			enable_diagnostic_hover()
			vim.notify("Diagnostic hover enabled")
		end
		diag_hover_enabled = not diag_hover_enabled
	end, { buffer = bufnr, desc = "Toggle diagnostic hover", noremap = true })

	local diag_opts = { buffer = bufnr, silent = true }
	map("n", "[d", vim.diagnostic.goto_prev, diag_opts)
	map("n", "]d", vim.diagnostic.goto_next, diag_opts)

	local lsp_opts = { buffer = bufnr, silent = true }
	map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to Definition" })
	map("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "LSP: Go to Declaration" })
	map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: References" })
	map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
	map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
end

-- ===================================================================
-- combile capabilities
-- ===================================================================
M.on_init = function(client, _)
	if client.server_capabilities.semanticTokensProvider then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.capabilities = require("blink.cmp").get_lsp_capabilities(M.capabilities)

-- ===================================================================
-- OLD, loop over your list and apply the shared settings
-- ===================================================================
-- for _, server in ipairs(servers_mod.servers) do
-- 	local ok = lspconfig[server]
-- 	if ok then
-- 		lspconfig[server].setup({
-- 			on_attach = M.on_attach,
-- 			on_init = M.on_init,
-- 			capabilities = M.capabilities,
-- 		})
-- 	else
-- 		vim.notify("LSPConfig: no support for server '" .. server .. "'", vim.log.levels.WARN)
-- 	end
-- end
-- ===================================================================
-- NEW, method by using vim.lsp.enable, ( nvim v.11+ required )
-- ===================================================================
local servers = servers_mod.servers

-- Configure all servers with your custom settings FIRST
for _, server in ipairs(servers) do
	vim.lsp.config(server, {
		on_attach = M.on_attach,
		on_init = M.on_init,
		capabilities = M.capabilities,
	})
end

-- Now enable all configured servers
vim.lsp.enable(servers)

-- ===================================================================
-- override yamlls with extra settings & schemas
-- ===================================================================
vim.lsp.config("yamlls", {
	on_attach = M.on_attach,
	on_init = M.on_init,
	capabilities = M.capabilities,
	settings = {
		yaml = {
			validate = true,
			hover = true,
			completion = true,
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
				["https://json.schemastore.org/kustomization.json"] = "kustomization.yaml",
			},
		},
	},
})

-- ===================================================================
-- diagnostic, signs, icons
-- ===================================================================
local x = vim.diagnostic.severity

vim.diagnostic.config({
	virtual_text = { prefix = "" },
	signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
	underline = true,
	float = { border = "single" },
})

-- ===================================================================
-- Setup LSP Auto-Restart
-- ===================================================================
require("utils.lsp-restart")

return M
