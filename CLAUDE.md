# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This repository contains a Neovim configuration built on the NvChad framework (v2.0). The configuration is structured following NvChad's conventions with core components in `lua/core/` and user customizations in `lua/custom/`.

## Architecture

The configuration follows these key architectural principles:

1. **Modular Organization**:
   - Core system components in `lua/core/`
   - User customizations in `lua/custom/`
   - Plugin configurations in `lua/custom/plugins/` as individual files
   - Additional custom functions in `lua/custom/function/`

2. **Plugin Management**:
   - Uses lazy.nvim for plugin management and lazy-loading
   - Base plugins defined in `lua/plugins/init.lua`
   - Custom plugins in `lua/custom/plugins/*.lua`

3. **Configuration Structure**:
   - `init.lua`: Entry point that loads core and custom configurations
   - `lua/core/`: NvChad core functionality
   - `lua/custom/chadrc.lua`: User config overrides
   - `lua/custom/init.lua`: Custom initialization
   - `lua/custom/mappings.lua`: Custom keybindings

## Key Components

1. **LSP Configuration**:
   - LSP servers managed via Mason
   - Language-specific configurations in `lua/custom/plugins/lspconfig.lua`
   - Configured for: Lua, TypeScript, Rust, Python, HTML/CSS, Tailwind and more

2. **Treesitter**:
   - Syntax highlighting and text objects
   - Used for enhanced code navigation
   - Configured in `lua/custom/plugins/treesitter.lua`

3. **Telescope**:
   - Fuzzy finder for files, buffers, etc.
   - Custom extensions and keybindings
   - Configured in `lua/custom/plugins/telescope.lua`

4. **Editor Features**:
   - Various plugins for code editing, navigation, and Git integration
   - Quickfix list toggle functionality in `lua/custom/function/toggle_qf.lua`

## Development Commands

### Plugin Management

```lua
-- Install/update plugins
:Lazy

-- Update specific plugin
:Lazy update <plugin_name>

-- Install specific plugin
:Lazy install <plugin_name>
```

### LSP Commands

```lua
-- Install language servers
:Mason

-- Update language servers
:MasonUpdate

-- Install specific language server
:MasonInstall <server_name>
```

### Treesitter Commands

```lua
-- Install language parsers
:TSInstall <language>

-- Update all installed parsers
:TSUpdate

-- List installed parsers
:TSModuleInfo
```

### NvChad Commands

```lua
-- Change themes
:NvCheatsheet

-- Generate docs
:NvChadUpdate
```

## Common Tasks

1. Add a new plugin:
   - Create a new file in `lua/custom/plugins/` with the plugin configuration
   - Follow the lazy.nvim plugin spec format

2. Add custom keybindings:
   - Edit `lua/custom/mappings.lua` to add new keymaps
   - Follow the existing format for different modes

3. Configure LSP for a new language:
   - Add the language server to the ensure_installed list in `lua/custom/plugins/lspconfig.lua`
   - Add custom server configuration in the handlers section if needed

## Important Notes

- Configuration assumes usage with a Nerd Font for proper icons
- Configured with transparency enabled and the Tokyonight theme
- Customized for web development, Rust, and Python workflows
- Contains extensive LSP configurations with inlay hints and custom UI elements