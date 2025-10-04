-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                         NEOVIM SETTINGS                                      ║
-- ║                                                                              ║
-- ║  Centralized configuration for colorscheme and language support              ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝

return {
    -- ═══════════════════════════════════════════════════════════════════════════
    --                           COLORSCHEME SELECTION
    -- ═══════════════════════════════════════════════════════════════════════════
    -- Uncomment the colorscheme you want to use (only one at a time)

    colorscheme = "tokyodark",
    -- colorscheme = "catppuccin",
    -- colorscheme = "nightfox",
    -- colorscheme = "gruvbox",

    -- ═══════════════════════════════════════════════════════════════════════════
    --                         LANGUAGE CONFIGURATION
    -- ═══════════════════════════════════════════════════════════════════════════
    --          Add or remove languages here
    -- Each language folder in lua/lang/ contains:
    --   - <lang>.lua: LSP servers, formatters, treesitter parsers
    --   - plugins.lua: Language-specific plugins (optional)
    --
    -- To enable a language: Add it to the list below
    -- To disable a language: Comment it out or remove it

    languages = {
        "bash",
        "git",
        "python",
        "javascript",
        "html",
        "css",
        "markdown",
        "lua",
        -- "c",
    },
}
