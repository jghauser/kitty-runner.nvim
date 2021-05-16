# kitty-runner.nvim
A lua plugin that allows you to easily send lines from the current buffer to another kitty terminal.

This plugin is inspired by and heavily borrows from [vim-kitty-runner](https://github.com/LkeMitchll/vim-kitty-runner). It was mostly created in an attempt to learn some lua and in a somewhat pointless effort to lua-fy my nevim setup. It's very much WIP and probably full of mistakes and/or inelegant code.

It currently (attempts) to do the following:

- When first running `:KittySendLines` or `:KittyRunCommand`, a new kitty terminal is spawned (the 'runner').
- Further instances of running these commenands do the following
  - `:KittySendLines`: Sends the line of the current cursor position or current visual selection.
  - `:KittyRunCommand [command]`: Sends the selected command.
- `:KittyReRunCommand`: Sends the last command.
- `:KittyClearRunner`: Clears the screen of the runner terminal.
- `:KittyKillRunner`: Kills the runner terminal.
- By default a number of keymaps are created; this behaviourn can be turned off in the setup function.

## Installation

With packer:

```
  use {
    'jghauser/kitty-runner.nvim',
    config = function()
      require('kittyrunner').setup()
    end
  }
```

## Configuration

The setup function allows adjusting various settings.

## TODO

- improve documentation
- improve code legibility and comments
