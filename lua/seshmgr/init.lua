local M = {}

-- Default configuration
M.config = {
    sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions",

    session_dir = vim.fn.stdpath("data") .. "/sessions",
    session_name_delimiter = "_-_",

    autosave_events = { "ExitPre" },
    autosave = true,

    telescope = {
        enabled = true,
        keymap = "<leader>js",
    },
}

--- Setup the commands
M._setup_commands = function()
    local commands = require("seshmgr.commands")

    commands.setup_save(M.config.session_dir, M.config.session_name_delimiter)
    commands.setup_load()
    commands.setup_load_last(M.config.session_dir)
    commands.setup_delete()
    commands.setup_delete_current(M.config.session_dir, M.config.session_name_delimiter)
    commands.setup_list(M.config.session_dir)
end

-- Setup the autocmds
M._setup_autocmds = function()
    local autocmds = require("seshmgr.autocmds")

    if M.config.autosave then
        autocmds.start_autosave(M.config.session_dir, M.config.session_name_delimiter, M.config.autosave_events)
    end

    -- autocmds.setup_nvimtree_fix()
end

-- Setup the keymaps
M._setup_keymaps = function()
    if M.config.telescope.enabled then
        local telescope = require("seshmgr.telescope")
        telescope.setup_keymaps(M.config.telescope.keymap, M.config.session_dir, M.config.session_name_delimiter)
    end
end

-- Setup the plugin
-- @param opts table: Options to override the default configuration
M.setup = function(opts)
    opts = opts or {}

    -- Merging the user's configuration with the default configuration
    M.config = vim.tbl_deep_extend("force", {}, M.config, opts)

    vim.o.sessionoptions = M.config.sessionoptions

    M._setup_commands()
    M._setup_autocmds()
    M._setup_keymaps()
end

return M