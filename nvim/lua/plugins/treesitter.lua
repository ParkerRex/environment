return {
  "nvim-treesitter/nvim-treesitter",
    branch = "master",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require'nvim-treesitter.configs'.setup {
      ensure_installed = {
        "bash", "c", "cpp", "css", "dockerfile", "go", "html", "java",
        "javascript", "json", "lua", "markdown", "markdown_inline", "python",
        "regex", "ruby", "rust", "sql", "toml", "tsx", "typescript", "vim",
        "vimdoc", "xml", "yaml"
      },
      highlight = {
        enable = true,
        --[[ disable = { "embedded_template" } ]]
      },
      indent = {
        enable = true
      },
      matchup = {
        enable = true
      }
    }
  end,
}
