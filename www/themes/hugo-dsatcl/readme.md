# Hugo Starter Theme with Tailwind CSS

Starter files for a Hugo theme with Tailwind CSS.

- set up to use [Tailwind CSS](https://tailwindcss.com) - v1.2
- use [Hugo Pipes](https://gohugo.io/hugo-pipes/) to build and load css based on `dev` or `build` environment
- purge unused css classes with [PurgeCSS](https://www.purgecss.com) for `build`, but __not__ in `dev`
- works as separate theme repo or as a local theme folder within a Hugo site
- basic template setup with an index page, an about page and a posts category
- responsive navigation header with minimal javascript to hide the nav on small screens
- to keep that s***er down, the theme features a sticky footer

Live long and code.

## Prerequisites

Make sure to install `postcss-cli` and `autoprefixer` globally in your environment, as Hugo Pipe’s PostCSS requires it. This is mentioned in the [Hugo Docs](https://gohugo.io/hugo-pipes/postcss/).

```bash
npm install -g postcss-cli
npm install -g autoprefixer
```

## Basic usage to develop a separate Theme repo

- clone and rename the repo

```bash
git clone https://github.com/dirkolbrich/hugo-theme-tailwindcss-starter new-theme-name
```

- to make that theme your own, switch into the newly created folder, remove the git history from this starter repo and initiate a new git repo

```bash
cd new-theme-name
rm -rf .git
git init
```

- now install the necessary node packages

```bash
npm install
```

- edit the `config.toml` file in `exampleSite/` to reflect the `new-theme-name`

```toml
# in config.toml
theme = "new-theme-name" # your new theme name here
```

- start a server to develop with `exampleSite`

```bash
hugo server -s exampleSite --themesDir=../.. --disableFastRender
```

## Usage directly within a Hugo repo as a theme package

- start a new Hugo site

```bash
hugo new site new-site
```

- switch into the theme folder an clone the starter repo

```bash
cd new-site/themes
git clone https://github.com/dirkolbrich/hugo-theme-tailwindcss-starter new-theme-name
```

- switch into the newly created theme folder, remove the git history from this starter repo and install the node packages

```bash
cd new-theme-name
rm -rf .git
npm install
```

- edit the `config.toml` file in `new-site/` to reflect the new-theme-name

```toml
# in config.toml
theme = "new-theme-name" # your new theme name here
```

- switch to the root of the new-site repo and start a server to view the index site

```bash
cd new-site
hugo server --disableFastRender
```

Your content should go into `new-site/content`, the development of the site layout is done within `new-site/themes/new-theme-name/layout`.

## How does that work anyway

This theme setup uses two separate `postcss.config.js` files as a configuration used by the Hugo PostCSS Pipe. One for `dev` and one for `build`. Based on these config files, PostCSS builds the `styles.css` for the site. This snippet is located in `/layouts/partials/head.html` and is.

```html
{{ if .Site.IsServer }}
    {{ $style := resources.Get "css/styles.css" | postCSS (dict "config" "./assets/css/dev/postcss.config.js") }}
    <link rel="stylesheet" href="{{ $style.Permalink }}">
{{ else }}
    {{ $style := resources.Get "css/styles.css" | postCSS (dict "config" "./assets/css/postcss.config.js") | minify | fingerprint }}
    <link rel="stylesheet" href="{{ $style.Permalink }}" integrity="{{ $style.Data.Integrity }}">
{{ end }}
```

The `dev` config only pulls the `tailwind` package and uses `autoprefixer` on it, while the `build` config also uses `purgecss` on the resulting `tailwind` css classes, to keep the file size minimal.

## Reference

See the Hugo forum discussion "[Regenerating assets directory for Hugo Pipes](https://discourse.gohugo.io/t/regenerating-assets-directory-for-hugo-pipes-solved/13175)" for the functionality concept.
