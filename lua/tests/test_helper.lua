local test_helper = {}

test_helper._is_windows = function()
    return vim.fn.has("win32") == 1
end

test_helper._remove_dir = function(file_path)
    if test_helper._is_windows() then
        os.execute("rmdir " .. file_path)
    else
        os.execute("rmdir " .. file_path)
    end
end

test_helper._remove_file = function(file_path)
    if test_helper._is_windows() then
        os.execute("del " .. file_path)
    else
        os.execute("rm " .. file_path)
    end
end

return test_helper
