local lspconfig = require("lspconfig")
local servers_mod = require("custom.language-servers")

local M = {}
-- ===================================================================
-- Diagnostic on hover
-- ===================================================================
M.on_attach = function(client, bufnr)
	local diag_hover_enabled = false -- Changed to false by default
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

	-- Start with diagnostic hover disabled by default
	disable_diagnostic_hover()

	-- Toggle hover popup with 'leader + d' keymap
	vim.keymap.set("n", "<leader>d", function()
		if diag_hover_enabled then
			disable_diagnostic_hover()
			vim.notify("Diagnostic hover disabled")
		else
			enable_diagnostic_hover()
			vim.notify("Diagnostic hover enabled")
		end
		diag_hover_enabled = not diag_hover_enabled
	end, { buffer = bufnr, desc = "Toggle diagnostic hover" })

	-- Diagnostic navigation keymaps
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
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
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
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
-- NEW, methode by using vim.lsp.enable, ( nvim )v.11+ required
-- ===================================================================
local servers = servers_mod.servers
vim.lsp.enable(servers)
-- ===================================================================
-- override yamlls with extra settings & schemas
-- ===================================================================
if lspconfig.yamlls then
	lspconfig.yamlls.setup({
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
end

-- ===================================================================
-- diagnostic, signs, icons
-- ===================================================================
local x = vim.diagnostic.severity

vim.diagnostic.config({
	virtual_text = {
		prefix = "",
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	signs = { text = { [x.ERROR] = "󰅙", [x.WARN] = "", [x.INFO] = "󰋼", [x.HINT] = "󰌵" } },
	underline = true,
	float = { border = "single" },
})

return M
