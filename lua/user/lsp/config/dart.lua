return {
	on_setup = function(server)
		server:setup({
			capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
			flags = {
				debounce_text_changes = 150,
			},
			on_attach = function(client, bufnr)
				-- 禁用格式化功能，交给专门插件插件处理
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false

				print("dart on_attach")
				local function buf_set_keymap(...)
					vim.api.nvim_buf_set_keymap(bufnr, ...)
				end

        local opts = { noremap = true, silent = true }
        buf_set_keymap("n", "<leader>ft", "<cmd>!dart format %<CR>", opts)
				-- 绑定快捷键
				--require("keybindings").mapLSP(buf_set_keymap)

        -- require("user.lsp.handlers").on_attach(client, bufnr)
			end,
		})
	end,
}
