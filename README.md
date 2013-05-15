vim-fish
========

This is an addon for Vim providing support for editing [fish][] scripts.

[fish]: https://github.com/fish-shell/fish-shell

Features aplenty
----------------

* Syntax highlighting if you have `:syntax enable`.
* Filetype detection if you have `:filetype on`.
* Automatic indentation based on keywords for control structures if you have
  `:filetype indent on`.
* Automatic folds for everything that `end` terminates in fish if you have
  `:filetype plugin on`.
* Code formatting with `fish_indent` using the `gq` operator if you have
  `:filetype plugin on`.
* Jumping to file in fish's function path that defines the function under the
  cursor using the `gf` command if you have `:filetype plugin on`.
* Searching for definitions including sourced files using commands like `[i` if
  you have `:filetype plugin on`.
* Keyword lookup that includes pages for fish builtins using the `K` command if
  you have `:filetype plugin on`.
* Completions from fish using the `^X^O` command if you have `:filetype plugin
  on`.
* Improved `funced` experience to instantly start typing commands in the
  function body if you have `:filetype on`.
* Automatic formatting of comments if you have `:filetype plugin on`.
  Optionally you can set `textwidth` to something non-zero to have comments
  wrapped when they're too long, or even `formatoptions+=a` to have whole
  paragraphs in comments reformatted on the fly.  This is either glorious or
  obnoxious depending on whether your comments are prose or something that
  needs careful formatting, such as code, so it's not set for you by default.

A team player
-------------

*vim-fish* ships with:

* Code snippets for [UltiSnips][]
* A syntax checker for [Syntastic][]
* Insertion rules for [endwise][]
* Configuration for [commentary][]
* Patterns for [matchit][]

But you don't have to install any of those to use this addon.

[UltiSnips]: https://github.com/SirVer/ultisnips
[Syntastic]: https://github.com/scrooloose/syntastic
[endwise]: https://github.com/tpope/vim-endwise
[commentary]: https://github.com/tpope/vim-commentary
[matchit]: http://www.vim.org/scripts/script.php?script_id=39

Teach a Vim to fish…
--------------------

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
