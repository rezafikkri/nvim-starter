# Neovim Starter

Minimal working configuration with mason.nvim + nvim-cmp + nvim-lspconfig.

The following language servers are configured:

* tsserver
* eslint
* cssls
* html

## Requirements

* Neovim v0.8 or greater.
* git.
* [npm cli](https://docs.npmjs.com/cli/v8/commands/npm). Javascript package manager. Required to download language servers automatically.

> Here's the config [compatible with v0.7](https://github.com/VonHeikemen/nvim-starter/tree/dd978bf567f19edbdfe83e50935c0e0381b89f3a). 

## Installation

* Backup your existing configuration if you have one.

* Create an `init.lua` file in your system. Use this command if you don't know the specific location of Neovim's configuration folder.

```sh
nvim --headless -c 'call mkdir(stdpath("config"), "p") | exe "edit" stdpath("config") . "/init.lua" | write | quit'
```

* Open your configuration file with Neovim.

```sh
nvim -c 'edit $MYVIMRC'
```

* Copy the content of `init.lua` in this repository into your own `init.lua`.

* When you open Neovim `lazy.nvim` will be installed automatically. Then your plugins will be installed. Then, `mason.nvim` will download language servers listed in the configuration. Use the command `:Mason` to check the download process of language servers.

### Plugins directory

Your plugins will be installed in a separate directory from your configuration. The location of this directory depends on your operating system and environment variables, so you'll need to execute this command to know where that is.

```sh
nvim --headless -c 'echo stdpath("data") . "/lazy/lazy.nvim" | quit'
```

## Keybindings

| Mode | Key | Action |
| --- | --- | --- |
| Normal | `K` | Displays hover information about the symbol under the cursor. |
| Normal | `gd` | Jump to the definition. |
| Normal | `gD` | Jump to declaration. |
| Normal | `gi` | Lists all the implementations for the symbol under the cursor. |
| Normal | `go` | Jumps to the definition of the type symbol |
| Normal | `gr` | Lists all the references. |
| Normal | `gs` | Displays a function's signature information. |
| Normal | `<F2>` | Renames all references to the symbol under the cursor. |
| Normal | `<F3>` | Format code in current buffer. |
| Normal | `<F4>` | Selects a code action available at the current cursor position. |
| Visual | `<F4>` | Selects a code action available in the selected text. |
| Normal | `gl` | Show diagnostics in a floating window. |
| Normal | `[d` | Move to the previous diagnostic. |
| Normal | `]d` | Move to the next diagnostic. |

### Autocomplete keybindings

| Mode | Key | Action |
| --- | --- | --- |
| Insert | `<Ctrl-Space>` | Trigger completion. |
| Insert | `<Ctrl-y>` | Confirm completion. |
| Insert | `<Ctrl-e>` | Cancel completion. |
| Insert | `<Ctrl-p>` | Move to previous item. |
| Insert | `<Ctrl-n>` | Move to next item. |
| Insert | `<Ctrl-u>` | Scroll up in documentation window. |
| Insert | `<Ctrl-d>` | Scroll down in documentation window. |

## Plugin list

| Name | Description  |
| --- | --- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager. |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable package manager for Neovim. |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Integrates nvim-lspconfig and mason.nvim. |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configs for Neovim's LSP client.  |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion engine. |
| [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) | nvim-cmp source. Show suggestions based on LSP servers queries. |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine. |

