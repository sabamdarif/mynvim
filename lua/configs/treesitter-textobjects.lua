-- configs/treesitter-textobjects.lua
return function()
	local move = require("nvim-treesitter.textobjects.move")
	local configs = require("nvim-treesitter.configs")

	-- Your existing move override code
	for name, fn in pairs(move) do
		if name:find("goto") == 1 then
			move[name] = function(q, ...)
				if vim.wo.diff then
					local config = configs.get_module("textobjects.move")[name]
					for key, query in pairs(config or {}) do
						if q == query and key:find("[%]%[][cC]") then
							vim.cmd("normal! " .. key)
							return
						end
					end
				end
				return fn(q, ...)
			end
		end
	end

	-- Add the complete textobjects configuration
	configs.setup({
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					-- Function text objects
					["af"] = "@function.outer",
					["if"] = "@function.inner",

					-- Class text objects
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",

					-- Parameter text objects
					["ap"] = "@parameter.outer",
					["ip"] = "@parameter.inner",

					-- Block text objects
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",

					-- Conditional text objects
					["ai"] = "@conditional.outer",
					["ii"] = "@conditional.inner",

					-- Loop text objects
					["ao"] = "@loop.outer",
					["io"] = "@loop.inner",

					-- Comment text objects
					["aC"] = "@comment.outer",
					["iC"] = "@comment.inner",

					-- Call text objects
					["aF"] = "@call.outer",
					["iF"] = "@call.inner",
				},
			},

			move = {
				enable = true,
				set_jumps = true,

				goto_next_start = {
					["]f"] = "@function.outer",
					["]c"] = "@class.outer",
					["]a"] = "@parameter.inner",
					["]o"] = "@loop.*",
					["]i"] = "@conditional.outer",
					["]C"] = "@comment.outer",
				},

				goto_next_end = {
					["]F"] = "@function.outer",
					["]C"] = "@class.outer",
					["]A"] = "@parameter.inner",
					["]O"] = "@loop.*",
					["]I"] = "@conditional.outer",
				},

				goto_previous_start = {
					["[f"] = "@function.outer",
					["[c"] = "@class.outer",
					["[a"] = "@parameter.inner",
					["[o"] = "@loop.*",
					["[i"] = "@conditional.outer",
					["[C"] = "@comment.outer",
				},

				goto_previous_end = {
					["[F"] = "@function.outer",
					["[C"] = "@class.outer",
					["[A"] = "@parameter.inner",
					["[O"] = "@loop.*",
					["[I"] = "@conditional.outer",
				},
			},

			swap = {
				enable = true,
				swap_next = {
					["<leader>sp"] = "@parameter.inner",
					["<leader>sf"] = "@function.outer",
				},
				swap_previous = {
					["<leader>sP"] = "@parameter.inner",
					["<leader>sF"] = "@function.outer",
				},
			},
		},
	})
end
