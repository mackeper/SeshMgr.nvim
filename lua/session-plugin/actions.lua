local actions = {}

local function Get_encoded_cwd(delimiter)
    return vim.fn.substitute(vim.fn.getcwd(), "/", delimiter, "g")
end

local function Get_decoded_session_file_path(encoded_cwd, delimiter)
    return vim.fn.substitute(encoded_cwd, delimiter, "/", "g")
end

actions.load = function(session_file_path)
    vim.cmd("source " .. session_file_path)
end

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
        actions.load(last_session.path)
    end
end

actions.save = function(session_dir, session_file_name)
    if vim.fn.isdirectory(session_dir) == 0 then
        vim.fn.mkdir(session_dir, "p")
    end

    vim.cmd("mksession! " .. session_file_name)
end

actions.delete = function(session_file_path)
    vim.fn.delete(session_file_path)
end

actions.exists = function(session_file_path)
    return vim.fn.filereadable(session_file_path) == 1
end

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

actions.get_session_file = function(session_dir)
    return session_dir .. "/" .. Get_encoded_cwd() .. ".vim"
end

return actions
