local actions = require("session-plugin.actions")

local autocmds = {}

-- Start autosaving the session
-- @param session_dir string: The directory where the session file will be saved
-- @param delimiter string: The delimiter to use in the session file name
-- @param events table: The events to trigger the autosave
autocmds.start_autosave = function(session_dir, delimiter, events)
    vim.api.nvim_create_autocmd(events, {
        desc = "Save session on exit",
        group = vim.api.nvim_create_augroup("session-plugin", { clear = true }),
        callback = function()
            actions.save(session_dir, actions.get_session_file_path(session_dir, delimiter))
        end,
    })
end

-- Stop autosaving the session
autocmds.stop_autosave = function()
    vim.api.nvim_clear_autocmds({ group = "session-plugin" })
end

return autocmds
