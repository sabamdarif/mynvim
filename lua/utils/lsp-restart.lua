-- Simple LSP auto-restart with buffer sync
local group = vim.api.nvim_create_augroup("LSPRestart", { clear = true })

-- Store LSP configs for auto-restart
local lsp_configs = {}

-- Capture LSP configs when they attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.config then
			-- Store full config to preserve all settings
			lsp_configs[client.name] = vim.deepcopy(client.config)
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

		-- Skip if buffer is invalid
		if not vim.api.nvim_buf_is_valid(bufnr) then
			return
		end

		-- Capture state before restart
		local state = {
			-- Buffer info
			bufnr = bufnr,
			filepath = vim.api.nvim_buf_get_name(bufnr),
			modified = vim.api.nvim_get_option_value("modified", { buf = bufnr }),
			mode = vim.api.nvim_get_mode().mode,
			current_win = vim.api.nvim_get_current_win(),
			windows = {},
		}

		-- Save buffer content if needed
		if state.filepath == "" or state.modified then
			state.content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		end

		-- Capture cursor position for all windows with this buffer
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_buf(win) == bufnr then
				table.insert(state.windows, {
					id = win,
					cursor = vim.api.nvim_win_get_cursor(win),
					view = vim.fn.winsaveview(),
				})
			end
		end

		-- Save file if modified
		if state.modified and state.filepath ~= "" then
			pcall(vim.cmd, "silent! write! " .. vim.fn.fnameescape(state.filepath))
		end

		-- Wait briefly then check if we need to restart
		vim.defer_fn(function()
			-- Skip if buffer is now invalid
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end

			-- Skip if another instance of this server has already attached
			local active_clients = vim.lsp.get_clients({ bufnr = bufnr, name = server_name })
			if #active_clients > 0 then
				return
			end

			-- Only restart for real files with filetypes
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
			if not filetype or filetype == "" then
				return
			end

			vim.notify("Auto-restarting " .. server_name, vim.log.levels.INFO)

			-- Restart with original config
			if lsp_configs[server_name] then
				vim.lsp.start(lsp_configs[server_name], { bufnr = bufnr })

				-- Restore state after restart
				vim.defer_fn(function()
					-- Reload file from disk or restore content
					if state.filepath ~= "" then
						pcall(vim.cmd, "silent! edit!")
					elseif state.content then
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, state.content)
					end

					-- Restore window positions
					for _, win in ipairs(state.windows) do
						if vim.api.nvim_win_is_valid(win.id) and vim.api.nvim_win_get_buf(win.id) == bufnr then
							-- Restore cursor
							pcall(vim.api.nvim_win_set_cursor, win.id, win.cursor)

							-- Restore view
							if win.view then
								vim.fn.win_execute(win.id, "call winrestview(" .. vim.fn.json_encode(win.view) .. ")")
							end
						end
					end

					-- Restore active window
					if vim.api.nvim_win_is_valid(state.current_win) then
						vim.api.nvim_set_current_win(state.current_win)
					end

					-- Restore mode
					if state.mode:match("^i") then
						vim.schedule(function()
							vim.cmd("startinsert")
						end)
					elseif state.mode:match("^v") then
						vim.schedule(function()
							vim.cmd("normal! gv")
						end)
					end

					-- Refresh the buffer
					vim.cmd("doautocmd BufEnter")
					vim.cmd("redraw!")
				end, 1500)
			end
		end, 1000)
	end,
})

-- Command for manually restarting LSP
vim.api.nvim_create_user_command("LspRestartSync", function(opts)
	local bufnr = vim.api.nvim_get_current_buf()
	local server_name = opts.args ~= "" and opts.args or nil

	-- Capture state
	local state = {
		bufnr = bufnr,
		filepath = vim.api.nvim_buf_get_name(bufnr),
		modified = vim.api.nvim_get_option_value("modified", { buf = bufnr }),
		mode = vim.api.nvim_get_mode().mode,
		current_win = vim.api.nvim_get_current_win(),
		windows = {},
	}

	-- Save content for unnamed buffers or modified buffers
	if state.filepath == "" or state.modified then
		state.content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	end

	-- Save cursor positions
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == bufnr then
			table.insert(state.windows, {
				id = win,
				cursor = vim.api.nvim_win_get_cursor(win),
				view = vim.fn.winsaveview(),
			})
		end
	end

	-- Save file if modified
	if state.modified and state.filepath ~= "" then
		pcall(vim.cmd, "silent! write! " .. vim.fn.fnameescape(state.filepath))
	end

	-- Restart specific server or all servers
	if server_name then
		vim.notify("Restarting " .. server_name, vim.log.levels.INFO)
		pcall(vim.cmd, "LspStop " .. server_name)

		vim.defer_fn(function()
			if lsp_configs[server_name] then
				vim.lsp.start(lsp_configs[server_name], { bufnr = bufnr })
			else
				pcall(vim.cmd, "LspStart " .. server_name)
			end
		end, 500)
	else
		-- Restart all servers for current buffer
		local clients = vim.lsp.get_clients({ bufnr = bufnr })
		if #clients == 0 then
			vim.notify("No active LSP clients", vim.log.levels.WARN)
			return
		end

		vim.notify("Restarting all LSP servers", vim.log.levels.INFO)
		local servers_to_restart = {}

		for _, client in ipairs(clients) do
			table.insert(servers_to_restart, client.name)
			pcall(vim.cmd, "LspStop " .. client.name)
		end

		vim.defer_fn(function()
			for _, name in ipairs(servers_to_restart) do
				if lsp_configs[name] then
					vim.lsp.start(lsp_configs[name], { bufnr = bufnr })
				else
					pcall(vim.cmd, "LspStart " .. name)
				end
			end
		end, 500)
	end

	-- Restore state after restart
	vim.defer_fn(function()
		-- Reload file or restore content
		if state.filepath ~= "" then
			pcall(vim.cmd, "silent! edit!")
		elseif state.content then
			vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, state.content)
		end

		-- Restore window positions
		for _, win in ipairs(state.windows) do
			if vim.api.nvim_win_is_valid(win.id) and vim.api.nvim_win_get_buf(win.id) == bufnr then
				pcall(vim.api.nvim_win_set_cursor, win.id, win.cursor)

				if win.view then
					vim.fn.win_execute(win.id, "call winrestview(" .. vim.fn.json_encode(win.view) .. ")")
				end
			end
		end

		-- Restore active window
		if vim.api.nvim_win_is_valid(state.current_win) then
			vim.api.nvim_set_current_win(state.current_win)
		end

		-- Restore mode
		if state.mode:match("^i") then
			vim.schedule(function()
				vim.cmd("startinsert")
			end)
		elseif state.mode:match("^v") then
			vim.schedule(function()
				vim.cmd("normal! gv")
			end)
		end

		-- Refresh buffer
		vim.cmd("doautocmd BufEnter")
		vim.cmd("redraw!")
	end, 1500)
end, {
	nargs = "?",
	complete = function()
		local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
		return vim.tbl_map(function(client)
			return client.name
		end, clients)
	end,
	desc = "Restart LSP servers with buffer sync",
})
