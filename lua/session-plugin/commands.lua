local actions = require("session-plugin.actions")

local commands = {}

-- Setup the save command
-- @param session_dir string: The directory where the session file will be saved
-- @param delimiter string: The delimiter to use in the session file name
commands.setup_save = function(session_dir, delimiter)
    vim.api.nvim_create_user_command("SessionSave", function()
        actions.save(session_dir, actions.get_session_file_path(session_dir, delimiter))
    end, { nargs = 0 })
end

-- Setup the load command
-- The command will take a single argument, the name of the session file to load
commands.setup_load = function()
    vim.api.nvim_create_user_command("SessionLoad", function(args)
        print(vim.inspect(args))
        print(vim.inspect(args.args))
        actions.load(args.args)
    end, { nargs = 1 })
end

-- Setup the load last command
-- @param session_dir string: The directory where the session file will be saved
commands.setup_load_last = function(session_dir)
    vim.api.nvim_create_user_command("SessionLoadLast", function()
        actions.load_last(session_dir)
    end, { nargs = 0 })
end

-- Setup the delete command
-- The command will take a single argument, the name of the session file to delete
commands.setup_delete = function()
    vim.api.nvim_create_user_command("SessionDelete", function(args)
        actions.delete(args.args)
    end, { nargs = 1 })
end

-- Setup the delete current command
-- @param session_dir string: The directory where the session file will be saved
-- @param delimiter string: The delimiter to use in the session file name
commands.setup_delete_current = function(session_dir, delimiter)
    vim.api.nvim_create_user_command("SessionDeleteCurrent", function()
        actions.delete(actions.get_session_file_path(session_dir, delimiter))
    end, { nargs = 0 })
end

-- Setup the list command
-- @param session_dir string: The directory where the session files are saved
commands.setup_list = function(session_dir)
    vim.api.nvim_create_user_command("SessionList", function()
        local sessions = actions.get_sessions(session_dir)
        for _, session in ipairs(sessions) do
            print(session.name .. " - " .. session.readable_time)
        end
    end, { nargs = 0 })
end

return commands
