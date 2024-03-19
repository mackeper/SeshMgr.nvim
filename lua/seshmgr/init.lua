--- *seshmgr.nvim* Neovim session management plugin
--- *SeshMgr*
---
--- MIT License Copyright (c) 2024 Marcus Östling
--- ==============================================================================

local SeshMgr = {}

--- Plugin configuration
--
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
---@text # Options ~
SeshMgr.config = {
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",

    session_dir = vim.fn.stdpath("data") .. "/sessions",
    session_name_delimiter = "*",

    autosave_events = { "ExitPre" },
    autosave = true,

    telescope = {
        enabled = true,
        keymap = "<leader>js",
    },
}

-- Setup the commands
SeshMgr._setup_commands = function()
    local commands = require("seshmgr.commands")

    commands._setup_session_save(SeshMgr.config.session_dir, SeshMgr.config.session_name_delimiter)
    commands._setup_session_load()
    commands._setup_session_load_last(SeshMgr.config.session_dir)
    commands._setup_session_delete()
    commands._setup_session_delete_current(SeshMgr.config.session_dir, SeshMgr.config.session_name_delimiter)
    commands._setup_session_list(SeshMgr.config.session_dir)
end

-- Setup the autocmds
SeshMgr._setup_autocmds = function()
    local autocmds = require("seshmgr.autocmds")

    if SeshMgr.config.autosave then
        autocmds.start_autosave(
            SeshMgr.config.session_dir,
            SeshMgr.config.session_name_delimiter,
            SeshMgr.config.autosave_events
        )
    end

    -- autocmds.setup_nvimtree_fix()
end

-- Setup the keymaps
SeshMgr._setup_keymaps = function()
    if SeshMgr.config.telescope.enabled then
        local telescope = require("seshmgr.telescope")
        telescope.setup_keymaps(
            SeshMgr.config.telescope.keymap,
            SeshMgr.config.session_dir,
            SeshMgr.config.session_name_delimiter
        )
    end
end

--- Setup the plugin
---
---@param opts table Options to override the default configuration
---
---@usage `require("seshmgr").setup({})` (replace `{}` with your `configuration`)
SeshMgr.setup = function(opts)
    opts = opts or {}

    -- Merging the user's configuration with the default configuration
    SeshMgr.config = vim.tbl_deep_extend("force", {}, SeshMgr.config, opts)

    vim.o.sessionoptions = SeshMgr.config.sessionoptions

    SeshMgr._setup_commands()
    SeshMgr._setup_autocmds()
    SeshMgr._setup_keymaps()
end

return SeshMgr
