return {
	{
		"dmmulroy/tsc.nvim",
		ft = { "typescript", "typescriptreact" },
		config = function()
			require("tsc").setup({
				auto_open_qflist = true,
				auto_close_qflist = false,
				auto_focus_qflist = false,
				auto_start_watch_mode = false,
				use_trouble_qflist = false,
				use_diagnostics = true,
				run_as_monorepo = false,
				enable_progress_notifications = true,
				enable_error_notifications = true,
				flags = {
					noEmit = true,
					project = function()
						local util = require("tsc.utils")
						return util.find_nearest_tsconfig()
					end,
					watch = false,
				},
				hide_progress_notifications_from_history = true,
				spinner = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" },
				pretty_errors = true,
			})

			vim.keymap.set('n', '<leader>to', ':TSCOpen<CR>')
			vim.keymap.set('n', '<leader>tc', ':TSCClose<CR>')
		end,
	},
}
