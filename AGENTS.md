# Agent Guidelines: Dotfiles Repository

This dotfiles repository contains configuration files for a Linux development environment, focusing on Neovim, Zsh, PHP, and Lua. It is used with `rcm`, which creates symlinks of files in this repository (e.g. `~/.zshrc` -> `~/.dotfiles/zshrc`).

## 1. Build, Lint, and Test Commands

### Lua (Neovim Configuration)

- **Formatting:** Use StyLua for Lua files:
    ```bash
    stylua path/to/file.lua
    ```

### Markdown

- **Linting/Formatting:** Use `prettierd` then `markdownlint`.
    ```bash
    prettierd path/to/file.md
    markdownlint path/to/file.md
    ```

## 2. Code Style Guidelines

### Lua Style (Neovim/Plugins)

- **Types:** Use EmmyLua/LuaLS annotations for documentation and type hinting:
    ```lua
    ---@param name string
    ---@return boolean
    ```
- **Plugin Config:** Use the `return { "plugin/repo", ... }` structure in `config/nvim/lua/ben-everly/plugins/*` for Lazy.nvim compatibility.

## 3. AI & Tool Interaction

### `rcm`

This repository is intended to be used with `rcm` for dotfile management.

- **Dry Run:** Use `lsrc` to preview changes without applying them.
- **Syncing:** After modifying or adding files, run `rcup` to symlink files to the home directory.
- **Adding New Files:** Use `mkrc /path/to/file` to move a file into the repository and create a symlink.
- **Removing Files:** Use `rcdn /path/to/file` to remove a symlink before deleting the file from the repository.
- **Configuration:** The repository's settings are defined in `rcrc`. It includes ignored files.
- **Initialization:** For a fresh setup or to ensure the local config is used: `RCRC=$HOME/.dotfiles/rcrc rcup`
