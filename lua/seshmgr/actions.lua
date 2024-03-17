local util = require("seshmgr.util")

local actions = {}

-- Load a session
-- @param session_file_path string: The path to the session file
actions.load_session = function(session_file_path)
    vim.cmd("source " .. session_file_path)
end

-- Load the last session
-- @param session_dir string: The directory where the session file will be saved
actions.load_last = function(session_dir)
    local sessions = actions.get_sessions(session_dir)

    local last_session = nil
    local last_time = 0
    for _, session in ipairs(sessions) do
        if session.time > last_time then
            last_time = session.time
            last_session = session
        end
    end

    if last_session then
        actions.load_session(last_session.path)
    end
end

-- Save the current session
-- @param session_dir string: The directory where the session file will be saved
-- @param session_file_name string: The name of the session file
actions.save_session = function(session_dir, session_file_name)
    if vim.bo.filetype == "gitcommit" then
        return
    end

    if vim.fn.isdirectory(session_dir) == 0 then
        vim.fn.mkdir(session_dir, "p")
    end

    vim.cmd("mksession! " .. session_file_name)
end

-- Delete a session
-- @param session_file_path string: The path to the session file
actions.delete_session = function(session_file_path)
    vim.fn.delete(session_file_path)
end

-- Check if a session file exists
-- @param session_file_path string: The path to the session file
-- @return boolean: Whether the session file exists
actions.session_exists = function(session_file_path)
    return vim.fn.filereadable(session_file_path) == 1
end

-- Get all the sessions
-- @param session_dir string: The directory where the session files are saved
-- @return table: A list of sessions
actions.get_sessions = function(session_dir)
    local session_files = vim.fn.readdir(session_dir)
    local sessions = {}
    for _, session_file in ipairs(session_files) do
        local session_file_path = session_dir .. "/" .. session_file
        table.insert(sessions, {
            name = session_file,
            path = session_file_path,
            time = vim.fn.getftime(session_file_path),
            readable_time = vim.fn.strftime("%d-%m-%Y %H:%M", vim.fn.getftime(session_file_path)),
        })
    end
    return sessions
end

-- Get the session file path
-- @param session_dir string: The directory where the session file will be saved
-- @param delimiter string: The delimiter to use in the session file name
-- @return string: The path to the session file
actions.get_session_file_path = function(session_dir, delimiter)
    return session_dir .. "/" .. util.get_encoded_cwd(delimiter) .. ".vim"
end

return actions
