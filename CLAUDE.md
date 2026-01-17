# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration built on top of lazy.nvim plugin manager. It's designed for multi-language development with a focus on Python, Rust, Go, TypeScript/JavaScript, Dart/Flutter, and Lua.

## Architecture

### Core Structure

- **init.lua**: Entry point that loads `config.lua`, `keymaps.lua`, and initializes lazy.nvim
- **lua/config.lua**: General Neovim settings, including language-specific tab/indentation rules and autocmds
- **lua/keymaps.lua**: Global keymaps (window navigation, terminal mode, arrow key disabling)
- **lua/plugins/**: Plugin configurations (each file is a lazy.nvim plugin spec)

### Plugin System

Plugins are managed by lazy.nvim and loaded from `lua/plugins/`. Each plugin file returns a table (or array of tables) with lazy.nvim specifications. The setup is called in init.lua:5-14.

Key plugins:
- **lsp.lua**: LSP configuration via nvim-lspconfig, mason, and mason-tool-installer
- **autoformat.lua**: Formatting via conform.nvim and null-ls (format-on-save enabled)
- **treesitter.lua**: Syntax highlighting and code navigation
- **dap.lua**: Debug Adapter Protocol setup (primarily Python debugging)
- **rust.lua**: Rust-specific tooling via rustaceanvim with codelldb integration
- **flutter.lua**: Flutter/Dart development tools
- **tests.lua**: Test runner via neotest (Python/pytest focused)
- **telescope.lua**: Fuzzy finder for files, LSP symbols, grep, etc.

### Language-Specific Settings

Indentation rules are defined in lua/config.lua:46-104 via FileType autocmds:
- Python, Rust, Go: 4 spaces (Go uses hard tabs)
- TypeScript, JavaScript, Lua, Dart: 2 spaces

### LSP Configuration

LSPs are managed through Mason (lua/plugins/lsp.lua:194-252). Configured servers include:
- gopls (Go)
- pyright (Python)
- lua_ls (Lua)
- ts_ls (TypeScript/JavaScript)
- codelldb (debugging)
- terraformls, bashls, yamlls, mdx_analyzer

Note: rust-analyzer is commented out in lsp.lua because it's managed by rustaceanvim plugin.

LSP handlers are commented out at lsp.lua:272-281. Mason is set up but server initialization may need to be manually configured.

### Debugging (DAP)

- **Python**: Configured in dap.lua with debugpy adapter, supports launching files and virtual environments
- **Rust**: Configured in rust.lua using codelldb from Mason packages
- **Dart/Flutter**: Configured in flutter.lua with Flutter debug adapter
- DAP UI opens automatically on debug start (dap.lua:112-114)

Common DAP keymaps (dap.lua:134-176):
- `<F5>`: Continue
- `<F10>`: Step over
- `<F11>`: Step into
- `<F12>`: Step out
- `<Leader>b`: Toggle breakpoint
- `<Leader>dt`: Terminate
- `<Leader>dc`: Close DAP UI
- `<Leader>do`: Open DAP UI

### Testing

Neotest is configured for Python (pytest), Plenary, and vim-test (tests.lua).

Test keymaps:
- `<leader>td`: Debug nearest test
- `<leader>tf`: Run all tests in current file
- `<leader>ts`: Toggle test summary
- `<leader>to`: Toggle test output panel

Python tests use pytest with args: `-s --log-level DEBUG`

### Key LSP Keymaps

Defined in lsp.lua:62-158 via LspAttach autocmd:
- `gd`: Go to definition
- `gr`: Go to references (Telescope)
- `gI`: Go to implementation (Telescope)
- `<leader>D`: Type definition
- `<leader>ds`: Document symbols
- `<leader>ws`: Workspace symbols
- `<leader>rn`: Rename
- `<leader>ca`: Code action
- `gD`: Go to declaration
- `<leader>h`: Show diagnostic hints
- `<leader>dn`: Next diagnostic
- `<leader>dp`: Previous diagnostic
- `<leader>th`: Toggle inlay hints

### Formatting

Format-on-save is enabled (autoformat.lua:21-24) with 60s timeout. Configured formatters:
- Python: black
- Lua: stylua
- TypeScript/JavaScript: prettier
- Dart: dart_format
- Go: gofmt
- Rust: rustfmt
- Terraform: terraform
- Shell scripts: shfmt
- YAML: yamlfmt

## Common Development Tasks

No specific build, test, or lint commands are defined at the repository level. This is a Neovim configuration, not a software project with build processes.

### Managing Plugins

- Install/update plugins: `:Lazy sync`
- Check plugin status: `:Lazy`
- Profile plugins: `:Lazy profile`

### Managing LSP/Tools

- Install LSP servers/tools: `:Mason`
- Check LSP status: `:LspInfo`
- Update treesitter parsers: `:TSUpdate`

### Rust Development

rustaceanvim expects rust-analyzer and codelldb from Mason. The configuration reads Mason's installation paths dynamically (rust.lua:6-13). The path uses `$MASON` environment variable and expects codelldb package structure.

### Flutter Development

Flutter path is hardcoded to `/Users/esteban/flutter/bin/flutter` (flutter.lua:9). When working on different systems, this path needs to be updated.

## Notes

- Leader key is `<space>` (config.lua:4)
- Nerd Font is expected (config.lua:6)
- Clipboard is set to use system clipboard via `unnamedplus` (config.lua:12)
- Arrow keys are disabled in normal, insert, and visual modes (keymaps.lua:12-28)
- Fold method is set to `indent` with all folds open by default (config.lua:107-110)
- MDX files are treated as markdown (config.lua:135-139, treesitter.lua:52)

## Luarocks Integration

If importing luarocks modules fails, ensure luarocks path is added to shell startup file with the correct Lua version matching Neovim's Lua version. See README.md for details.
