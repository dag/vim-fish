vim-fish
========

This is an addon for Vim providing support for editing [fish][] scripts.

[fish]: https://github.com/fish-shell/fish-shell

Features aplenty
----------------

* Syntax highlighting and filetype detection, of course.
* Automatic indentation based on keywords for control structures.
* Automatic folds for everything that `end` terminates in fish.
* Code formatting with `fish_indent` using the `gq` operator.
* Jumping to file in fish's function path that defines the function under the
  cursor using the `gf` command.
* Searching for definitions including sourced files using commands like `[i`.
* Keyword lookup that includes pages for fish builtins using the `K` command.
* Completions from fish using the `^X^O` command.
* Syntax checking with quickfix using the `:make` command.
* Improved `funced` experience to instantly start typing commands in the
  function body.
* Mimics `funced` when manually creating new functions.
* Automatic formatting of comments.

For everything above to work you need to have fish installed in `$PATH` and
some Vim features turned on:

```vim
syntax enable
filetype plugin indent on

" Set up :make to use fish for syntax checking.
compiler! fish

" Set this to have long lines wrap inside comments.
set textwidth=79

" Like above, but also format whole paragraphs inside comments live.
" This is great for prose, but obnoxious if you're trying to type something
" like code inside a comment.
set formatoptions+=a

" Use this if you want folds to start out closed, or set it to 1 if you want to
" see the gist of top-level blocks (such as function definitions).
set foldlevelstart=0

" If you don't like every little thing folded, experiment with this setting to
" only fold larger blocks.
set foldminlines=5
```

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
and then `fg` in fish to get back to Vim.
