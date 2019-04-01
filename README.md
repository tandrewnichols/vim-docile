# Vim-Docile

Make it less painful to write help docs for your vim plugins.

## Overview

Most agree that documentation is the worst part of building any tool. In vim, it's especially tedious because of the community accepted formatting standards (things like textwidth, concealed characters, correctly linking to existing help entries, etc.). I got tired of all that, so I wrote some simple tools to make it simpler. There's quick toggling between `help` and `text` filetypes to reveal concealed characters, paragraph alignment, quick `colorcolumn` toggling, and the ability to add new headers and help references. For reference, I also use [vim-projectionist](https://github.com/tpope/vim-projectionist) to scaffold my main help file quickly. You can see that scaffolding [here](https://github.com/tandrewnichols/dotstar/blob/master/.vim/settings/projectionist.vim#L48-L165).

## Installation

If you don't have a preferred installation method, I really like vim-plug and recommend it.

#### Manual

Clone this repository and copy the files in plugin/, autoload/, and doc/ to their respective directories in your vimfiles, or copy the text from the github repository into new files in those directories. Make sure to run `:helptags`.

#### Plug (https://github.com/junegunn/vim-plug)

Add the following to your vimrc, or something sourced therein:

```vim
Plug 'tandrewnichols/vim-docile'
```

Then install via `:PlugInstall`

#### Vundle (https://github.com/gmarik/Vundle.vim)

Add the following to your vimrc, or something sourced therein:

```vim
Plugin 'tandrewnichols/vim-docile'
```

Then install via `:BundleInstall`

#### NeoBundle (https://github.com/Shougo/neobundle.vim)

Add the following to your vimrc, or something sourced therein:

```vim
NeoBundle 'tandrewnichols/vim-docile'
```

Then install via `:BundleInstall`

#### Pathogen (https://github.com/tpope/vim-pathogen)

```sh
git clone https://github.com/tandrewnichols/vim-docile.git ~/.vim/bundle/vim-docile
```

## Usage

I've used the `do` prefix for mappings with the assumption that it's _probably_ unused (except in diff files) and _sort of_ maps to "doc." However, if you don't like the mappings, you can supply your own or even prevent them from being mapped altogether and just use commands. The following commands are available within files with filetypes `help` and `text`.

### :DocileToggle

Change the filetype between `help` and `text`. Mapped by default to `dot` (doc toggle). Override this with `g:docile_toggle_mapping`. Setting this option, or any of the mapping options, to an empty string will prevent the creation of that map.

### :DocileHelpGuide

Toggle `colorcolumn` between 80 and off. By default, colorcolumn is set to `red`, but you can override that by setting `g:docile_color_column`. Mapped by default to `dog` (doc guide). Override this with `g:docile_help_guide_mapping`.

### :DocileFormatParagraph

Vim actually does a pretty good job wrapping text and formatting help, and even when it doesn't `gq$` or `gqip` can fix it most of the time. The one time it _doesn't seem_ to get fixed right is when you want an identifier to the left (like a function name) and a paragraph description to the right. Vim won't wrap the paragraph to the same column because of the identifier on the left. This command, mapped by default to `do=` (doc format), turns something like this:

```vim
docile#foo()                    This descriptive paragraph will be wrapped by
vim, but as you can see, it doesn't align successive lines with the initial
paragraph column because of the function name on the left.
```

into this:

```vim
docile#foo()                    This descriptive paragraph will be wrapped by
                                vim, but as you can see, it doesn't align
                                successive lines with the initial paragraph
                                column because of the function name on the left.
```

You can override the mapping for this command with `g:docile_format_mapping`.

### :DocileAddHeader[!] {header} [ref]

Add a header, with text on the left, and a vim help reference on the right. The help reference will be auto prefixed with the basename of the help file plus `-`. That is, if you're writing banana.txt, this will generate `*banana-[ref]*`. You can turn off this behavior by setting `g:docile_use_plugin_refs` to `0`, in which case `[ref]` will be used as provided. If `[ref]` is not provided, `{header}` will be lower-cased and used instead. When `!` is provided, `{header}` will be upper cased. By default, `[ref]` will be positioned in column 50. You can change this by setting `g:docile_ref_column`. This command is mapped to `doh` and is configurable via `g:docile_add_header_mapping`. Since this command takes arguments, this mapping simply prepopulates the command line with `:DocileAddHeader `.

#### Examples

Command: `:DocileAddHeader Version`

Output:

```vim
Version                                          *pluginname-version*
```

Command: `:DocileAddHeader! version`

Output:

```vim
VERSION                                          *pluginname-version*
```

Command: `:DocileAddHeader Version banana`

```vim
Version                                          *pluginname-banana*
```

### :DocileAddRef

Like `:DocileAddHeader` but with only the help reference on the right. You can pass multiple headers here, for instance if you alias several commands to the same thing, e.g.:

`:DocileAddRef :FooSplit :FooSp`

```vim
                                                 *pluginname-:FooSplit*
                                                 *pluginname-:FooSp*
```

As with `:DocileAddHeader`, the basename of the help file will be prepended to each reference and offset by 50 (or the value of `g:docile_ref_column`). Both `:DocileAddHeader` and `:DocileAddRef` open a new line after their additions. `:DocileAddRef` is mapped to `dor` and is configurable via `g:docile_add_ref_mapping`.

## Contributing

I always try to be open to suggestions, but I do still have opinions about what this should and should not be so . . . it never hurts to ask before investing a lot of time on a patch.

## License

See [LICENSE](./LICENSE)
