-- Plugin manager: lazy.nvim
-- We need lazy to install minimal amount of plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy_minimal_init/lazy.nvim"
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
local lazy_opts = {
    root = vim.fn.stdpath("data") .. "/lazy_minimal_init",
}

local plugins = {
    "nvim-lua/plenary.nvim",
    {
        "echasnovski/mini.doc",
        config = function()
            require("mini.doc").setup({})
        end,
    },
}

require("lazy").setup(plugins, lazy_opts)
