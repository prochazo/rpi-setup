# rpi-setup

**The Ultimate Terminal Development Environment for Raspberry Pi & Debian/Ubuntu Systems.**

`rpi-setup` is a comprehensive configuration suite that transforms a fresh Raspberry Pi (or any Debian-based Linux) into a powerful, terminal-centric Integrated Development Environment (IDE). It automates the installation and configuration of **Vim**, **Tmux**, **Ranger**, **Docker**, and **Zsh/Bash**, providing a seamless workflow for developers.

---

## Why use rpi-setup?

Setting up a comfortable development environment on a headless Raspberry Pi usually takes hours of installing packages, tweaking dotfiles, and fixing compatibility issues. **rpi-setup** does it in minutes.

### Key Capabilities

* ** Vim as a Full IDE**:
* Pre-configured with **YouCompleteMe** (C++/Python code completion), **NERDTree** (file explorer), and **CtrlP** (fuzzy finder).
* **Beautiful Themes**: unified `PaperColor` scheme across Vim and Tmux.


* ** Tmux Powerhouse**:
* **Seamless Navigation**: Navigate between Vim splits and Tmux panes using the same hotkeys (`Ctrl+h/j/k/l`) via `vim-tmux-navigator`.
* **Custom Status Bar**: Auto-synced with Vim's airline theme.
* **Tmuxinator**: Manage complex session layouts easily.


* ** System Monitoring**:
* **Custom MOTD**: A beautiful "Message of the Day" on login displaying real-time CPU temp, usage, memory, and disk space.


* ** Efficient Shell**:
* **Ranger**: Console file manager with `ra` alias.
* **Git Enhancements**: Custom wrappers for recursive submodule management and visualization (`git-forest`).



---

## Installation

This project relies on git submodules. Clone it recursively to ensure all components are retrieved.

```bash
# 1. Clone the repository
git clone --recursive https://github.com/your-username/rpi-setup.git
cd rpi-setup

# 2. Run the installer
# This will install dependencies, compile Vim/Tmux from source, and link dotfiles.
./install.sh

```

> **Note:** The script will modify your `~/.bashrc` to source the project's configurations. A backup of your existing config is recommended.

---

## Modules & Configuration

The project is organized into modular components found in `appconfig/`.

### 1. Vim (`appconfig/vim`)

A highly customized Vim setup compiled from source for performance.

* **Plugin Manager**: `vim-plug`
* **Key Features**:
* **LaTeX Support**: via `vimtex`.
* **Wiki**: `vimwiki` for personal knowledge base.
* **Snippets**: `UltiSnips` engine.


* **Config**: `appconfig/vim/dotvimrc`
### 2. Tmux (`appconfig/tmux`)

Replaces the standard terminal multiplexer experience with a "vim-like" workflow.

* **Prefix Key**: Remapped to `Ctrl + a` (easier to reach).
* **Splitting**:
* `Ctrl + 9`: Vertical Split
* `Ctrl + 0`: Horizontal Split


* **Config**: `appconfig/tmux/dottmux.conf`

### 3. Shell & Bash (`appconfig/bash`, `appconfig/shell`)

* **Aliases**:
* `ra`: Launch Ranger file manager.
* `sb`: Source `.bashrc` (reload config).
* `gppl` / `gppo`: Git pull/push local or origin.
* `gr`: Run command recursively in git submodules.


* **FZF Integration**: Fuzzy search for files and history (requires `fzf` installed).

### 4. MOTD (`appconfig/motd`)

Custom scripts in `11-welcome` and `15-system` provide a dashboard view upon SSH login.

---

## Cheat Sheet

| Context | Keybinding | Action |
| --- | --- | --- |
| **Tmux** | `Ctrl+a` | **Prefix key** (replaces `Ctrl+b`) |
| **Tmux** | `Ctrl+h/j/k/l` | Move focus (works across Vim & Tmux!) |
| **Tmux** | `Ctrl+9` | Split pane vertically |
| **Tmux** | `Ctrl+0` | Split pane horizontally |
| **Vim** | `,` (Comma) | **Leader key** |
| **Vim** | `,n` | Toggle NERDTree file explorer |
| **Vim** | `Ctrl+p` | Fuzzy find file (CtrlP) |
| **Shell** | `Ctrl+r` | Reverse history search |
| **Shell** | `ra` | Open Ranger |

---

## Profiles & Theming

The setup supports a "Profile Manager" to switch configurations (like color schemes) dynamically.

* **Current Default**: `COLORSCHEME_DARK` (PaperColor Dark).
* **Switching**: Usage of `deploy_configs.sh` allows deploying specific profile lists defined in `appconfig/profile_manager/file_list.txt`.

---

## Project Structure

```text
rpi-setup/
├── appconfig/          # Configuration modules
│   ├── bash/           # .bashrc and shell settings
│   ├── vim/            # Vim plugins, themes, and compile scripts
│   ├── tmux/           # Tmux conf and compilation
│   ├── ranger/         # File manager config
│   ├── docker/         # Docker setup
│   └── motd/           # Login message scripts
├── scripts/            # Utility scripts (git-forest, color tests)
├── install.sh          # Main entry point
└── deploy_configs.sh   # Symlink manager

```
