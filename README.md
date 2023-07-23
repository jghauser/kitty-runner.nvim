# kitty-runner.nvim

This neovim plugin allows you to easily send lines from the current buffer to another kitty terminal. I use it mostly as a poor man's REPL, e.g. I start ipython in the kitty terminal and send buffer lines to it.

This plugin is inspired by and heavily borrows from [vim-kitty-runner](https://github.com/LkeMitchll/vim-kitty-runner).

If you run into trouble using the plugin or have suggestions for improvements, do open an issue! :)

# Functionality

The plugin implements the following commands:
- `:KittyOpenRunner`: Open a new kitty terminal (called a runner in the context of this plugin)
- `:KittySendLines`: Send the line at the current cursor position or the lines of current visual selection
- `:KittyRunCommand`: Prompt for a command and send it
- `:KittyReRunCommand`: Send the last command
- `:KittyClearRunner`: Clear the runner's screen
- `:KittyKillRunner`: Kill the runner

By default a number of keymaps are created (see below to turn this off):
- `<leader>to`: `:KittyOpenRunner`
- `<leader>tr`: `:KittyRunCommand`
- `<leader>ts`: `:KittySendLines`
- `<leader>tc`: `:KittyClearRunner`
- `<leader>tk`: `:KittyKillRunner`
- `<leader>tl`: `:KittyReRunCommand`

## Installation

With packer:

```lua
use {
  "jghauser/kitty-runner.nvim",
  config = function()
    require("kitty-runner").setup()
  end
}
```

## Configuration

The setup function allows adjusting various settings. By default it sets the following:

```lua
require("kitty-runner").setup({
  -- name of the kitty terminal:
  runner_name = "kitty-runner-" .. uuid,
  -- kitty arguments when sending lines/command:
  run_cmd = {"send-text", "--"},
  -- kitty arguments when killing a runner:
  kill_cmd = {"close-window"},
  -- use default keymaps:
  use_keymaps = true,
  -- the port used to communicate with the kitty terminal:
  kitty_port = "unix:/tmp/kitty-" .. uuid,
  -- the type of window that kitty will create:
  -- - os-window = a new window
  -- - window = a new split within the current window (see below)
  -- - More info: https://sw.kovidgoyal.net/kitty/glossary/#term-os_window
  mode = "os-window"
})
```

### Window Mode

By default `kitty-runner` will open OS level windows, if you would like to open "kitty windows" or splits inside your current window you can configure like so:


```lua
local opts = require("kitty-runner.config").window_config
require("kitty-runner").setup(opts)
```

...which will setup the following:

```lua
{
  runner_name = "kitty-runner-" .. uuid,
  run_cmd = { "send-text", "--match=title:" .. "kitty-runner-" .. uuid },
  kill_cmd = { "close-window", "--match=title:" .. "kitty-runner-" .. uuid },
  use_keymaps = true,
  kitty_port = "unix:/tmp/kitty",
  mode = "window"
}
```
