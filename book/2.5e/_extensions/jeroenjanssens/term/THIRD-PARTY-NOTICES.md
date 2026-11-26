# Third-party notices

quarto-term is licensed under the MIT License (see `LICENSE`). This
extension also contains, or loads, the following third-party work.

## JetBrains Mono

`JetBrainsMono-Regular.subset.woff2` and `JetBrainsMono-Bold.subset.woff2`
are subsets of [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono),
Copyright 2020 The JetBrains Mono Project Authors, licensed under the SIL Open
Font License, Version 1.1 (see `OFL.txt`).

## Termshow player

`termshow-player.js` and `termshow-player.css` are from
[Great Docs](https://github.com/posit-dev/great-docs), licensed under the MIT
License:

```
MIT License

Copyright (c) 2026 Posit Software, PBC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## asciinema player

The `term-player` shortcode loads the
[asciinema player](https://github.com/asciinema/asciinema-player) from the
jsDelivr CDN to play `.cast` recordings. It's licensed under the Apache License
2.0 and isn't included in this extension.

## Colorschemes

The files in `themes/` use the colors of the color schemes they're named after
(for example Catppuccin, Dracula, Nord, Solarized, and Tokyo Night). Thanks to
their authors.

## The quarto-term binary

The binary that this extension downloads from the GitHub release is built
from Rust crates such as [avt](https://github.com/asciinema/avt) and
[portable-pty](https://github.com/wezterm/wezterm). Their licenses are in
`THIRD-PARTY-LICENSES.md`, which is attached to every release.
