---@diagnostic disable: undefined-field

--[[
--
-- You can ignore this file, it's just for goofy shenanigans
-- related to misery.nvim, not towards my real config
--
--]]
local config_dir = vim.fn.stdpath("config")
local misery_path = config_dir .. "/lua/misery.nvim"

if not vim.uv.fs_stat(misery_path .. "/plugin/misery.lua") then
  return
end

vim.opt.rtp:append(misery_path)
vim.opt.rtp:append(config_dir .. "/lua/websocket.nvim")

vim.cmd.source(misery_path .. "/plugin/misery.lua")

vim.keymap.set("n", "<space>fm", function()
  require("telescope.builtin").find_files { cwd = misery_path }
end)
