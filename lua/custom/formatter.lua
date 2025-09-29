return {
	lua = { "stylua" },
	css = { "prettierd" },
	html = { "prettierd" },
	javascript = { "prettierd" },
	-- Option 1: Configure ruff with specific args to disable unused import removal
	python = {
		{
			"ruff",
			args = { "format", "--stdin-filename", "$FILENAME", "--ignore", "F401" },
		},
	},
	sh = { "shfmt" },
	bash = { "shfmt" },
	json = { "prettierd" },
	yaml = { "prettierd" },
	-- xml = { "xmlformatter" },
}
