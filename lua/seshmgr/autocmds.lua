local actions = require("seshmgr.actions")

--- *SeshMgr.autocmds*
---
---@usage `require("seshmgr.autocmds")`

local autocmds = {}

--- Start autosaving the session
---
---@param session_dir string The directory where the session file will be saved
---@param delimiter string The delimiter to use in the session file name
---@param windows_drive_delimiter string The delimiter to use in the session file name for Windows
---@param events table The events to trigger the autosave
autocmds.start_autosave = function(session_dir, delimiter, windows_drive_delimiter, events)
    vim.api.nvim_create_autocmd(events, {
        desc = "Save session on exit",
        group = vim.api.nvim_create_augroup("seshmgr.autosave", { clear = true }),
        callback = function()
            actions.save_session(session_dir, actions.get_session_file_path(session_dir, delimiter, windows_drive_delimiter))
        end,
    })
end

--- Stop autosaving the session
autocmds.stop_autosave = function()
    vim.api.nvim_clear_autocmds({ group = "seshmgr.autosave" })
end

-- https://github.com/nvim-tree/nvim-tree.lua/wiki/Recipes#workaround-when-using-rmagattiauto-session
-- BUG Doesn't work
autocmds.setup_nvimtree_fix = function()
    vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd" }, {
        pattern = "*",
        group = vim.api.nvim_create_augroup("seshmgr", { clear = true }),
        callback = function(opts)
            if vim.bo[opts.buf].filetype == "NvimTree" then
                local api = require("nvim-tree.api")
                local view = require("nvim-tree.view")

                if not view.is_visible() then
                    api.tree.open()
                end
            end
        end,
    })
end

return autocmds
