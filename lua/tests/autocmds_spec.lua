local function has_autocmd(autocmd_group, autocmd_event)
    local autocmds = vim.api.nvim_get_autocmds({})
    for _, autocmd in ipairs(autocmds) do
        if autocmd.group_name == autocmd_group and autocmd.event == autocmd_event then
            return true
        end
    end
    return false
end

describe("autocmds", function()
    it("should return a table", function()
        local autocmds = require("seshmgr.autocmds")
        assert(autocmds ~= nil)
    end)

    it("start_autosave should add autocmd", function()
        -- Arrange
        local session_dir = "/tmp"
        local delimiter = "!!"
        local windows_drive_delimiter = ";;"
        local events = { "ExitPre", "BufWritePost", "VimLeavePre" }
        local group_name = "seshmgr.autosave"

        for _, event in ipairs(events) do
            assert(not has_autocmd(group_name, event), string.format("autocmd with event '%s' should not exist", event))
        end

        -- Act
        require("seshmgr.autocmds").start_autosave(session_dir, delimiter, windows_drive_delimiter, events)

        -- Assert
        for _, event in ipairs(events) do
            assert(has_autocmd(group_name, event), string.format("autocmd with event '%s' should exist", event))
        end
    end)

    it("stop_autosave should remove autocmd", function()
        -- Arrange
        local session_dir = "/tmp"
        local delimiter = "!!"
        local windows_drive_delimiter = ";;"
        local events = { "ExitPre", "BufWritePost", "VimLeavePre" }
        local group_name = "seshmgr.autosave"

        require("seshmgr.autocmds").start_autosave(session_dir, delimiter, windows_drive_delimiter, events)

        for _, event in ipairs(events) do
            assert(has_autocmd(group_name, event), string.format("autocmd with event '%s' should exist", event))
        end

        -- Act
        require("seshmgr.autocmds").stop_autosave()

        -- Assert
        for _, event in ipairs(events) do
            assert(not has_autocmd(group_name, event), string.format("autocmd with event '%s' should not exist", event))
        end
    end)
end)
