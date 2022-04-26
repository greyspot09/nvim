-- require("flutter-tools").setup({})

--local ybbond_lsp_on_attach = require("configs/ybbond_lsp_on_attach")
--local lspconfig = require("lspconfig")
--lspconfig.dartls.setup({
--	capabilities = ybbond_lsp_capabilities,
--	on_attach = ybbond_lsp_on_attach,
--	cmd = {
--		"/Users/yoha/fvm/versions/2.5.0/bin/dart",
--		"/Users/yohanesbandung/fvm/versions/2.5.0/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot",
--		"--lsp",
--	},
--})

local flutter_lsp_on_attach = function(client, bufnr)
	-- ybbond_lsp_on_attach(client, bufnr)

	print("ybbond_flutter_lsp_on_attach")

	local function buf_set_keymap(l, r, c)
		vim.api.nvim_buf_set_keymap(bufnr, l, r, c, { noremap = true, silent = true })
	end

	buf_set_keymap("n", "<Leader>ff", '<CMD>lua require("telescope").extensions.flutter.commands()<CR>')
	--buf_set_keymap("n", "<LEADER>t", "<CMD>DartFmt<CR>")

	local flutter_command = require("flutter-tools.utils").command

	flutter_command(
		"FlutterAgentStartStaging",
		[[lua require('flutter-tools.commands').run_command('--flavor=staging --no-sound-null-safety')]]
	)
	flutter_command(
		"FlutterAgentStartStagingNoPub",
		[[lua require('flutter-tools.commands').run_command('--flavor=staging --no-sound-null-safety --no-pub')]]
	)
	flutter_command(
		"FlutterAgentStartProduction",
		[[lua require('flutter-tools.commands').run_command('--flavor=production --no-sound-null-safety')]]
	)
	flutter_command(
		"FlutterRikuStartStaging",
		[[lua require('flutter-tools.commands').run_command('--flavor=mandiristaging --no-sound-null-safety')]]
	)
	flutter_command(
		"FlutterRikuStartProduction",
		[[lua require('flutter-tools.commands').run_command('--flavor=mandiriproduction --no-sound-null-safety')]]
	)
end

-- alternatively you can override the default configs
require("flutter-tools").setup({
	ui = {
		-- the border type to use for all floating windows, the same options/formats
		-- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
		border = "rounded",
		-- This determines whether notifications are show with `vim.notify` or with the plugin's custom UI
		-- please note that this option is eventually going to be deprecated and users will need to
		-- depend on plugins like `nvim-notify` instead.
		--notification_style = 'native' | 'plugin'
	},
	decorations = {
		statusline = {
			-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
			-- this will show the current version of the flutter app from the pubspec.yaml file
			app_version = false,
			-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
			-- this will show the currently running device if an application was started with a specific
			-- device
			device = false,
		},
	},
	--debugger = {
	--	enabled = true,
	--	register_configurations = function(_)
	--		require("dap").configurations.dart = {}
	--		require("dap.ext.vscode").load_launchjs()
	--	end,
	--},
	--debugger = { -- integrate with nvim dap + install dart code debugger
	--  enabled = false,
	--  run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
	--  register_configurations = function(paths)
	--    require("dap").configurations.dart = {
	--      <put here config that you would find in .vscode/launch.json>
	--    }
	--  end,
	--},
	--flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
	flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
	fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
	widget_guides = {
		enabled = false,
	},
	closing_tags = {
		highlight = "ErrorMsg", -- highlight for the closing tag
		prefix = ">", -- character to use for close tag e.g. > Widget
		enabled = true, -- set to false to disable
	},
	dev_log = {
		enabled = true,
		open_cmd = "edit", -- command to use to open the log buffer
	},
	dev_tools = {
		autostart = true, -- autostart devtools server if not detected
		auto_open_browser = false, -- Automatically opens devtools in the browser
	},
	outline = {
		open_cmd = "30vnew", -- command to use to open the outline buffer
		auto_open = false, -- if true this will open the outline automatically when it is first populated
	},
	lsp = {
		color = { -- show the derived colours for dart variables
			enabled = false, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
			background = false, -- highlight the background
			foreground = false, -- highlight the foreground
			virtual_text = true, -- show the highlight using virtual text
			virtual_text_str = "■", -- the virtual text character to highlight
		},
		on_attach = flutter_lsp_on_attach,
		-- capabilities = my_custom_capabilities -- e.g. lsp_status capabilities
		--- OR you can specify a function to deactivate or change or control how the config is created
		--capabilities = function(config)
		--	config.specificThingIDontWant = false
		--	return config
		--end,
		--settings = {
		--  showTodos = true,
		--  completeFunctionCalls = true,
		--  analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
		--}
	},
})
