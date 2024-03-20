-- Plugin manager: lazy.nvim
-- We need lazy to install minimal amount of plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Install plugins
--
-- * nvim-lua/plenary.nvim to run tests
-- * echasnovski/mini.doc to get documentation
--
require("lazy").setup({
    "nvim-lua/plenary.nvim",
    {
        "echasnovski/mini.doc",
        version = false,
        config = function()
            require("mini.doc").setup({})
        end,
    },
})