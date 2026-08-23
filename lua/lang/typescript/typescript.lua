-- TypeScript / JavaScript (JS, JSX, TS, TSX) — native TypeScript 7 toolchain.
-- Primary LSP: `tsc` (the "tsgo" server from `@typescript/native-preview`; install
-- per project with `npm i -D @typescript/native-preview`, or `-g`). Fallback LSP:
-- `vtsls` (via Mason) when no `tsgo` is found. The root_dir guards below ensure
-- exactly one of the two attaches per project.

-- Locate a TypeScript 7 (`tsgo`) binary for a project: prefer the project-local
-- install, then fall back to one on $PATH. Returns the binary path, or nil.
local function tsgo_bin(root)
    if root then
        local local_bin = vim.fs.joinpath(root, "node_modules", ".bin", "tsgo")
        if vim.fn.executable(local_bin) == 1 then
            return local_bin
        end
    end
    if vim.fn.executable("tsgo") == 1 then
        return "tsgo"
    end
    return nil
end

-- Nearest project root for a buffer.
local function project_root(bufnr)
    return vim.fs.root(bufnr, { "tsconfig.json", "jsconfig.json", "package.json", ".git" }) or vim.uv.cwd()
end

-- Load a server's shipped default config from nvim-lspconfig with a fresh eval,
-- so it is safe to call the original root_dir from inside our override.
local function default_config(name)
    local files = vim.api.nvim_get_runtime_file("lsp/" .. name .. ".lua", false)
    if files[1] then
        local ok, cfg = pcall(dofile, files[1])
        if ok and type(cfg) == "table" then
            return cfg
        end
    end
    return {}
end

-- Cache the resolved tsgo binary per root, so `cmd` reuses what `root_dir` found.
local tsgo_by_root = {}

-- Inlay-hint preferences shared by both servers (VS Code TS schema).
local inlay_hints = {
    parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = true },
    parameterTypes = { enabled = true },
    variableTypes = { enabled = true, suppressWhenTypeMatchesName = true },
    propertyDeclarationTypes = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    enumMemberValues = { enabled = true },
}

return {
    lsp_servers = { "tsc", "vtsls" },

    lsp_config = {
        -- Native TypeScript 7 server (tsgo). Attaches only where a tsgo binary
        -- exists; otherwise stays silent and lets the vtsls fallback take over.
        tsc = {
            cmd = function(dispatchers, config)
                local root = config and config.root_dir
                local bin = (root and tsgo_by_root[root]) or tsgo_bin(root) or "tsgo"
                return vim.lsp.rpc.start({ bin, "--lsp", "--stdio" }, dispatchers)
            end,
            root_dir = function(bufnr, on_dir)
                local root = project_root(bufnr)
                local bin = tsgo_bin(root)
                if not bin then
                    return -- no TS7 binary here: defer to the vtsls fallback
                end
                tsgo_by_root[root] = bin
                on_dir(root)
            end,
            settings = {
                -- namespace used by nvim-lspconfig's bundled tsc config
                ["js/ts"] = {
                    inlayHints = inlay_hints,
                    -- client-side codelens is disabled globally (see lspconfig.lua),
                    -- so don't ask the server to compute them
                    referencesCodeLens = { enabled = false },
                    implementationsCodeLens = { enabled = false },
                },
            },
        },

        -- Fallback server. Bows out whenever a tsgo binary is available, so it
        -- never runs alongside tsc on the same project.
        vtsls = {
            root_dir = function(bufnr, on_dir)
                if tsgo_bin(project_root(bufnr)) then
                    return -- TS7 present: tsc owns this project
                end
                -- Reuse nvim-lspconfig's monorepo/Deno-aware root detection.
                local def = default_config("vtsls").root_dir
                if def then
                    return def(bufnr, on_dir)
                end
                on_dir(project_root(bufnr))
            end,
            settings = {
                typescript = { inlayHints = inlay_hints },
                javascript = { inlayHints = inlay_hints },
                vtsls = {
                    experimental = {
                        completion = {
                            enableServerSideFuzzyMatch = true,
                        },
                    },
                },
            },
        },
    },

    formatters = {
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
    },

    mason_packages = {
        "vtsls",
        "prettier",
    },

    treesitter = { "typescript", "tsx", "javascript", "jsdoc" },
}
