# Session plugin

<div align="center">

Session plugin for neovim

![Logo](./.github/images/image.png)

[Usage](#usage-computer) •
[Installation](#installation-inbox_tray) •
[Configuration](#configuration-wrench) •
[Contributing](#contributing-tada) •
[Related Projects](#related-projects-link)

</div>

# Usage :computer:

## Commands

```lua
:SessionSave
:SessionLoad {session_name}
:SessionLoadLast
:SessionDelete {session_name}
:SessionDeleteCurrent
:SessionList
```

## Telescope

> [!WARNING]
> Not implemented yet, enable telescope in the configuration.

```lua
require('telescope').load_extension('session-plugin')
```

# Installation :inbox_tray:

With [folke/lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
   "mackeper/session-plugin",
   opts = {},
}
```

# Configuration :wrench:

```lua
{
    session_dir = vim.fn.stdpath("data") .. "/sessions",
    session_name_delimiter = "_-_",

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

- [auto-session](https://github.com/rmagatti/auto-session)
- ...
