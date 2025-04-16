---

# `init.lua` ⚡

Welcome to the **`init.lua`** repository! This project is a configuration file for Neovim, written in Lua, to supercharge your development experience. 🚀

---

## 🌟 Features

- **Lightweight and Fast**: Optimized for a blazing-fast editing experience.
- **Written in Lua**: Harnessing the full power of Lua for Neovim configuration.
- **Customizable**: Easy-to-modify and extend to suit your workflow.
- **Modern Plugins**: Leverages the latest and greatest plugins in the Neovim ecosystem.

---

## 📂 Directory Structure
``` bash
.
├── init.lua                       # Main Neovim config file – loads core setup and plugins
├── lua
│   ├── config
│   │   ├── autocmds.lua           # Custom auto commands (e.g., format on save, highlight yank)
│   │   ├── keymaps.lua            # All your custom keybindings
│   │   ├── lazy.lua               # Plugin manager setup and plugin loading logic
│   │   └── options.lua            # General Neovim options (e.g., line numbers, tabs, UI)
│   ├── sakidoa                    # just a personal phrase
│   │   ├── discipline.lua         # Optional plugin or module for keeping code discipline (e.g., WIP features)
│   │   ├── hsl.lua                # Utility for color manipulation using HSL values
│   │   └── lsp.lua                # Customizations for LSP (servers, handlers, etc.)
│   ├── plugins
│   │   ├── coding.lua             # Plugins focused on coding productivity (e.g., snippets, autocomplete)
│   │   ├── colorscheme.lua        # Color scheme and theme plugins
│   │   ├── editor.lua             # Core editor enhancements (commenting, indenting, etc.)
│   │   ├── lsp.lua                # Language Server Protocol setup (installers, configs)
│   │   ├── tmux-navigation.lua    # Seamless navigation between tmux and Neovim splits
│   │   ├── treesitter.lua         # Treesitter config for syntax highlighting and parsing
│   │   └── ui.lua                 # UI/UX improvements (statusline, filetree, notifications)
│   └── util
│       └── debug.lua              # Helper functions for debugging Lua/Nvim configurations
└── README.md                      # Project documentation and setup guide
```
---

## 🚀 Getting Started

Sigue estos pasos para comenzar con esta configuración:

### 1. Make a backup of your current Neovim files:

```bash
# Configuración principal
mv ~/.config/nvim{,.bak}

# Datos compartidos y temporales
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

### 2. Clone this repo

```bash
git clone https://github.com/cristiandelahooz/init.lua.git ~/.config/nvim
```

### 3. Remove the .git folder, so you can add it to your own repo later

```bash
rm -rf ~/.config/nvim/.git
```

### 4. Start Neovim 🚀

```bash
nvim
```

---

## 🛠️ Customization

You can easily tweak the configuration to match your preferences:

- **Add Plugins**: Add plugins to the `plugins` section.
- **Change Keymaps**: Modify key mappings in the `keymaps` section.
- **Adjust Settings**: Update settings in the `init.lua` file.

---

## 🤝 Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request if you have ideas or improvements.

1. Fork the repository.
2. Create a new branch: `git checkout -b feature/your-feature-name`.
3. Commit your changes: `git commit -m 'Add your message here'`.
4. Push to the branch: `git push origin feature/your-feature-name`.
5. Open a Pull Request.
---
# 📌 **Important Note:**  
> This repository is originally based on the great work by [@craftzdog](https://github.com/craftzdog/dotfiles-public).  
> Many configurations and structural ideas were adapted and customized from his public dotfiles.
---
---
## 📄 License

This project is licensed under the [MIT License](LICENSE).
---

## 🌐 Connect

- **Author**: [Cristian De La Hooz](https://github.com/cristiandelahooz)
- **GitHub**: [https://github.com/cristiandelahooz/init.lua](https://github.com/cristiandelahooz/init.lua)

---
