local function has_command(command_name)
    local commands = vim.api.nvim_get_commands({})
    for _, command in pairs(commands) do
        if command.name == command_name then
            return true
        end
    end
    return false
end

local function test_setup_command(command_name, setup_command)
    -- Arrange
    assert(not has_command(command_name), string.format("command '%s' should not exist", command_name))

    -- Act
    setup_command()

    -- Assert
    assert(has_command(command_name), string.format("command '%s' should exist", command_name))
end

describe("commands", function()
    it("should return a table", function()
        local commands = require("seshmgr.commands")
        assert(commands ~= nil)
    end)

    it("setup_session_save should add SessionSave command", function()
        test_setup_command("SessionSave", function()
            require("seshmgr.commands")._setup_session_save("/tmp", "!")
        end)
    end)

    it("setup_session_load should add SessionLoad command", function()
        test_setup_command("SessionLoad", function()
            require("seshmgr.commands")._setup_session_load()
        end)
    end)

    it("setup_session_load_last should add SessionLoadLast command", function()
        test_setup_command("SessionLoadLast", function()
            require("seshmgr.commands")._setup_session_load_last("/tmp")
        end)
    end)

    it("setup_session_delete should add SessionDelete command", function()
        test_setup_command("SessionDelete", function()
            require("seshmgr.commands")._setup_session_delete()
        end)
    end)

    it("setup_session_delete_current should add SessionDeleteCurrent command", function()
        test_setup_command("SessionDeleteCurrent", function()
            require("seshmgr.commands")._setup_session_delete_current("/tmp", "!")
        end)
    end)

    it("setup_session_list should add SessionList command", function()
        test_setup_command("SessionList", function()
            require("seshmgr.commands")._setup_session_list("/tmp")
        end)
    end)
end)
