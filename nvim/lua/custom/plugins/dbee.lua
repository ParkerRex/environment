-- For now, I'm going to stick with dadbod,
-- but if the completion continues to improve I will probably switch
return {
  {
    "kndndrj/nvim-dbee",
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim" },
    build = function()
      require("dbee").install()
    end,
    config = function()
      -- local source = require "dbee.sources"
      require("dbee").setup {
        sources = {
          -- TODO: Set up Postgres server and add your own database connections here
          -- Example:
          -- local source = require "dbee.sources"
          -- source.MemorySource:new({
          --   {
          --     type = "postgres",
          --     name = "your_db",
          --     url = "postgresql://username:password@localhost:5432/dbname",
          --   },
          -- }, "your_db"),
        },
      }
      require "custom.dbee"
    end,
  },
}
