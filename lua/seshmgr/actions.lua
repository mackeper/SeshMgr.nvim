local util = require("seshmgr.util")

--- *SeshMgr.action*
---
---@usage `require("seshmgr.actions")`

local actions = {}

--- Load a session
---
---@param session_file_path string The path to the session file
---
---@return boolean Whether the session was loaded
actions.load_session = function(session_file_path)
    if not actions.session_exists(session_file_path) then
        return false
    end
    vim.cmd("source " .. session_file_path)
    return true
end

--- Load the last session
---
---@param session_dir string The directory where the session files are saved
---
---@return boolean Whether the last session was loaded
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
        return true
    end
    return false
end

--- Load the current session
---
---@param session_dir string The directory where the session files are saved
---@param delimiter string The delimiter used in the session file path.
---@param windows_drive_delimiter string The delimiter used in the session file path for Windows drives.
---@return boolean Returns true if the session exists and is successfully loaded, false otherwise.
actions.load_current = function(session_dir, delimiter, windows_drive_delimiter)
    local session_file_path = actions.get_session_file_path(session_dir, delimiter, windows_drive_delimiter)
    if actions.session_exists(session_file_path) then
        actions.load_session(session_file_path)
        return true
    end
    return false
end

--- Save the current session
---
---@param session_dir string The directory where the session file will be saved
---@param session_file_path string The path to the session file
---
---@return boolean Whether the session was saved
actions.save_session = function(session_dir, session_file_path)
    if vim.bo.filetype == "gitcommit" then
        return false
    end

    if vim.fn.isdirectory(session_dir) == 0 then
        vim.fn.mkdir(session_dir, "p")
    end

    vim.cmd("mksession! " .. session_file_path)
    return true
end

--- Delete a session
---
---@param session_file_path string The path to the session file
actions.delete_session = function(session_file_path)
    vim.fn.delete(session_file_path)
end

--- Check if a session file exists
---
---@param session_file_path string The path to the session file
---
---@return boolean Whether the session file exists
actions.session_exists = function(session_file_path)
    return vim.fn.filereadable(session_file_path) == 1
end

--- Get all the sessions
---
---@param session_dir string The directory where the session files are saved
---
---@return table A list of sessions with name, path, time, and readable_time
actions.get_sessions = function(session_dir)
    if vim.fn.isdirectory(session_dir) == 0 then
        return {}
    end
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

--- Get the session file path
---
---@param session_dir string The directory where the session file will be saved
---@param delimiter string The delimiter to use in the session file name
---@param windows_drive_delimiter string The delimiter to use in the session file name for Windows drives
---@return string The path to the session file
actions.get_session_file_path = function(session_dir, delimiter, windows_drive_delimiter)
    return session_dir .. util._get_env_delimiter() .. util._get_encoded_cwd(delimiter, windows_drive_delimiter) .. ".vim"
end

return actions
