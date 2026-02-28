return {
  {
    "mizisu/django.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {},
      },
      {
        "saghen/blink.cmp",
        optional = true,
        opts = {
          sources = {
            providers = {
              django = {
                name = "Django",
                module = "django.completions.blink",
                async = true,
              },
            },
            per_filetype = {
              python     = { "django", "lsp", "snippets", "buffer", "path" },
              django     = { "django", "lsp", "snippets", "buffer", "path" },
              htmldjango = { "django", "lsp", "snippets", "buffer", "path" },
            },
          },
        },Next
      },
    },
    config = function()
      require("django").setup({
        views = {
          auto_refresh = {
            on_picker_open = true,
            file_watch_patterns = {
              "*/urls.py",
              "*/views.py",
              "*/view.py",
              "*/*views.py",
              "*/*view.py",
              "*/*viewset.py",
              "*/*view_set.py",
              "*/*api.py",
            },
          },
        },
        models = {
          auto_refresh = {
            on_picker_open = true,
            file_watch_patterns = { "*/models.py", "*/models/*.py" },
          },
        },
        shell = {
          command  = "shell",
          position = "right",
          env      = {},
        },
      })
    end,
  },
}