return {
	{
		"folke/which-key.nvim",
		keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
		cmd = "WhichKey",
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.add({
				{ "<leader>f", group = "Find" },
				{ "<leader>t", group = "TypeScript" },
				{ "<leader>to", desc = "TSC Open" },
				{ "<leader>tc", desc = "TSC Close" },
				{ "<leader>e", desc = "Show diagnostic error messages" },
				{ "<leader>q", desc = "Open diagnostic quickfix list" },
				{ "g", group = "Go to" },
				{ "gd", desc = "Go to Definition" },
				{ "gr", desc = "Go to References" },
				{ "gi", desc = "Go to Implementation" },
				{ "gt", desc = "Go to Type Definition" },
				{ "[d", desc = "Go to previous diagnostic" },
				{ "]d", desc = "Go to next diagnostic" },
			})
		end,
	},
}
