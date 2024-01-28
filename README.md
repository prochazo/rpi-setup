# RPi-setup

| Ubuntu               | Architecture | Status                                                                                                                                                           |
| -------------------- | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Debian GNU/Linux 12  | arm64        |  **Passing**                                                                                                                                                     |

## Core Submodules
- [Profile manager](https://github.com/klaxalk/profile_manager) handles the automatic switching of profiles in config files based on a predefined set of keywords for which uses [epigen](https://github.com/klaxalk/epigen).
- [tmux](https://github.com/tmux/tmux) is a terminal multiplexer.  It enables a number of terminals to be created, accessed, and controlled from a single screen. ...
- [Tmuxinator](https://github.com/tmuxinator/tmuxinator) creates and manage tmux sessions easily. ...
- [ranger](https://github.com/ranger/ranger) is a console file manager with VI key bindings. ...
- [Vim](https://github.com/vim/vim.git) is a greatly improved version of the good old UNIX editor Vi. ...
     * [vim-plug](https://github.com/junegunn/vim-plug) a minimalist Vim plugin manager.

## Custom configurations at *appconfig*
- **bash**
   * dotbashrc*
- **tmux**
   * [https://github.com/klaxalk/linux-setup/wiki/tmux](https://github.com/klaxalk/linux-setup/wiki/tmux)
   * ~/.tmux.conf 
- **tmuxinator**
- **vim**
   * /dotvim/pluginconfig/vim-startify*
   * /dotvim/pluginconfig/vim/clang-format*
   * /dotvim/pluginconfig/vim/vim_wiki* TODO:
- **shell**
   * includes a basic set of aliases used in [MRS](https://github.com/ctu-mrs).
- **profile_manager**
   * file_list.txt
- **ranger** 
   * rc.conf*
 
## Vim plugins
+ [jellybeans.vim](https://github.com/nanotech/jellybeans.vim) a colorful, dark color scheme, inspired by ir_black and twilight.
+ [fugitive.vim](https://github.com/tpope/vim-fugitive) is the premier Vim plugin for Git. Or maybe it's the premier Git plugin for Vim? ...
+ [vim-dispatch](https://github.com/tpope/vim-dispatch)
+ vim-gitgutter is showing git changes in the file
+ vim-conflicted is resolving conflicts in git the better way
+ vim-rainbow
+ vim-airline
+ vim-airline-themes
+ lambdalisue/suda.vim  is for saving files with sudo from normal vim
+ benmills/vimux is integration with tmux (allows running bash commands in tmux splits)
+ scrooloose/nerdtree is file manager (leader+n)
+ mhinz/vim-startify is home screen
+ kshenoy/vim-signature shows marks left to line numbers
+ tpope/vim-abolish clever abbreviations and syntax conversion
+ foosoft/vim-argwrap automatic function argument reformatting (leader+w)
+ hynek/vim-python-pep8-indent python formatting
+ unblevable/quick-scope is clever motions helper (highlights letters while using f, t motions)
+ majutsushi/tagbar Shows tags in the file
+ ycm-core/YouCompleteMe
+ rdnetto/YCM-Generator
+ and others I did not have time to go through everything (just look at ~/.vimrc)

## Installation
```
cd /tmp
echo "mkdir -p ~/git
cd ~/git
sudo apt-get -y install git
git clone https://github.com/prochazo/rpi-setup
cd rpi-setup
./install.sh" > run.sh && source run.sh
```

## Backuping RPI's SD card
- [https://raspberrypi.stackexchange.com/questions/311/how-do-i-backup-my-raspberry-pi](https://raspberrypi.stackexchange.com/questions/311/how-do-i-backup-my-raspberry-pi)
- [https://github.com/framps/raspiBackup](https://github.com/framps/raspiBackup)
