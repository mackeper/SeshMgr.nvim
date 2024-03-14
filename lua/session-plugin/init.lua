local M = {}

-- Default configuration
local config = {
    session_dir = vim.fn.stdpath("data") .. "/sessions",
    session_name_delimiter = "_-_",

    autosave_events = { "BufEnter", "BufLeave", "VimLeavePre", "ExitPre" },
    autosave = true,
}

M._setup_commands = function()
    local commands = require("session-plugin.commands")

    commands.setup_save()
    commands.setup_load()
    commands.setup_load_last(config.session_dir)
    commands.setup_delete()
    commands.setup_list(config.session_dir)
end

M._setup_autocmds = function()
    local autocmds = require("session-plugin.autocmds")

    if config.autosave then
        autocmds.start_autosave(config.session_dir, config.autosave_events)
    end
end

-- Setup the plugin
-- @param opts table: Options to override the default configuration
M.setup = function(opts)
    opts = opts or {}

    -- Merging the user's configuration with the default configuration
    vim.tbl_deep_extend("force", {}, config, opts)

    print("hello")
end

return M
