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
:SessionLoad
:SessionLoadLast
:SessionDelete
```

## Telescope

```lua
require('telescope').load_extension('session-plugin')
```

# Installation :inbox_tray:

With lazy:

```lua
{
   "mackeper/session-plugin",
   opts = {},
}
```

# Configuration :wrench:

```lua
{
    autosave = true,
},
```

# Contributing :tada:

# Related Projects :link:

- [auto-session](https://github.com/rmagatti/auto-session)
