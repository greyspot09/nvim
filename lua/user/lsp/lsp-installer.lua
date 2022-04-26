local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("nvim-lspconfig not found!")
  print( "nvim-lspconfig not found!")
  return
end


-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
	sumneko_lua = require("user.lsp.config.lua"), -- lua/lsp/config/lua.lua
	html = require("user.lsp.config.html"),
	cssls = require("user.lsp.config.css"),
	jsonls = require("user.lsp.config.json"),
	dartls = require("user.lsp.config.dart"),
}
-- 自动安装 Language Servers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

lsp_installer.on_server_ready(function(server)
	local config = servers[server.name]
	if config == nil then
		return
	end
	if config.on_setup then
		config.on_setup(server)
	else
		server:setup({})
	end
end)


--local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
--if not status_ok then
--  vim.notify("nvim-lspconfig not found!")
--  return
--end
--
---- Register a handler that will be called for all installed servers.
---- Alternatively, you may also register handlers on specific server instances instead (see example below).
--lsp_installer.on_server_ready(function(server)
--  local opts = {
--    on_attach = require("user.lsp.handlers").on_attach,
--    capabilities = require("user.lsp.handlers").capabilities,
--  }
--
--  if server.name == "clangd" then
--    local clangd_opts = require("user.lsp.settings.clangd")
--    opts = vim.tbl_deep_extend("force", clangd_opts, opts)
--  end
--
--  if server.name == "jsonls" then
--    local jsonls_opts = require("user.lsp.settings.jsonls")
--    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
--  end
--
--  if server.name == "sumneko_lua" then
--    local sumneko_opts = require("user.lsp.settings.sumneko_lua")
--    opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
--  end
--
--  if server.name == "pyright" then
--    local pyright_opts = require("user.lsp.settings.pyright")
--    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
--  end
--
--  -- This setup() function is exactly the same as lspconfig's setup function.
--  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--  server:setup(opts)
--end)
