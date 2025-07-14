local M = {}

M.setup = function()
	require("code_runner").setup({
		filetype = {
			java = {
				"cd $dir &&",
				"javac $fileName &&",
				"java $fileNameWithoutExt",
			},
			python = "python $fileName",
			typescript = "deno run",
			rust = {
				"cd $dir &&",
				"rustc $fileName &&",
				"$dir/$fileNameWithoutExt",
			},
			c = function()
				local base = {
					"cd $dir &&",
					"gcc $fileName -o",
					"/tmp/$fileNameWithoutExt",
				}
				local exec = {
					"&& /tmp/$fileNameWithoutExt &&",
					"rm /tmp/$fileNameWithoutExt",
				}
				vim.ui.input({ prompt = "Add more args:" }, function(input)
					table.insert(base, 4, input or "")
					require("code_runner.commands").run_from_fn(vim.list_extend(base, exec))
				end)
			end,
		},
	})
end

return M
