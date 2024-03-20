local actions = require("seshmgr.actions")
local util = require("seshmgr.util")

-- TODO: Make this an extension?
-- TODO: The "telescope" namespace is already used by the telescope plugin
-- which makes it confusing to use the same name here
--- *SeshMgr.telescope*
---
--- Telescope integration
---
---@usage `require("seshmgr.telescope")`
local telescope = {}

telescope.actions = {}

-- Load a session
--
--@param prompt_bufnr number The prompt buffer number
telescope.actions._load_session = function(prompt_bufnr)
    local selection = require("telescope.actions.state").get_selected_entry()
    require("telescope.actions").close(prompt_bufnr)
    actions.load_session(selection.value.path)
end

-- Delete a session
telescope.actions._delete_session = function(prompt_bufnr)
    local selection = require("telescope.actions.state").get_selected_entry()
    local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
    current_picker:delete_selection(function()
        actions.delete_session(selection.value.path)
    end)
end

-- Search for sessions
--
--@param session_dir string The directory where the session files are saved
--@param delimiter string The delimiter to use in the session file name
telescope._search_session = function(session_dir, delimiter)
    local opts = {
        prompt_title = "Sessions",
        cwd = session_dir,
        previewer = false,
    }

    local finders = require("telescope.finders")
    local telescope_config = require("telescope.config").values
    local telescope_actions = require("telescope.actions")
    local entry_display = require("telescope.pickers.entry_display")
    local make_entry = require("telescope.make_entry")

    local displayer = entry_display.create({
        separator = "   ",
        items = {
            { width = 0.7 },
            { width = 0.25, right_justify = true },
        },
    })

    local make_display = function(entry)
        return displayer({ { util._get_decoded_session_file_path(entry.name, delimiter) }, { entry.readable_time } })
    end

    -- Sort the sessions by most recent
    local get_sessions = function()
        local sessions = actions.get_sessions(session_dir)
        table.sort(sessions, function(a, b)
            return a.time > b.time
        end)
        return sessions
    end

    require("telescope.pickers")
        .new(opts, {
            finder = finders.new_table({
                results = get_sessions(),
                entry_maker = function(entry)
                    entry.value = entry
                    entry.display = make_display
                    entry.ordinal = entry.name
                    return make_entry.set_default_entry_mt(entry, opts)
                end,
            }),
            previewer = telescope_config.grep_previewer(opts),
            sorter = telescope_config.file_sorter(opts),
            attach_mappings = function(_, map)
                telescope_actions.select_default:replace(telescope.actions._load_session)
                map("i", "<C-d>", telescope.actions._delete_session)
                return true
            end,
        })
        :find()
end

--- Setup the telescope keymaps
---
---@param keymap string The keymap to use
---@param session_dir string The directory where the session files are saved
---@param delimiter string The delimiter to use in the session file name
telescope.setup_keymaps = function(keymap, session_dir, delimiter)
    vim.keymap.set("n", keymap, function()
        telescope._search_session(session_dir, delimiter)
    end, {
        noremap = true,
        desc = "Sessions",
    })
end

return telescope
