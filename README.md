# Linux configs

## Installation

```bash
sudo apt install tmux
cd ~
git clone git@gitlab.com:flamecze/configs.git
cd configs
./install.sh
```

The `install.sh` script will remove existing configuration files and create symbolic links with the files in the repository.

After restarting the terminal, tmux should automatically load up.
Press <kbd>Ctrl</kbd>+<kbd>A</kbd> + <kbd>I</kbd> to fetch all tmux plugins.

## Uninstallation

Executing `uninstall.sh` will remove the symbolic links and replace them with the actual config files. Then it's safe to remove the `configs` directory.

