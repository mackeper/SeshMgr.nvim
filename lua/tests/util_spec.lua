describe("util", function()
    it("should return a table", function()
        local util = require("seshmgr.util")
        assert(util ~= nil)
    end)

    it("_get_decoded_session_file_path should return the original cwd", function()
        -- Arrange
        local util = require("seshmgr.util")
        local encoded_cwd = "!test!seshmgr!tmp"
        local delimiter = "!"

        -- Act
        local decoded_cwd = util._get_decoded_session_file_path(encoded_cwd, delimiter)

        -- Assert
        assert(decoded_cwd == "/test/seshmgr/tmp")
    end)
end)
