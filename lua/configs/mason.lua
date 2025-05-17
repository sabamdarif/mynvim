return {
	PATH = "skip",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},

	-- Where Mason should put its installed bins
	install_root_dir = vim.fn.stdpath("data") .. "/mason",
	max_concurrent_installers = 10,
	-- Registries available for packages
	registries = {
		"github:mason-org/mason-registry",
	},

	providers = {
		"mason.providers.registry-api",
		"mason.providers.client",
	},
	log_level = vim.log.levels.INFO,
	ensure_installed = require("custom.language-servers").servers,
}
