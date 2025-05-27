-- Simple LSP auto-restart with buffer sync
local group = vim.api.nvim_create_augroup("UniversalLSPRestart", { clear = true })

-- Store LSP configs for auto-restart
local lsp_configs = {}

-- Capture LSP configs when they attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.config then
			lsp_configs[client.name] = {
				name = client.name,
				root_dir = client.config.root_dir or vim.fn.getcwd(),
				cmd = client.config.cmd,
			}
		end
	end,
})

-- Auto-restart any LSP that detaches unexpectedly
vim.api.nvim_create_autocmd("LspDetach", {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end

		local server_name = client.name
		local bufnr = args.buf

		vim.defer_fn(function()
			if vim.api.nvim_buf_is_valid(bufnr) then
				local active_clients = vim.lsp.get_clients({ bufnr = bufnr, name = server_name })
				if #active_clients == 0 then
					local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
					if filetype and filetype ~= "" then
						vim.notify(string.format("Auto-restarting %s", server_name), vim.log.levels.INFO)

						local config = lsp_configs[server_name]
						if config then
							vim.lsp.start({
								name = server_name,
								cmd = config.cmd,
								root_dir = config.root_dir,
							}, { bufnr = bufnr })
						end
					end
				end
			end
		end, 2000)
	end,
})

-- Manual restart with sync
local function restart_with_sync(server_name)
	local bufnr = vim.api.nvim_get_current_buf()
	local filepath = vim.api.nvim_buf_get_name(bufnr)
	local current_win = vim.api.nvim_get_current_win()
	local cursor_pos = vim.api.nvim_win_get_cursor(current_win)

	-- Find all windows displaying this buffer
	local buffer_windows = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == bufnr then
			table.insert(buffer_windows, {
				win = win,
				cursor = vim.api.nvim_win_get_cursor(win),
			})
		end
	end

	-- Save file first if modified
	if vim.api.nvim_get_option_value("modified", { buf = bufnr }) and filepath ~= "" then
		vim.cmd("write!")
	end

	if server_name then
		-- Restart specific server
		pcall(vim.cmd, "LspRestart " .. server_name)
	else
		-- Restart all active servers for current buffer
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		if #clients == 0 then
			vim.notify("No active LSP clients", vim.log.levels.WARN)
			return
		end

		for _, client in ipairs(clients) do
			pcall(vim.cmd, "LspRestart " .. client.name)
		end
	end

	-- Reload file and restore cursor positions in all windows after restart
	vim.defer_fn(function()
		if filepath ~= "" then
			vim.cmd("edit!")
		end

		-- Restore cursor position in all windows showing this buffer
		for _, win_info in ipairs(buffer_windows) do
			if vim.api.nvim_win_is_valid(win_info.win) and vim.api.nvim_win_get_buf(win_info.win) == bufnr then
				pcall(vim.api.nvim_win_set_cursor, win_info.win, win_info.cursor)
			end
		end

		-- Ensure we're back in the original window
		if vim.api.nvim_win_is_valid(current_win) then
			vim.api.nvim_set_current_win(current_win)
		end
	end, 2000)
end

-- Simple restart command
vim.api.nvim_create_user_command("LspRestartSync", function(opts)
	restart_with_sync(opts.args ~= "" and opts.args or nil)
end, {
	nargs = "?",
	complete = function()
		local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
		local names = {}
		for _, client in ipairs(clients) do
			table.insert(names, client.name)
		end
		return names
	end,
	desc = "Restart LSP servers with buffer sync",
})
