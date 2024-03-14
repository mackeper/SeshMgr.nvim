local util = {}

-- Get the current working directory but with a different delimiter
-- @param delimiter string: The delimiter to use in the encoded cwd
util.get_encoded_cwd = function(delimiter)
    return vim.fn.substitute(vim.fn.getcwd(), "/", delimiter, "g")
end

-- Get the session file path with the original delimiter
-- @param encoded_cwd string: The encoded cwd
-- @param delimiter string: The delimiter to use in the session file name
util.get_decoded_session_file_path = function(encoded_cwd, delimiter)
    return vim.fn.substitute(encoded_cwd, delimiter, "/", "g")
end

return util
