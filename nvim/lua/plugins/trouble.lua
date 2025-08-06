return {
  "folke/trouble.nvim",
  event = 'VeryLazy',
  keys = {
    { "<leader>tt",  ":Trouble todo filter = { tag = {TODO} }<CR>",      desc = "Trouble TODO" },
    { "<leader>tf",  ":Trouble todo filter = { tag = {FIX,FIXME} }<CR>", desc = "Trouble FIX" },
    { "<leader>tn",  ":Trouble todo filter = { tag = {NOTE} }<CR>",      desc = "Trouble NOTE" },
    { "<leader>tr",  "<cmd>Trouble diagnostics toggle<cr>",              desc = "Toggle diagnostics" },
    { "<leader>tw",  "<cmd>Trouble diagnostics toggle<cr>",              desc = "Toggle workspace diagnostics" },
    { "<leader>td",  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Toggle buffer diagnostics" },
    { "<leader>tll", "<cmd>Trouble loclist toggle<cr>",                  desc = "Toggle loclist" },
    { "<leader>tq",  "<cmd>Trouble qflist toggle<cr>",                   desc = "Toggle quickfix" },
    { "<leader>tl",  "<cmd>Trouble lsp toggle<cr>",                      desc = "Toggle LSP references" }
  },
  opts = {},
  specs = {
    "folke/snacks.nvim",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts or {}, {
        picker = {
          actions = require("trouble.sources.snacks").actions,
          sources = {
            files = {
              hidden = true,
              ignored = false,
              exclude = { "node_modules/**", ".next/**", ".git/**", ".turbo/**" },
            },
          },
          win = {
            input = {
              keys = {
                ["<c-t>"] = {
                  "trouble_open",
                  mode = { "n", "i" },
                },
              },
            },
          },
        },
      })
    end,
  },
}
