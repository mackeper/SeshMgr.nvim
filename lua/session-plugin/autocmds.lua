local actions = require("session-plugin.actions")

local autocmds = {}

-- Start autosaving the session on exit
-- @param session_dir string: The directory where the session file will be saved
autocmds.start_autosave = function(session_dir, events)
    vim.api.nvim_create_autocmd(events, {
        desc = "Save session on exit",
        group = vim.api.nvim_create_augroup("session-plugin", { clear = true }),
        callback = function()
            actions.save(actions.get_session_file(session_dir))
        end,
    })
end

autocmds.stop_autosave = function()
    vim.api.nvim_clear_autocmds({ group = "session-plugin" })
end

return autocmds
