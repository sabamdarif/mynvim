-- nvim-treesitter `main` branch.
-- Unlike the old `master` branch, setup() accepts ONLY `install_dir`: there is no
-- `ensure_installed`, `auto_install`, `highlight` or `incremental_selection`.
-- Installing parsers and starting the highlighter are therefore done explicitly here.

local base_parsers = {
    "diff",
    "printf",
    "query",
    "regex",
    "vim",
    "vimdoc",
    "xml",
    "luadoc",
    "luap",
}

local ignore = { awk = true }

-- A parser is usable if it is on the rtp: either installed by nvim-treesitter
-- into its install_dir, or bundled with Neovim itself (c, lua, markdown, query,
-- vim, vimdoc). Checking the rtp avoids reinstalling the bundled ones.
local function parser_present(lang)
    return #vim.api.nvim_get_runtime_file("parser/" .. lang .. ".*", false) > 0
end

-- Every parser this config wants, from the base list + enabled languages.
local function wanted_parsers()
    local wanted = vim.deepcopy(base_parsers)
    vim.list_extend(wanted, require("lang").treesitter_parsers or {})

    local seen, out = {}, {}
    for _, lang in ipairs(wanted) do
        if not seen[lang] and not ignore[lang] then
            seen[lang] = true
            table.insert(out, lang)
        end
    end
    return out
end

-- Turn on treesitter highlighting (and treesitter-based folds/indent) for a buffer.
local function start(bufnr)
    if not vim.api.nvim_buf_is_valid(bufnr) or vim.bo[bufnr].buftype ~= "" then
        return
    end
    local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
    if not lang or ignore[lang] or not parser_present(lang) then
        return
    end
    pcall(vim.treesitter.start, bufnr, lang)
end

local function start_all_loaded()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
            start(bufnr)
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

        -- Install any wanted parser that isn't usable yet, then highlight.
        local missing = vim.tbl_filter(function(lang)
            return available[lang] and not parser_present(lang)
        end, wanted_parsers())

        if #missing > 0 then
            vim.notify("treesitter: installing " .. #missing .. " parsers: " .. table.concat(missing, ", "), vim.log.levels.INFO)
            nts.install(missing, { summary = true }):await(function()
                vim.schedule(start_all_loaded)
            end)
        end

        -- Highlight every buffer, installing on demand (replaces `auto_install`).
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
                if not lang or ignore[lang] then
                    return
                end
                if parser_present(lang) then
                    start(ev.buf)
                elseif available[lang] then
                    nts.install({ lang }):await(function()
                        vim.schedule(function()
                            start(ev.buf)
                        end)
                    end)
                end
            end,
        })

        -- This plugin loads on BufReadPost, after FileType already fired for the
        -- first buffer, so cover what is already open.
        start_all_loaded()

        vim.api.nvim_create_user_command("TSInstallAll", function()
            nts.install(wanted_parsers(), { summary = true }):await(function()
                vim.schedule(start_all_loaded)
            end)
        end, { desc = "Install all treesitter parsers for enabled languages" })
    end,
}
