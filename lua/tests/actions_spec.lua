local actions = require("seshmgr.actions")

describe("actions", function()
    it("should return a table", function()
        assert(require("seshmgr.actions") ~= nil)
    end)

    it("should have a load function", function()
        assert.is_function(actions.load_session)
    end)

    it("should have a save function", function()
        assert.is_function(actions.save_session)
    end)

    it("should have a delete function", function()
        assert.is_function(actions.delete_session)
    end)

    it("should have an exists function", function()
        assert.is_function(actions.session_exists)
    end)

    it("should have a get_sessions function", function()
        assert.is_function(actions.get_sessions)
    end)

    it("should have a get_session_file function", function()
        assert.is_function(actions.get_session_file_path)
    end)

    it("load_current should return false when session does not exist", function()
        -- Act
        local result = actions.load_current("valid_session_dir", "_-_")

        -- Assert
        assert.is_false(result)
    end)

    it("load_current should return true when session exists", function()
        -- Arrange
        local session_dir = "valid_session_dir"
        local delimiter = "_-_"
        local session_file_path = actions.get_session_file_path(session_dir, delimiter)
        actions.save_session(session_dir, session_file_path)

        -- Act
        local result = actions.load_current(session_dir, delimiter)

        -- Assert
        assert.is_true(result)

        -- Cleanup
        os.remove(session_file_path)
        os.remove(session_dir)
    end)
end)
