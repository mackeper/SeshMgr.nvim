# SeshMgr.nvim

<div align="center">

SeshMgr.nvim is a session management plugin for Neovim to save and load sessions.

I made this plugin for myself, there are many other plugins that do the same thing, see [related projects](#related-projects-link).
The main difference is that this plugin is that the telescope integration lists session with timestamps and in order of last used.

![Logo](./.github/images/image.png)

[Usage](#usage-computer) •
[Installation](#installation-inbox_tray) •
[Configuration](#configuration-wrench) •
[Contributing](#contributing-tada) •
[Related Projects](#related-projects-link)

</div>

# Usage :computer:

Manually save and load sessions using [commands](#commands-keyboard) or use [telescope](#telescope-telescope) to manage sessions.
By default, autosave is enabled to save the session when exiting Neovim. This can be disabled in the [configuration](#configuration-wrench).

## Commands :keyboard:

| Command | Description |
:-------------------------|:-------------------------
`:SessionSave` | Save the current session by current working directory (cwd).
`:SessionLoad {session_full_path}` | Load the given session path.
`:SessionLoadLast` | Load the last session.
`:SessionDelete {session_full_path}` | Delete the given session.
`:SessionDeleteCurrent` | Delete the file associated with the current session.
`:SessionList` | List all session files.

## Telescope :telescope:

You can delete and load sessions using telescope.

- `<leader>js` to open telescope ([configurable](#configuration-wrench))
- `<CR>` to load session.
- `<C-d>` to delete session.

# Installation :inbox_tray:

With [folke/lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "mackeper/seshmgr.nvim",
    event = "VeryLazy",
    opts = {},

    -- optional keymappings
    keys = {
        { "<leader>sl", "<CMD>SessionLoadLast<CR>", desc = "Load last session" },
        { "<leader>sL", "<CMD>SessionList<CR>", desc = "List sessions" },
        { "<leader>ss", "<CMD>SessionSave<CR>", desc = "Save session" },
    },
}
```

# Configuration :wrench:

Default configuration:

```lua
{
    session_dir = vim.fn.stdpath("data") .. "/sessions",
    session_name_delimiter = "!",

    autosave_events = { "ExitPre" },
    autosave = true,

    telescope = {
        enabled = true,
        keymap = "<leader>js",
    },
}
```

# Contributing :tada:

TODO

# Related Projects :link:

- [rmagatti/auto-session](https://github.com/rmagatti/auto-session)
- [echasnovski/mini.nvim#mini.sessions](https://github.com/echasnovski/mini.nvim#mini.sessions)
- [gennaro-tedesco/nvim-possession](https://github.com/gennaro-tedesco/nvim-possession)
- [olimorris/persisted.nvim](https://github.com/olimorris/persisted.nvim)
- [Shatur/neovim-session-manager](https://github.com/Shatur/neovim-session-manager)
- [jedrzejboczar/possession.nvim](https://github.com/jedrzejboczar/possession.nvim)
- [niuiic/multiple-session.nvim](https://github.com/niuiic/multiple-session.nvim)
- [RutaTang/spectacle.nvim](https://github.com/RutaTang/spectacle.nvim)
- [coffebar/neovim-project](https://github.com/coffebar/neovim-project)
- [natecraddock/sessions.nvim](https://github.com/natecraddock/sessions.nvim)
