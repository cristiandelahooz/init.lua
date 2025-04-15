# init.lua

This repository contains my personal Neovim configuration, built using [LazyVim](https://github.com/LazyVim/LazyVim), a modern Neovim configuration framework.

## Getting Started

Follow the steps below to install and set up this configuration:

### Prerequisites

1. **Install Neovim**  
   Ensure you have Neovim (version 0.9 or higher) installed. You can download it from [neovim.io](https://neovim.io).

2. **Install a Nerd Font**  
   LazyVim uses icons that require a Nerd Font. You can download and install one from [Nerd Fonts](https://www.nerdfonts.com/).

3. **Install Git**  
   Ensure Git is installed on your system to clone the configuration.

### Backing Up Your Current Configuration

Before installing this configuration, make a backup of your existing Neovim configuration (if any) to avoid losing it.

1. **Create a Backup**  
   Run the following command to move your current Neovim configuration to a backup folder:

   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. **Restore the Backup (if needed)**  
   If you want to restore your previous configuration, use the following command to move the backup back to the original location:

   ```bash
   mv ~/.config/nvim.bak ~/.config/nvim
   ```

### Installation

1. **Clone the Repository**  
   Clone this repository into your Neovim configuration directory:

   ```bash
   git clone https://github.com/cristiandelahooz/init.lua.git ~/.config/nvim
   ```

2. **Launch Neovim**  
   Open Neovim. LazyVim will automatically install its dependencies and plugins on the first launch:

   ```bash
   nvim
   ```

3. **Restart Neovim**  
   After the installation is complete, restart Neovim to apply the configuration.

### Updating the Configuration

To update the configuration and plugins, run the following command within Neovim:

```vim
:Lazy update
```

### Troubleshooting

If you encounter issues, you can reset your plugin installation by deleting the `~/.local/share/nvim` directory and relaunching Neovim.

## Features

- **Modern and Minimalist**: LazyVim provides a clean and functional setup, perfect for beginners and experienced users alike.
- **Highly Extendable**: Easily add or customize plugins and settings to fit your workflow.
- **Optimized for Performance**: LazyVim is designed to be fast and efficient.

## Customization

You can customize the configuration by editing the `init.lua` file and other files in the `lua` directory. Refer to the [LazyVim documentation](https://github.com/LazyVim/LazyVim) for guidance.

## Contributing

Feel free to fork this repository and make it your own. Contributions are welcome!

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
