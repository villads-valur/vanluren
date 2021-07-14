if exists('g:vscode')
  source $HOME/.config/nvim/settings/vscode/vscode-neovim.vim
  source $HOME/.config/nvim/settings/vscode/settings.vim
else
  source $HOME/.config/nvim/settings/general.vim
  source $HOME/.config/nvim/plugins.vim
  source $HOME/.config/nvim/themes/theme.vim
  source $HOME/.config/nvim/settings/settings.vim
endif

