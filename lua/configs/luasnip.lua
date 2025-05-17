return function(_, opts)
	local luasnip = require("luasnip")
	luasnip.config.set_config(opts)

	-- Optional: SnipMate snippets
	require("luasnip.loaders.from_snipmate").lazy_load({
		paths = vim.g.snipmate_snippets_path or "",
	})

	-- Optional: Lua snippets
	require("luasnip.loaders.from_lua").lazy_load({
		paths = vim.g.lua_snippets_path or "",
	})

	-- Auto unlink snippet when leaving insert mode if not jumping
	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
				luasnip.unlink_current()
			end
		end,
	})
end
