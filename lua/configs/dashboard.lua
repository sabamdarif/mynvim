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
		dashboard.button("ff","  Find file", "<cmd>Telescope find_files<cr>"),
		dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
		dashboard.button("n", "  New file", "<cmd> ene <BAR> startinsert <cr>"),
		dashboard.button("th", "󱥚  Themes", "<cmd> Telescope colorscheme<cr>"),
		dashboard.button("s", "󰁯  Restore session", "<cmd>lua require('persistence').load()<cr>"),
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

	-- Initialize the footer (empty until stats are loaded)
	dashboard.section.footer.val = ""

	require("alpha").setup(dashboard.opts)

	-- Use a direct approach with a timer for reliability
	vim.api.nvim_create_autocmd("User", {
		pattern = "AlphaReady",
		callback = function()
			-- Create a repeating timer to check for stats
			local timer = vim.loop.new_timer()
			local attempts = 0
			timer:start(
				150,
				150,
				vim.schedule_wrap(function()
					attempts = attempts + 1
					local stats = require("lazy").stats()

					-- Check if we have real stats or should keep waiting
					if stats.startuptime > 0 or attempts > 20 then -- Stop after ~3 seconds max
						timer:stop()

						-- Update the footer with actual values
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						dashboard.section.footer.val = "  Neovim loaded "
							.. stats.loaded
							.. "/"
							.. stats.count
							.. " plugins in "
							.. ms
							.. "ms"
						pcall(vim.cmd.AlphaRedraw)
					end
				end)
			)
		end,
		once = true,
	})
end
return M
