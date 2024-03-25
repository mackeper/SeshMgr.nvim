local actions = require("seshmgr.actions")

describe("actions", function()
    it("should return a table", function()
        assert(require("seshmgr.actions") ~= nil)
    end)

    it("load_session should return false when session does not exist", function()
        -- Act
        local result = actions.load_session("valid_session_dir")

        -- Assert
        assert.is_false(result)
    end)

    it("load_session should return true when session exists", function()
        -- Arrange
        local session_dir = "valid_session_dir"
        local session_file_path = actions.get_session_file_path(session_dir, "_-_")
        actions.save_session(session_dir, session_file_path)

        -- Act
        local result = actions.load_session(session_file_path)

        -- Assert
        assert.is_true(result)

        -- Cleanup
        os.remove(session_file_path)
        os.remove(session_dir)
    end)

    it("save_session should create session file and dir", function()
        -- Arrange
        local session_dir = "valid_session_dir"
        local session_file_path = actions.get_session_file_path(session_dir, "_-_")

        assert.is_false(actions.session_exists(session_file_path))
        assert.is_false(vim.fn.isdirectory(session_dir) == 1)

        -- Act
        actions.save_session(session_dir, session_file_path)

        -- Assert
        assert.is_true(actions.session_exists(session_file_path))
        assert.is_true(vim.fn.isdirectory(session_dir) == 1)

        -- Cleanup
        os.remove(session_file_path)
        os.remove(session_dir)
    end)

    it("delete_session should remove session file", function()
        -- Arrange
        local session_dir = "valid_session_dir"
        local session_file_path = actions.get_session_file_path(session_dir, "_-_")
        actions.save_session(session_dir, session_file_path)

        assert.is_true(actions.session_exists(session_file_path))

        -- Act
        actions.delete_session(session_file_path)

        -- Assert
        assert.is_false(actions.session_exists(session_file_path))

        -- Cleanup
        os.remove(session_dir)
    end)

    it("session_exists should return false when session does not exist", function()
        -- Act
        local result = actions.session_exists("valid_session_dir")

        -- Assert
        assert.is_false(result)
    end)

    it("session_exists should return true when session exists", function()
        -- Arrange
        local session_dir = "valid_session_dir"
        local session_file_path = actions.get_session_file_path(session_dir, "_-_")
        actions.save_session(session_dir, session_file_path)

        -- Act
        local result = actions.session_exists(session_file_path)

        -- Assert
        assert.is_true(result)

        -- Cleanup
        os.remove(session_file_path)
        os.remove(session_dir)
    end)

    it("get_sessions should return a table", function()
        -- Act
        local result = actions.get_sessions("valid_session_dir")

        -- Assert
        assert.is_table(result)
    end)

    it("get_sessions should return an empty table when no sessions exist", function()
        -- Act
        local result = actions.get_sessions("valid_session_dir")

        -- Assert
        assert.are.same({}, result)
    end)

    it("get_sessions should return a table with session objects", function()
        -- Arrange
        local session_dir = "valid_session_dir"
        local session_file_path = actions.get_session_file_path(session_dir, "_-_")
        actions.save_session(session_dir, session_file_path)

        -- Act
        local result = actions.get_sessions(session_dir)

        -- Assert
        assert.is_table(result)
        assert.is_table(result[1])
        assert.is_string(result[1].path)
        assert.is_number(result[1].time)

        -- Cleanup
        os.remove(session_file_path)
        os.remove(session_dir)
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
