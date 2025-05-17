local dashboard = require("alpha.themes.dashboard")
local button = dashboard.button

dashboard.section.header.val = {
	[[                                                    ]],
	[[ ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ]],
	[[ ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ]],
	[[ ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ]],
	[[ ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ]],
	[[ ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ]],
	[[ ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ]],
	[[                                                    ]],
}

dashboard.section.buttons.val = {
	button("ff", "  Find file", "<cmd>Telescope find_files<CR>"),
	button("r", "  Recent files", "<cmd>Telescope oldfiles<CR>"),
	button("n", "  New file", "<cmd>enew<CR>"),
	button("d", "  New folder", "<cmd>lua vim.fn.mkdir(vim.fn.input('Folder name: '), 'p')<CR>"),
	button("s", "  Restore session", "<cmd>lua require('persistence').load()<CR>"), -- optional
	button("q", "  Quit Neovim", "<cmd>qa<CR>"),
}

dashboard.section.footer.val = function()
	return "󱐌  Neovim loaded at " .. os.date("%H:%M:%S")
end

dashboard.config.opts.noautocmd = true

return {
	opts = dashboard.opts,
}
