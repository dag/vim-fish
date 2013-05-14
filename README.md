vim-fish
========

This is an addon for Vim providing filetype support for [fish][] scripts.  In
addition to the normal Vim features such as syntax highlighting, automatic
indentation, reformatting, keyword lookup and filetype detection, this addon
includes support for the third-party addons [UltiSnips][], [Syntastic][],
[endwise][] and [commentary][] as well as the standard *matchit* addon when any
of those are installed.

Bonus feature: if you use Vim with `funced` in fish, Vim will enter Insert mode
at the end of the last line inside the function, after indenting it once if
it's empty.  This means you can instantly start typing the body of new
functions, and quickly add new statements to existing functions.

[fish]: https://github.com/fish-shell/fish-shell
[UltiSnips]: https://github.com/SirVer/ultisnips
[Syntastic]: https://github.com/scrooloose/syntastic
[endwise]: https://github.com/tpope/vim-endwise
[commentary]: https://github.com/tpope/vim-commentary


Using fish with Vim
-------------------

Vim needs a more POSIX compatible shell than fish for certain functionality to
work, such as `:%!`, compressed help pages and many third-party addons.  If you
use fish as your login shell or launch Vim from fish, you need to set `shell`
to something else in your `~/.vimrc`, for example:

```vim
if &shell =~# 'fish$'
    set shell=sh
endif
```

Best do it somewhere at the top, before any addon code is loaded and executed.

Note that this also affects what `:sh[ell]` launches, so if you care about that
you might want to set it to your second best shell instead.  If you use Vim in
the terminal you could also train yourself to use `:st[op]` or CTRL-Z instead
and use `fg` in fish to get back to Vim.
