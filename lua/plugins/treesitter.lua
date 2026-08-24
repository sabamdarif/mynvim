-- Parsers worth having in any project, on top of whatever lua/lang/ asks for.
local base_parsers = { "diff", "printf", "query", "regex", "vim", "vimdoc", "xml", "luadoc", "luap" }

-- Parsers we never start, even when they are installed.
local ignore = { awk = true }

-- Set false to keep Neovim's built-in indent scripts instead.
local ts_indent = true

local function have(lang)
    return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) > 0
end

-- Every parser we want, deduplicated.
local function wanted()
    local seen = {}
    return vim.tbl_filter(function(lang)
        local skip = ignore[lang] or seen[lang]
        seen[lang] = true
        return not skip
    end, vim.iter({ base_parsers, require("lang").treesitter_parsers }):flatten():totable())
end

-- Highlighting and indentation for one buffer, if its parser is installed.
-- Folding comes from the global foldexpr set in base/options.lua.
local function attach(buf)
    if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
        return
    end
    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
    if not lang or ignore[lang] or not have(lang) then
        return
    end
    pcall(vim.treesitter.start, buf, lang)
    if ts_indent and vim.treesitter.query.get(lang, "indents") then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

local function attach_all()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) then
            attach(buf)
        end
    end
end

return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSUpdate", "TSUninstall", "TSLog", "TSInstallAll" },
    config = function()
        local nts = require("nvim-treesitter")
        nts.setup({}) -- `main` branch: only `install_dir` is configurable

        local available = {}
        for _, lang in ipairs(nts.get_available()) do
            available[lang] = true
        end

        -- Install whichever of `langs` is missing, then run `done`.
        local function install(langs, done)
            langs = vim.tbl_filter(function(lang)
                return available[lang] and not have(lang)
            end, langs)
            if #langs == 0 then
                return
            end
            vim.notify("treesitter: installing " .. table.concat(langs, ", "))
            nts.install(langs, { summary = true }):await(function()
                vim.schedule(done or attach_all)
            end)
        end

        install(wanted())

        -- Attach on every buffer, installing on demand (replaces `auto_install`).
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter_attach", { clear = true }),
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
                if not lang or ignore[lang] then
                    return
                end
                if have(lang) then
                    attach(ev.buf)
                else
                    install({ lang }, function()
                        attach(ev.buf)
                    end)
                end
            end,
        })

        attach_all()

        vim.api.nvim_create_user_command("TSInstallAll", function()
            install(wanted())
        end, { desc = "Install treesitter parsers for the enabled languages" })
    end,
}
