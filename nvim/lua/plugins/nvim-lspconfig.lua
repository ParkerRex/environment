local M = {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    { "saghen/blink.cmp" },
  },
}

function M.on_attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  
  -- Essential mappings
  vim.keymap.set('n', '<leader>a', function() Snacks.picker.lsp_code_actions() end, bufopts)
  vim.keymap.set('v', '<leader>a', function() Snacks.picker.lsp_code_actions() end, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  
  -- Optional but useful
  vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
end

function M.config()
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  local capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }
  vim.diagnostic.config({
    virtual_text = false,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
  })



  require("mason").setup({
    ui = {
      border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
      }
    }
  })
  mason_lspconfig.setup {
    ensure_installed = {
      'html',
      'ts_ls',
      'cssls',
      'dockerls',
      'jsonls',
      'vimls',
      'clangd',
      'pyright',
      'bashls',
    },
    handlers = {
      -- The first entry (without a key) will be the default handler
      -- and will be called for each installed server that doesn't have
      -- a dedicated handler.
      function(server_name)  -- default handler (optional)
        lspconfig[server_name].setup {
          on_attach = M.on_attach,
          capabilities,
        }
      end,
      ["html"] = function()
        lspconfig.html.setup({
          on_attach = M.on_attach,
          capabilities,
          filetypes = { "html" }
        })
      end,
      ["jsonls"] = function(server_name)
        lspconfig.jsonls.setup({
          on_attach = M.on_attach,
          capabilities,
          commands = {
            Format = {
              function()
                vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
              end
            }
          }
        })
      end,
    }
  }
end

return M
