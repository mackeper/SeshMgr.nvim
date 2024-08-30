local util = {}

-- Private configuration
util._config = {
    linux = {
        delimiter = "/",
    },
    windows = {
        delimiter = "\\",
        windows_drive_delimiter = ":"
    }
}

-- Check if the current OS is Windows
util._is_Windows = function()
    return vim.fn.has("win32") == 1
end

-- Get the delimiter for the current OS
util._get_env_delimiter = function()
    if util._is_Windows() then
        return util._config.windows.delimiter
    end
    return util._config.linux.delimiter
end

-- Get the current working directory but with a different delimiter
-- @param delimiter string: The delimiter to use in the encoded cwd
util._get_encoded_cwd = function(delimiter, windows_drive_delimiter)
    local encoded_cwd = vim.fn.substitute(vim.fn.getcwd(), util._get_env_delimiter(), delimiter, "g")
    if util._is_Windows() then
        encoded_cwd = vim.fn.substitute(encoded_cwd, util._config.windows.windows_drive_delimiter, windows_drive_delimiter, "g")
    end
    return encoded_cwd
end

-- Get the session file path with the original delimiter
-- @param encoded_cwd string: The encoded cwd
-- @param delimiter string: The delimiter to use in the session file name
util._get_decoded_session_file_path = function(encoded_cwd, delimiter, windows_drive_delimiter)
    local cwd = vim.fn.substitute(encoded_cwd, delimiter, util._get_env_delimiter(), "g")
    if util._is_Windows() then
        cwd = vim.fn.substitute(cwd, windows_drive_delimiter, util._config.windows.windows_drive_delimiter, "g")
    end
    return cwd
end

return util
