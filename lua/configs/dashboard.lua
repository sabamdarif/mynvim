local M = {}

M.setup = function()
	local dashboard = require("alpha.themes.dashboard")

	local logo = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
  ]]

	dashboard.section.header.val = vim.split(logo, "\n")

	dashboard.section.buttons.val = {
		dashboard.button("ff", "  Find file", "<cmd>Telescope find_files<CR>"),
		dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
		dashboard.button("n", "  New file", "<cmd> ene <BAR> startinsert <cr>"),
		dashboard.button("s", "  Restore session", "<cmd>lua require('persistence').load()<CR>"),
		dashboard.button("l", "󰒲  Lazy", "<cmd> Lazy <cr>"),
		dashboard.button("q", "  Quit", "<cmd> qa <cr>"),
	}

	for _, btn in ipairs(dashboard.section.buttons.val) do
		btn.opts.hl = "AlphaButtons"
		btn.opts.hl_shortcut = "AlphaShortcut"
	end

	dashboard.section.header.opts.hl = "AlphaHeader"
	dashboard.section.buttons.opts.hl = "AlphaButtons"
	dashboard.section.footer.opts.hl = "AlphaFooter"
	dashboard.opts.layout[1].val = 8

	if vim.o.filetype == "lazy" then
		vim.cmd.close()
		vim.api.nvim_create_autocmd("User", {
			once = true,
			pattern = "AlphaReady",
			callback = function()
				require("lazy").show()
			end,
		})
	end

	require("alpha").setup(dashboard.opts)

	vim.api.nvim_create_autocmd("User", {
		once = true,
		callback = function()
			local stats = require("lazy").stats()
			local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
			dashboard.section.footer.val = "⚡ Neovim loaded "
				.. stats.loaded
				.. "/"
				.. stats.count
				.. " plugins in "
				.. ms
				.. "ms"
			pcall(vim.cmd.AlphaRedraw)
		end,
	})
end

return M
