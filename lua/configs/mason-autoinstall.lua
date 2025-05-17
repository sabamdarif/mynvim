local M = {}

-- Read the configuration from custom/mason-packs.lua
local function get_config_packages()
	local status_ok, mason_packs = pcall(require, "custom.mason-packs")
	if not status_ok then
		-- Try loading from the root directory
		status_ok, mason_packs = pcall(require, "mason-packs")
		if not status_ok then
			print("Failed to load mason-packs.lua configuration")
			return {}
		end
	end

	-- If ensure_installed field exists, return it, otherwise empty table
	return mason_packs.ensure_installed or {}
end

-- Get packages to be installed
M.get_packages = function()
	-- Get packages directly from mason-packs.lua
	-- These are already in the correct format for Mason to understand
	local packages = get_config_packages()

	-- Remove duplicates if any
	local unique_packages = {}
	local seen = {}
	for _, pkg in ipairs(packages) do
		if not seen[pkg] then
			seen[pkg] = true
			table.insert(unique_packages, pkg)
		end
	end

	return unique_packages
end

-- Install all required packages
M.install_all = function()
	local mr = require("mason-registry")

	-- Refresh the registry first
	mr.refresh(function()
		local packages = M.get_packages()
		local to_install = {}

		-- Check which packages need to be installed
		for _, package_name in ipairs(packages) do
			-- Check if Mason can install this package
			if mr.has_package(package_name) then
				local pkg = mr.get_package(package_name)
				if not pkg:is_installed() then
					table.insert(to_install, package_name)
				end
			else
				print("Warning: Mason doesn't have package: " .. package_name)
			end
		end

		if #to_install > 0 then
			-- Install the packages using MasonInstall command
			vim.cmd("MasonInstall " .. table.concat(to_install, " "))
			print("Mason: Installing " .. #to_install .. " packages")
		else
			print("Mason: All packages already installed")
		end
	end)
end

-- Create the command
vim.api.nvim_create_user_command("MasonInstallAll", function()
	M.install_all()
end, {})

return M
