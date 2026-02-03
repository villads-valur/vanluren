# Neovim Configuration

A modern, TypeScript/JavaScript-focused Neovim configuration built on [LazyVim](https://www.lazyvim.org/).

## Features

- **LazyVim Foundation** - Sensible defaults with extensive plugin ecosystem
- **Web Development Focus** - TypeScript, Tailwind, ESLint, Prettier, Biome support
- **AI-Assisted Coding** - Claude Code and GitHub Copilot integration
- **Auto Dark Mode** - Automatically switches between Flow (dark) and Ayu (light) themes
- **Performance Optimized** - Disabled unnecessary built-ins, fast updatetime (100ms)

## Structure

```
nvim/
├── init.lua                    # Entry point
├── lazy-lock.json              # Plugin version locks (52 plugins)
├── lazyvim.json                # LazyVim extras configuration
├── stylua.toml                 # Lua formatter (2 spaces, 120 cols)
└── lua/
    ├── config/
    │   ├── init.lua            # Core settings, disabled builtins
    │   ├── lazy.lua            # Plugin manager bootstrap
    │   ├── keymaps.lua         # Custom key mappings
    │   ├── options.lua         # Additional options
    │   └── autocmds.lua        # Autocommands
    ├── plugins/                # Plugin configurations (26 files)
    └── utils/
        └── init.lua            # Utility functions
```

## Key Bindings

### Quick Actions

| Key | Action |
|-----|--------|
| `<Leader>w` | Save file |
| `<Leader>q` | Quit |
| `<Leader>x` | Delete buffer |
| `<Leader>v` | Vertical split |
| `<Leader>l` | Open Lazy plugin manager |
| `<Leader>cf` | Format code |

### Navigation

| Key | Action |
|-----|--------|
| `<Tab>` / `<S-Tab>` | Next/previous buffer |
| `<C-h/j/k/l>` | Window navigation |
| `<Leader>n` | Toggle file explorer (NeoTree) |
| `<Leader>t` | Find files (Telescope) |
| `<Leader>/` | Live grep |
| `<Leader>fr` | Find recent files |

### Git

| Key | Action |
|-----|--------|
| `]h` / `[h` | Next/previous hunk |
| `<Leader>ghs` | Stage hunk |
| `<Leader>ghr` | Reset hunk |
| `<Leader>ghp` | Preview hunk |
| `<Leader>gb` | Toggle blame |
| `<Leader>gop` | List pull requests (Octo) |
| `<Leader>goi` | List issues (Octo) |

### AI

| Key | Action |
|-----|--------|
| `<Leader>ac` | Toggle Claude |
| `<Leader>as` | Send selection to Claude |
| `<Leader>ab` | Add current buffer to Claude |
| `<Leader>aa` | Accept diff |
| `<Leader>ad` | Deny diff |

### LSP

| Key | Action |
|-----|--------|
| `gh` | Hover documentation |
| `ln` / `lp` | Next/previous error |
| `Ln` / `Lp` | Next/previous diagnostic |

### Editing

| Key | Action |
|-----|--------|
| `<A-j>` / `<A-k>` | Move line(s) up/down |
| `<` / `>` (visual) | Indent and stay in visual |
| `x` / `X` | Delete without yanking |

## Plugins by Category

### UI/Appearance
- **flow.nvim** / **neovim-ayu** - Dark/light themes
- **auto-dark-mode.nvim** - System theme detection
- **bufferline.nvim** - Buffer tabs
- **lualine.nvim** - Status line
- **noice.nvim** - Enhanced UI
- **snacks.nvim** - Dashboard with custom "HELLO!" header
- **which-key.nvim** - Keybinding hints

### LSP/Completion
- **nvim-lspconfig** - LSP configuration
- **mason.nvim** - LSP installer
- **blink.cmp** - Modern completion engine
- **nvim-treesitter** - Syntax highlighting (16 languages)
- **conform.nvim** / **nvim-lint** - Formatting and linting

### Git
- **gitsigns.nvim** - Git decorations and hunk management
- **vim-fugitive** - Git commands
- **octo.nvim** - GitHub PRs and issues

### Navigation
- **neo-tree.nvim** - File explorer (right side)
- **telescope.nvim** - Fuzzy finder
- **nvim-spectre** - Search and replace

### AI/Coding
- **claudecode.nvim** - Claude Code integration
- **copilot.lua** - GitHub Copilot

### Editing
- **ts-comments.nvim** - Treesitter-aware comments
- **nvim-ts-autotag** - Auto close/rename HTML tags
- **mini.surround** - Surround text objects

## LazyVim Extras

Enabled extras from LazyVim:

- `ai.codeium` (disabled via custom config)
- `coding.mini-surround`
- `lang.markdown`
- `lang.yaml`
- `vscode`

Plus custom language support for TypeScript, JSON, Tailwind, Rust, ESLint, Prettier, and Biome.

## Settings

| Setting | Value |
|---------|-------|
| Indentation | 2 spaces |
| Mouse | Full support |
| Clipboard | System clipboard |
| Line numbers | Enabled |
| Sign column | 2-width, always visible |
| Swap files | Disabled |
| Undo | Persistent |

## Requirements

- Neovim 0.9+
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Node.js (for LSP servers and Copilot)
- ripgrep (for Telescope live grep)
- fd (for Telescope file finding)

## Installation

1. Backup existing config:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this config:
   ```bash
   git clone <repo-url> ~/.config/nvim
   ```

3. Start Neovim - plugins will auto-install:
   ```bash
   nvim
   ```

## Customization

- **Keymaps**: Edit `lua/config/keymaps.lua`
- **Options**: Edit `lua/config/options.lua`
- **Plugins**: Add/modify files in `lua/plugins/`
- **Disable plugins**: Add to `lua/plugins/disabled.lua`
