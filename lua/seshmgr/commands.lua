local actions = require("seshmgr.actions")

--- *SeshMgr.commands*
---
---   - `:SessionSave` - Save the current session by current working directory (cwd).
---   - `:SessionLoad {session_full_path}` - Load the given session path.
---   - `:SessionLoadLast` - Load the last session.
---   - `:SessionDelete {session_full_path}` - Delete the given session.
---   - `:SessionDeleteCurrent` - Delete the file associated with the current session.
---   - `:SessionList` - List all session files.
---
---@usage `require("seshmgr.commands")`

local commands = {}

-- Setup the save command
--
--@param session_dir string: The directory where the session file will be saved
--@param delimiter string: The delimiter to use in the session file name
--@param windows_drive_delimiter string: The delimiter to use in the session file name for Windows drives
commands._setup_session_save = function(session_dir, delimiter, windows_drive_delimiter)
    vim.api.nvim_create_user_command("SessionSave", function()
        actions.save_session(session_dir, actions.get_session_file_path(session_dir, delimiter, windows_drive_delimiter))
    end, { nargs = 0 })
end

-- Setup the load command
-- The command will take a single argument, the path of the session file to load
commands._setup_session_load = function()
    vim.api.nvim_create_user_command("SessionLoad", function(args)
        actions.load_session(args.args)
    end, { nargs = 1 })
end

-- Setup the load last command
--
--@param session_dir string: The directory where the session file is saved
commands._setup_session_load_last = function(session_dir)
    vim.api.nvim_create_user_command("SessionLoadLast", function()
        actions.load_last(session_dir)
    end, { nargs = 0 })
end

-- Setup the load current command
-- The command will take a single argument, the path of the session file to load
--
-- @param session_dir string: The directory where the session file is saved
-- @param delimiter string: The delimiter to use in the session file name
-- @param windows_drive_delimiter string: The delimiter to use in the session file name for Windows drives
commands._setup_session_load_current = function(session_dir, delimiter, windows_drive_delimiter)
    vim.api.nvim_create_user_command("SessionLoadCurrent", function()
        actions.load_current(session_dir, delimiter, windows_drive_delimiter)
    end, { nargs = 0 })
end

-- Setup the delete command
-- The command will take a single argument, the path of the session file to delete
commands._setup_session_delete = function()
    vim.api.nvim_create_user_command("SessionDelete", function(args)
        actions.delete_session(args.args)
    end, { nargs = 1 })
end

-- Setup the delete current command
--
--@param session_dir string: The directory where the session file will be saved
--@param delimiter string: The delimiter to use in the session file name
--@param windows_drive_delimiter string: The delimiter to use in the session file name for Windows drives
commands._setup_session_delete_current = function(session_dir, delimiter, windows_drive_delimiter)
    vim.api.nvim_create_user_command("SessionDeleteCurrent", function()
        actions.delete_session(actions.get_session_file_path(session_dir, delimiter, windows_drive_delimiter))
    end, { nargs = 0 })
end

-- Setup the list command
--
--@param session_dir string: The directory where the session files are saved
commands._setup_session_list = function(session_dir)
    vim.api.nvim_create_user_command("SessionList", function()
        local sessions = actions.get_sessions(session_dir)
        for _, session in ipairs(sessions) do
            print(session.name .. "   " .. session.readable_time)
        end
    end, { nargs = 0 })
end

return commands
