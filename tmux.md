# Configuration for tmux

Required:

 - tmux 2.7+
 - xclip (this is for X, sorry)
 - requires a powerline compatible font (tip: install `fonts-powerline` in Debian/Ubuntu)

This is not vim related, but I find it very useful so I like to keep it with my
vim conf.

Link you tmux.conf to the version here with:

```
ln -s ~/.vim/tmux.conf ~/.tmux.conf
```

Run tmux with `-u2`, or add an alias to your `~/.bashrc`:

```
alias tmux="TERM=tmux-256color tmux -u2"
```

