local util = require("seshmgr.util")

describe("util", function()
    it("should return a table", function()
        assert(util ~= nil)
    end)

    it("_get_encoded_cwd should return the current working directory with a different delimiter", function()
        -- Arrange
        local delimiter = "_--_"
        local drive_delimiter = "-__-"

        -- Act
        local encoded_cwd = util._get_encoded_cwd(delimiter, drive_delimiter)

        -- Assert
        -- BUG: the assertion below is equivalent to the tested function
        local expected_encoded_cwd = ""
        if util._is_Windows() then
            expected_encoded_cwd = vim.fn.substitute(vim.fn.getcwd(), "\\", delimiter, "g")
            expected_encoded_cwd = vim.fn.substitute(expected_encoded_cwd, ":", drive_delimiter, "g")
        else
            expected_encoded_cwd = vim.fn.substitute(vim.fn.getcwd(), "/", delimiter, "g")
        end
        assert.are_equal( expected_encoded_cwd, encoded_cwd)
    end)

    it("_get_decoded_session_file_path without drive should return the original cwd", function()
        -- Arrange
        local encoded_cwd = "!!test!!seshmgr!!tmp"
        local delimiter = "!!"
        local drive_delimiter = ";;"

        -- Act
        local decoded_cwd = util._get_decoded_session_file_path(encoded_cwd, delimiter, drive_delimiter)

        -- Assert
        local expected_decoded_cwd = "/test/seshmgr/tmp"
        if util._is_Windows() then
            expected_decoded_cwd = "\\test\\seshmgr\\tmp"
        end
        assert.are_equal(expected_decoded_cwd, decoded_cwd)
    end)

    it("_get_decoded_session_file_path with drive should return the original cwd", function()
        -- Arrange
        local encoded_cwd = "C;;!!test!!seshmgr!!tmp"
        local delimiter = "!!"
        local drive_delimiter = ";;"

        -- Act
        local decoded_cwd = util._get_decoded_session_file_path(encoded_cwd, delimiter, drive_delimiter)

        -- Assert
        local expected_decoded_cwd = "C:/test/seshmgr/tmp"
        if util._is_Windows() then
            expected_decoded_cwd = "C:\\test\\seshmgr\\tmp"
        end
        assert.are_equal(expected_decoded_cwd, decoded_cwd)
    end)
end)
