local custom_ts = require("custom.treesitter")

return {
  ensure_installed = custom_ts.ensure_installed,

  sync_install = false,

  highlight = { enable = true },
  indent = { enable = true },
}
