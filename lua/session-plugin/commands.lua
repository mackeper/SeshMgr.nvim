local actions = require("session-plugin.actions")

local commands = {}

commands.setup_save = function()
    vim.api.nvim_create_user_command("SessionSave", function()
        actions.save(actions.get_session_file())
    end, { nargs = 0 })
end

commands.setup_load = function()
    vim.api.nvim_create_user_command("SessionLoad", function()
        actions.load(actions.get_session_file())
    end, { nargs = 0 })
end

commands.setup_load_last = function(session_dir)
    vim.api.nvim_create_user_command("SessionLoadLast", function()
        actions.load_last(session_dir)
    end, { nargs = 0 })
end

commands.setup_delete = function()
    vim.api.nvim_create_user_command("SessionDelete", function()
        actions.delete(actions.get_session_file())
    end, { nargs = 0 })
end

commands.setup_list = function(session_dir)
    vim.api.nvim_create_user_command("SessionList", function()
        local sessions = actions.get_sessions(session_dir)
        for _, session in ipairs(sessions) do
            print(session.name .. " - " .. session.readable_time)
        end
    end, { nargs = 0 })
end

return commands
